<%-- 
    Document   : VerItem
    Created on : 26/05/2018, 09:10:41 PM
    Author     : Sarge
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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <body>
        <%
            String id=request.getParameter("id");
            Cookie[] ck = request.getCookies();
            HttpSession sesion = request.getSession();
            int id_item=0;
            String tipo="";
            int id_tipo=0;
            try{
                id_item=Integer.parseInt(id);
            if (ck.length!=4) {
                response.sendRedirect("index.jsp");
            }
            else{
                for (Cookie cke:ck) {
                    if (cke.getName().equals("id_tipo")) {
                        tipo = cke.getValue();
                        id_tipo=Integer.parseInt(tipo);
                        if (id_tipo==1) {
                            response.sendRedirect("AdminCarro.jsp");
                        }
                        else if (id_tipo==2) {
                        }
                        else{
                            response.sendRedirect("error.jsp");
                        }
                    }
                }
                Item e=UsuarioDao.getVItem(id_item);
                if (e.getItem()==null) {
                    response.sendRedirect("error2.jsp");
                }
                else if(e.getStock()<1){
                    response.sendRedirect("Carrito.jsp");
                }
                else{
        %>
                    <div class="container">
                        <form method="post" action="AgregarAlCarrito">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th colspan="2" align="center"><%=e.getItem()%></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Cantidad</td>
                                        <td><input type="number" name="cant" min="1" value="1" max="<%=e.getStock()%>" placeholder="Cantidad" style="width: 100px; border-color: gainsboro;"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <input type="hidden" name="id" value="<%=e.getId_item()%>">
                                            <button type="submit" class="btn btn-default btn-sm">Agregar a mi carrito<span class="glyphicon glyphicon-ok"></span></button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
        <%
                }
            }
            }
            catch(Exception ex){
                response.sendRedirect("error2.jsp");
            }
        %>
    </body>
</html>
