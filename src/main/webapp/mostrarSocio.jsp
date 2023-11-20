<%@page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mostrar Socio</title>
</head>
<body>

<form method="post" action="">
    Nº socio <input type="text" name="numero"/></br>
    <input type="submit" value="Aceptar">
</form>

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","user", "user");
    Statement s = conexion.createStatement();

    ResultSet listado = s.executeQuery ("SELECT * FROM socio where socio.socioID = numero");
%>
<table>
    <tr><th>Código</th><th>Nombre</th><th>Estatura</th><th>Edad</th><th>Localidad</th></tr>
    <%
            if(){
            out.println("<tr><td>");
            out.println(listado.getString("socioID") + "</td>");
            out.println("<td>" + listado.getString("nombre") + "</td>");
            out.println("<td>" + listado.getString("estatura") + "</td>");
            out.println("<td>" + listado.getString("edad") + "</td>");
            out.println("<td>" + listado.getString("localidad") + "</td>");
    %>

    <%
        }
        conexion.close();
    %>
</table>
</body>
</html>
