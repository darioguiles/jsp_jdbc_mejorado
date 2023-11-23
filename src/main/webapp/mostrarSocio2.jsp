<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mostrar Socio</title>
    <link rel="stylesheet" type="text/css" href="estilos.css" />

</head>
<body>

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","user", "user");

    String parametro = request.getParameter("numero");
    int numero = Integer.parseInt(parametro);
    String sql = "SELECT * FROM socio WHERE socio.socioID = " + numero;

    PreparedStatement ps = conexion.prepareStatement(sql);
    ResultSet listado = ps.executeQuery();

%>

    <table>
        <tr><th>Código</th><th>Nombre</th><th>Estatura</th><th>Edad</th><th>Localidad</th></tr>
        <%
            while (listado.next()) {
                out.println("<tr><td>");
                out.println(listado.getString("socioID") + "</td>");
                out.println("<td>" + listado.getString("nombre") + "</td>");
                out.println("<td>" + listado.getString("estatura") + "</td>");
                out.println("<td>" + listado.getString("edad") + "</td>");
                out.println("<td>" + listado.getString("localidad") + "</td>");
        %>

    <%
        }
            // Cerrar el ResultSet y otros recursos después de su uso
            listado.close();

        conexion.close();
    %>
</table>

<a href="index.jsp">Volver a la pagina principal</a>

</body>
</html>