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

    ResultSet listado = s.executeQuery ("SELECT * FROM juego.partido");
%>
<table>
    <tr><th>ID</th><th>E1</th><th>PtsE1</th><th>E2</th><th>Pts E2</th><th>Fecha</th><th>Tipo Partido</th></tr>
    <%
        while (listado.next()) {
            out.println("<tr><td>");
            out.println(listado.getString("id") + "</td>");
            out.println("<td>" + listado.getString("equipo1") + "</td>");
            out.println("<td>" + listado.getString("puntos_equipo1") + "</td>");
            out.println("<td>" + listado.getString("equipo2") + "</td>");
            out.println("<td>" + listado.getString("puntos_equipo2") + "</td>");
            out.println("<td>" + listado.getString("fecha") + "</td>");
            out.println("<td>" + listado.getString("tipo_partido") + "</td>");

    %>
    <td>
        <form method="get" action="borraPartido.jsp">
            <input type="hidden" name="codigo" value="<%=listado.getString("id") %>"/>
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