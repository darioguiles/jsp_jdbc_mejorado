<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int numero = -1;
    String tipoEntreno = null;
    String ubicacion = null;
    String fecha = null;
    //Booleanos que controlan flags de nuestro formulario, así controlamos excepciones y damos un mensaje de error en session.
    boolean flagValidaNum = false;
    boolean flagUbicacionNull= false;
    boolean flagUbicacionBlank = false;
    boolean flagValidaFechaNull = false;
    boolean flagValidaFechaBlank = false;
    boolean flagValidaTipoEntrenoNull = false;
    boolean flagValidaTipoEntrenoBlank = false;

    try {
        numero = Integer.parseInt(request.getParameter("numero"));
        flagValidaNum = true;

        Objects.requireNonNull(request.getParameter("ubi"));
        flagUbicacionNull=true;

        if (request.getParameter("ubi").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagUbicacionBlank=true;
        ubicacion = request.getParameter("ubi");

        //Validacion de tipoEntreno
        Objects.requireNonNull(request.getParameter("tipoEntreno"));
        flagValidaTipoEntrenoNull=true;

        if (request.getParameter("tipoEntreno").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaTipoEntrenoBlank = true;
        tipoEntreno = request.getParameter("tipoEntreno");

        Objects.requireNonNull(request.getParameter("fecha"));
        flagValidaFechaNull = true;

        if (request.getParameter("fecha").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaFechaBlank = true;
        fecha = request.getParameter("fecha");

    } catch (Exception ex) {
        ex.printStackTrace();
        valida = false;

        if (!flagValidaNum)
        {
            session.setAttribute("errorEntreno","Error en número");
        }
        else if (!flagUbicacionNull || !flagUbicacionBlank)
        {
            session.setAttribute("errorEntreno","Error en ubicacion, campo vacío o todo espacio blanco");
        }
        else if (!flagValidaTipoEntrenoNull || !flagValidaTipoEntrenoBlank) {
            session.setAttribute("errorEntreno", "Error en tipo de entrenamiento, campo vacío o no seleccionado");
        }
        else if (!flagValidaFechaNull || !flagValidaFechaBlank)
        {
            session.setAttribute("errorEntreno","Error en fecha, campo vacío o todo espacio blanco");
        }

    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
// 	ResultSet rs = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "user", "user");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<

            String sql = "INSERT INTO entrenamiento VALUES ( " +
                    "?, " + //entrenoID
                    "?, " + //tipoEntreno
                    "?, " + //ubicacion
                    "?)"; //fecha

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setInt(idx++, numero);
            ps.setString(idx++, tipoEntreno);
            ps.setString(idx++, ubicacion);
            ps.setString(idx++, fecha);

            int filasAfectadas = ps.executeUpdate();
            System.out.println("Entrenamiento GRABADO:  " + filasAfectadas);


        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

        out.println("Entrenamiento creado.");
    } else {
        //out.println("Error de validación!");
        //Mandamos la redirección
        response.sendRedirect("añadirEntreno.jsp");
    }
%>

</body>
</html>
