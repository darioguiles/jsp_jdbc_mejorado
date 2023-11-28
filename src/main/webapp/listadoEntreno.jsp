<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos.css" />
</head>
<body>
<a href="index.jsp">Volver atrás</a>

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","user", "user");
    Statement s = conexion.createStatement();

    ResultSet listado = s.executeQuery ("SELECT * FROM entrenamiento");
%>
<table>
    <tr><th>Código</th><th>Tipo</th><th>Ubicacion</th><th>Fecha</th></tr>
    <%
        while (listado.next()) {
            out.println("<tr><td>");
            out.println(listado.getString("entrenoID") + "</td>");
            out.println("<td>" + listado.getString("tipoEntreno") + "</td>");
            out.println("<td>" + listado.getString("ubicacion") + "</td>");
            out.println("<td>" + listado.getString("fecha") + "</td>");
    %>
    <td>
        <form method="get" action="borraEntreno.jsp">
            <input type="hidden" name="codigoE" value="<%=listado.getString("entrenoID") %>"/>
            <input type="submit" value="borrar">
        </form>
    </td></tr>
    <%
        } // while
        conexion.close();
    %>
</table>
</body>
</html>