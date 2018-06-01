<%-- 
    Document   : AdminCarro
    Created on : 1/06/2018, 03:03:31 AM
    Author     : Sarge
--%>

<%@page import="Clases.Item"%>
<%@page import="java.util.List"%>
<%@page import="Dao.UsuarioDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrito de compras</title>
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
            <body>
                <h1 align="center">Bienvenido <%=user%></h1>
                <div align="right">
                    <form method="post" action="AgregarItem.jsp">
                        <button type="submit" class="btn btn-default btn-sm">Agregar Producto<i class="material-icons">add</i></button>
                    </form>
                    <form method="post" action="LogOut">
                        <button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-log-out"></span> Cerrar Sesion</button>
                    </form>
                </div>
                <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Buscar...">
                <%
                    List<Item> items=UsuarioDao.getAllItems();
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
                            int in=0;
                            for(Item i:items){
                                in++;
                                int max=16777215-i.getStock();
                                String max2=String.valueOf(max);
                                int maxlength=max2.length();
                        %>
                                <tr>
                                    <td><%=i.getItem()%></td>
                                    <td align="center">
                                        <%=i.getStock()%>
                                        <button type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#stock<%=in%>"><i class="material-icons">add</i></button>
                                        <div id="stock<%=in%>" class="collapse">
                                            <form method="post" action="AgrStock">
                                                <input type="hidden" name="id" value="<%=i.getId_item()%>">
                                                <input type="number" maxlength="<%=maxlength%>" placeholder="Agregar al stock" name="cant" min="1" max="<%=max%>" required>
                                                <button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-ok"></span> Ok</button>
                                            </form>
                                        </div>
                                    </td>
                                    <td align="center">
                                        $ <%=i.getCosto()%>
                                        <button type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#costo<%=in%>"><i class="material-icons">edit</i></button>
                                        <div id="costo<%=in%>" class="collapse">
                                            <form method="post" action="EditCosto">
                                                <input type="hidden" name="id" value="<%=i.getId_item()%>">
                                                $<input type="number" step=".01" placeholder="Nuevo costo" name="costo" min="0.1" max="1000000" maxlength="7" required>
                                                <button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-ok"></span> Ok</button>
                                            </form>
                                        </div>
                                    </td>
                                    <td align="right">
                                    <%
                                        if(i.getStock()<=0){
                                    %>
                                            <form method="post" action="ElimItem.jsp"><input type="hidden" name="id" value="<%=i.getId_item()%>"><button type="submit" class="btn btn-default btn-sm"><i class="material-icons">close</i></button></form>
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
</html>
