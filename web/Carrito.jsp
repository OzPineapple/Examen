<%-- 
    Document   : Carrito
    Created on : 26/05/2018, 12:38:13 PM
    Author     : Sarge
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Clases.Item"%>
<%@page import="Clases.Carro"%>
<%@page import="Dao.UsuarioDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrito</title>
    </head>
    <style>
    </style>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
            <body>
                <h1 align="center">Bienvenido <%=user%></h1>
                <div align="right">
                    <form method="post" action="VerCarro.jsp">
                        <button type="submit" class="btn btn-primary"><i class="material-icons">shopping_cart</i> <span class="badge"><%if(carro==null){%>0<%}else{%><%=carro.size()%><%}%></span></button>
                    </form>
                    <form method="post" action="LogOut">
                        <button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-log-out"></span> Cerrar Sesion</button>
                    </form>
                </div>
                <%
                    List<Item> items=UsuarioDao.getAllItems1();
                    if (items.size()>0) {
                %>
                    <table>
                        <tr>
                            <th>Producto</th>
                            <th>Stock</th>
                            <th>Costo Por Pieza</th>
                        </tr>
                        <%
                            for(Item i:items){
                        %>
                                <tr>
                                    <td><%=i.getItem()%></td>
                                    <td align="center"><%=i.getStock()%></td>
                                    <td align="center">$ <%=i.getCosto()%></td>
                                    <td align="right">
                                    <%
                                        if(i.getStock()>0){
                                    %>
                                            <form method="post" action="VerItem.jsp"><input type="hidden" name="id" value="<%=i.getId_item()%>"><button type="submit" class="btn btn-default btn-sm"><i class="material-icons">attach_money</i></button></form>
                                    <%
                                        }
                                    %>
                                    </td>
                                </tr>
                        <%
                            }
                        %>
                    </table>
                <%
                    }
                    else{
                %>
                        No existe nada en el inventario
                <%
                    }
                %>
            </body>
    <%
        }
    %>
</html>
