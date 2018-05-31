<%-- 
    Document   : index
    Created on : 26/05/2018, 10:36:48 AM
    Author     : Sarge
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio</title>
    </head>
    <%
        Cookie[] ck = request.getCookies();
        if (ck!=null) {
            if (ck.length==4) {
                response.sendRedirect("Carrito.jsp");
            }
            else{
            String tipo;
            int id_tipo=0;
            System.out.println(ck.length);
            for (Cookie cke:ck) {
                if (cke.getName().equals("id_tipo")) {
                    tipo = cke.getValue();
                    id_tipo=Integer.parseInt(tipo);
                    if (id_tipo==1) {
                        response.sendRedirect("AdminCarro.jsp");
                    }
                    else if (id_tipo==2) {
                        response.sendRedirect("Carrito.jsp");
                    }
                    else{
                        response.sendRedirect("error.html");
                    }
                }
            }
            }
        }
    %>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <body>
        <form method="post" action="LogIn">
            Nombre de usuario: <input type="text" title="Solo caracteres alfanumericos" minlength="2" maxlength="40" name="user" required><br>
            Contraseña: <input type="password" title="Solo caracteres alfanumericos" minlength="8" maxlength="20" name="pass" required><br>
            <button type="submit"><i class="material-icons">input</i></button>
        </form>
        <br>
        <form method="post" action="RegUs.jsp">
            <button type="submit">Registarme <i class="fa fa-user-plus" style="font-size:20px"></i></button>
        </form>
    </body>
</html>
