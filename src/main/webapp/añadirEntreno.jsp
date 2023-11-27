<%--
  Created by IntelliJ IDEA.
  User: darioguiles
  Date: 27/11/23
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Introduzca los datos del nuevo socio:</h2>
<form method="get" action="grabaEntreno.jsp">
    Nº Entreno <input type="text" name="numero"/></br>
    Tipo entreno <select name="select">
    <option value="value1">físico</option>
    <option value="value2" selected>técnico</option>
</select>
    </br>
    Ubicacion <input type="text" name="ubi"/></br>
    Fecha <input type="text" name="fecha"/></br>
    <input type="submit" value="Aceptar">
</form>
<%
    String error = (String) session.getAttribute("errorEntreno");
    if (error!=null)
    {

%>
<span style="color:red"><%=error%><span>
        <%
    session.removeAttribute("errorEntreno");
      }
  %>
</body>
</html>
</html>
