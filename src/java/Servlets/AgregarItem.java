package Servlets;

import Clases.Item;
import Dao.UsuarioDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AgregarItem extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("error2.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            Cookie[] ck = request.getCookies();
            String item=request.getParameter("item");
            String cant=request.getParameter("cant");
            String cost=request.getParameter("costo");
            int cantidad=0;
            double costo=0;
            String tipo="";
            int id_tipo=0;
            try{
                cantidad=Integer.parseInt(cant);
                costo=Double.parseDouble(cost);
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
                Item e = new Item();
                e.setItem(item);
                e.setStock(cantidad);
                e.setCosto(costo);
                int estatus=UsuarioDao.AgregarItem(e);
                if (estatus>0) {
                    response.sendRedirect("AdminCarro.jsp");
                }
                else{
                    response.sendRedirect("error.jsp");
                }
                
            }
            catch(Exception ex){
                response.sendRedirect("error2.jsp");
            }
    }
}
