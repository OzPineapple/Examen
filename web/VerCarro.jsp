<%-- 
    Document   : VerCarro
    Created on : 31/05/2018, 09:50:36 AM
    Author     : Sarge
--%>

<%@page import="Clases.Item"%>
<%@page import="Dao.UsuarioDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Clases.Carro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mi Carrito</title>
    </head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <body>
        <%
            Cookie[] ck = request.getCookies();
            HttpSession sesion = request.getSession();
            List<Carro> carro = new ArrayList<Carro>();
            if (ck==null) {
                response.sendRedirect("index.jsp");
            }
            else if (ck.length!=4) {
                response.sendRedirect("index.jsp");
            } 
            else{
                String user,us,tipo;
                user="";
                us="";
                tipo="";
                int id_tipo=0;
                int id_us=0;
                for (Cookie cke:ck) {
                    if (cke.getName().equals("id_us")) {
                        us = cke.getValue();
                        id_us=Integer.parseInt(us);
                    }
                    if (cke.getName().equals("user")) {
                        user = cke.getValue();
                    }
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
                carro=(ArrayList)sesion.getAttribute("carro");
        %>
                <%
                    if(carro==null || carro.size()==0){
                %>
                    No hay ningun producto en su carrito
                <%
                    }  
                    else{
                %>
                        <table class="table">
                            <thead>
                            <tr>
                                <th>Producto</th>
                                <th style="text-align: center;">Cantidad</th>
                                <th style="text-align: center;">Costo Unitario</th>
                                <th style="text-align: center;">Suma</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                <%
                            double total=0;
                            for (Carro e:carro) {
                                Item item=new Item();
                                item=UsuarioDao.getVItem(e.getId_item());
                %>
                <tr>
                    <td><%=e.getItem()%></td>
                    <td align="center"><%=e.getCantidad()%></td>
                    <td align="center">$ <%=item.getCosto()%></td>
                    <td align="center">$ <%=e.getCantidad()*item.getCosto()%></td>
                    <%total=total+e.getCantidad()*item.getCosto();%>
                    <td>
                        <form method="post" action="EliminarDeMiCarrito">
                            <input type="hidden" name="index" value="<%=carro.indexOf(e)%>">
                            <button type="submit" class="btn btn-default btn-sm">Eliminar de mi carrito <span class="glyphicon glyphicon-trash"></span></button>
                        </form>
                    </td>
                </tr>
                <%
                            }
                %>
                <tr>
                    <td></td>
                    <td></td>
                    <td align="right"><b>Total</b></td>
                    <td align="center">$ <%=total%></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <form method="post" action="FinalizarCompra">
                            <button type="submit" class="btn btn-default btn-sm">Finalizar compra <i class="material-icons">attach_money</i></button>
                        </form>
                    </td>
                </tr>
                        </tbody>
                        </table>
                <%
                    }
                %>
        <%
            }
        %>
    </body>
</html>
