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
    String ubicacion = null; // correspondiente a equipo1
    String ubicacion2 = null; // correspondiente a equipo2
    int p1 = -1; //Corresponden a las puntuaciones de los equipos
    int p2 = -1;
    String fecha = null;
    //Booleanos que controlan flags de nuestro formulario, así controlamos excepciones y damos un mensaje de error en session.
    boolean flagValidaNum = false;
    boolean flagValidaP1 = false;
    boolean flagValidaP2 = false;
    boolean flagUbicacionNull= false;
    boolean flagUbicacionBlank = false;
    boolean flagUbicacion2Null= false;
    boolean flagUbicacion2Blank = false;
    boolean flagValidaFechaNull = false;
    boolean flagValidaFechaBlank = false;
    boolean flagValidaTipoEntrenoNull = false;
    boolean flagValidaTipoEntrenoBlank = false;

    try {
        numero = Integer.parseInt(request.getParameter("id"));
        flagValidaNum = true;

        p1 = Integer.parseInt(request.getParameter("puntos_equipo1"));
        flagValidaP1=true;

        p2 = Integer.parseInt(request.getParameter("puntos_equipo2"));
        flagValidaP2=true;

        Objects.requireNonNull(request.getParameter("equipo1"));
        flagUbicacionNull=true;

        if (request.getParameter("equipo1").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagUbicacionBlank=true;
        ubicacion = request.getParameter("equipo1");

        //Hay fallo aqui
        Objects.requireNonNull(request.getParameter("equipo2"));
        flagUbicacion2Null=true;

        if (request.getParameter("equipo2").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagUbicacion2Blank=true;
        ubicacion2 = request.getParameter("equipo2");


        //Validacion de tipoEntreno
        Objects.requireNonNull(request.getParameter("tipo_partido"));
        flagValidaTipoEntrenoNull=true;

        if (request.getParameter("tipo_partido").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaTipoEntrenoBlank = true;
        tipoEntreno = request.getParameter("tipo_partido");

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
            session.setAttribute("errorPartido","Error en ID");
        }
        else if (!flagUbicacionNull || !flagUbicacionBlank)
        {
            session.setAttribute("errorPartido","Error en Equipo1, campo vacío o todo espacio blanco");
        }
        else if (!flagUbicacion2Null || !flagUbicacion2Blank)
        {
            session.setAttribute("errorPartido","Error en Equipo2, campo vacío o todo espacio blanco");
        }
        else if (!flagValidaP1)
        {
            session.setAttribute("errorPartido","Error en PTEquipo1");
        }
        else if (!flagValidaP2)
        {
            session.setAttribute("errorPartido","Error en PTEquipo2");
        }
        else if (!flagValidaTipoEntrenoNull || !flagValidaTipoEntrenoBlank) {
            session.setAttribute("errorPartido", "Error en tipo de partido, campo vacío o no seleccionado");
        }
        else if (!flagValidaFechaNull || !flagValidaFechaBlank)
        {
            session.setAttribute("errorPartido","Error en fecha, campo vacío o todo espacio blanco");
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

            String sql = "INSERT INTO juego.partido VALUES ( " +
                    "?, " + //ID
                    "?, " + //fecha
                    "?, " + //e1 (ubicacion)
                    "?, " + //ptos e1
                    "?, " +
                    "?, " +
                    "?)"; //tipo partido

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setInt(idx++, numero);
            ps.setString(idx++, fecha);
            ps.setString(idx++, ubicacion); //Equipo1
            ps.setInt(idx++, p1);
            ps.setString(idx++, ubicacion2);
            ps.setInt(idx++, p2);
            ps.setString(idx, tipoEntreno);


            int filasAfectadas = ps.executeUpdate();
            System.out.println("Partido GRABADO:  " + filasAfectadas);


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

        out.println("Partido creado.");
        out.println("<a href=\"index.jsp\">Volver atrás</a>");
    } else {
        //out.println("Error de validación!");
        //Mandamos la redirección
        response.sendRedirect("partidoForm.jsp");
    }
%>

</body>
</html>
