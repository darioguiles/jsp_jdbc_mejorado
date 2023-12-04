<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mostrar Socio</title>
    <link rel="stylesheet" type="text/css" href="../estilos.css" />

</head>
<body>
<h1>Detalle Socio</h1>
<%
    /*
    * HECHO lo que se ha concretado en el enunciado se cumple con estos 2 jsp 1 lee y el otro devuelve
    */
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","user", "user");
    //Guardamos el parametro numero y lo transformamos a entero

    int numero = 0;

        if(request.getParameter("numero")!=null) {
          numero = Integer.parseInt(request.getParameter("numero"));
        }
        else if (session.getAttribute("idNuevoSocio")!=null)
        {
            numero = (int) session.getAttribute("idNuevoSocio");
        }
            //Creamos nuestro sql para acceder a la tabla, buscamos que nos devuelva un socio con un ID igual al introducido
            // Y si es correcto nos devuelve toda la informacion del socio en cuestion
            String sql = "SELECT * FROM socio WHERE socio.socioID = " + numero;

            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet listado = ps.executeQuery();


%>
<table>
        <%
                //Mediante out, imprimimos el formato deseado, el cual también tiene un css para mejorar la vista

                out.println("<tr><th>Código</th><th>Nombre</th><th>Estatura</th><th>Edad</th><th>Localidad</th></tr>\n");

                while (listado.next()) { //Se sale de aqui, no entra al while para imprimir al socio, al usar un listado.next avanzamos
                    out.println("<tr><td>");
                    //Aqui vemos todos los campos que extraemos y comos los sacamos de nuestro listado
                    out.println(listado.getString("socioID") + "</td>");
                    out.println("<td>" + listado.getString("nombre") + "</td>");
                    out.println("<td>" + listado.getString("estatura") + "</td>");
                    out.println("<td>" + listado.getString("edad") + "</td>");
                    out.println("<td>" + listado.getString("localidad") + "</td>");
                }
                // Cerrar el ResultSet y otros recursos después de su uso
                listado.close();

                conexion.close();


        %>

    <%
    session.removeAttribute("idNuevoSocio");
    %>
</table>

<a href="../index.jsp">Volver a la pagina principal</a>

</body>
</html>