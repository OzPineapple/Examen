<%-- 
    Document   : AgregarItem
    Created on : 1/06/2018, 04:47:16 PM
    Author     : Alumno
--%>

<%@page import="Clases.Item"%>
<%@page import="Dao.UsuarioDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Item</title>
    </head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <body>
        <%
            Cookie[] ck = request.getCookies();
            String tipo="";
            int id_tipo=0;
            if (ck.length!=4) {
                response.sendRedirect("index.jsp");
            }
            else{
                for (Cookie cke:ck) {
                    if (cke.getName().equals("id_tipo")) {
                        tipo = cke.getValue();
                        id_tipo=Integer.parseInt(tipo);
                        if (id_tipo==1) {
                        }
                        else if (id_tipo==2) {
                            response.sendRedirect("Carrito.jsp");
                        }
                        else{
                            response.sendRedirect("error.jsp");
                        }
                    }
                }
        %>
                    <div class="container">
                        <form method="post" action="AgregarItem">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <td><input type="text" maxlength="50" name="item" placeholder="Nombre" style="width: 40%; border-color: gainsboro;" pattern="^[a-zA-Z0-9]+(([ ][a-zA-Z0-9])?[a-zA-Z0-9]*)*$" required></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>Cantidad</th>
                                        <td><input type="number" name="cant" min="1" value="1" max="2147483647" maxlength="10" placeholder="Cantidad" style="width: 40%; border-color: gainsboro;"></td>
                                    </tr>
                                    <tr>
                                        <th>Costo Unitario</th>
                                        <td>$ <input type="number" step=".01" placeholder="Costo" name="costo" min="0.1" max="1000000" maxlength="7" style="width: 40%; border-color: gainsboro;" required></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <button type="submit" class="btn btn-default btn-sm">
                                            <span class="glyphicon glyphicon-ok"></span> Ok</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
        <%
                }
        %>
        <script>
            $(document).ready(function () {
                    function enforce_maxlength(event) {
                        var t = event.target;
                        if (t.hasAttribute('maxlength')) {
                            t.value = t.value.slice(0, t.getAttribute('maxlength'));
                        }
                    }
                    document.body.addEventListener('input', enforce_maxlength);
                });
        </script>
    </body>
</html>