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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        #myInput {
            background-image: url('css/searchicon.png'); /* Add a search icon to input */
            background-position: 10px 12px; /* Position the search icon */
            background-repeat: no-repeat; /* Do not repeat the icon image */
            width: 100%; /* Full-width */
            font-size: 16px; /* Increase font-size */
            padding: 12px 20px 12px 40px; /* Add some padding */
            border: 1px solid #ddd; /* Add a grey border */
            margin-bottom: 12px; /* Add some space below the input */
        }

        #myTable {
            border-collapse: collapse; /* Collapse borders */
            width: 100%; /* Full-width */
            border: 1px solid #ddd; /* Add a grey border */
            font-size: 18px; /* Increase font-size */
        }

        #myTable th, #myTable td {
            text-align: left; /* Left-align text */
            padding: 12px; /* Add padding */
        }

        #myTable tr {
            /* Add a bottom border to all table rows */
            border-bottom: 1px solid #ddd; 
        }

        #myTable tr.header, #myTable tr:hover {
            /* Add a grey background color to the table header and on hover */
            background-color: #f1f1f1;
        }
    </style>
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
                <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Buscar...">
                <%
                    List<Item> items=UsuarioDao.getAllItems1();
                    if (items.size()>0) {
                %>
                    <table id="myTable">
                        <tr class="header">
                            <th>Producto</th>
                            <th>Stock</th>
                            <th>Precio Unitario</th>
                            <th></th>
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
            <script>
                function myFunction() {
                  // Declare variables 
                  var input, filter, table, tr, td, i;
                  input = document.getElementById("myInput");
                  filter = input.value.toUpperCase();
                  table = document.getElementById("myTable");
                  tr = table.getElementsByTagName("tr");

                  // Loop through all table rows, and hide those who don't match the search query
                  for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[0];
                    if (td) {
                      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                      } else {
                        tr[i].style.display = "none";
                      }
                    } 
                  }
                }
            </script>
    <%
        }
    %>
</html>
