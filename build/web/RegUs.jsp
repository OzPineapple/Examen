<%-- 
    Document   : RegUs
    Created on : 26/05/2018, 03:35:25 PM
    Author     : Samara
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registarme</title>
    </head>
    <%
        Cookie[] ck = request.getCookies();
        if (ck!=null) {
            if (ck.length==4) {
                response.sendRedirect("index.jsp");
            }
        }
    %>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <body>
        <form method="post" action="RegUs2">
            Nombre de usuario: <input type="text" title="Solo caracteres alfanumericos" minlength="2" pattern="^[a-zA-Z]+(([ ][a-zA-Z])?[a-zA-Z]*)*$" title="Solo se aceptan caracteres alfabeticos" maxlength="40" name="user" required><br>
            Contraseña: <input type="password" pattern="^[a-zA-Z1-9*!@&]+([a-zA-Z1-9*!@&]+)*$" title="Solo se aceptan caracteres alfanumericos y caracteres especiales como: !, @, &, *." minlength="8" maxlength="20" name="pass" required><br>
            <button type="submit">Guardar <span class="glyphicon glyphicon-saved"></span></button>
        </form>
    </body>
</html>
