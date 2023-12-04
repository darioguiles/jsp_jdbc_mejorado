
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Introduzca los datos del nuevo socio:</h2>
<form method="get" action="grabaPartido.jsp">
    ID <input type="text" name="id"/></br>
    Tipo Partido <select name="tipo_partido">
    <option value="1">amistoso</option>
    <option value="2" selected>oficial</option>
</select>
    </br>
    Equipo 1 <input type="text" name="equipo1"/></br>
    Puntos Equipo 1 <input type="number" min="0" name="puntos_equipo1"/></br>
    Equipo 2 <input type="text" name="equipo2"/></br>
    Puntos Equipo 2 <input type="number" min="0" name="puntos_equipo2"/></br>
    Fecha <input type="text" name="fecha"/></br>
    <input type="submit" value="Aceptar">
</form>
<%
    String error = (String) session.getAttribute("errorPartido");
    if (error!=null)
    {

%>
<span style="color:red"><%=error%><span>
        <%
    session.removeAttribute("errorPartido");
      }
  %>
</body>
</html>
</html>
