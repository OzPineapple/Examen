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

public class EditCosto extends HttpServlet {
@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("error2.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            Cookie[] ck = request.getCookies();
            String id=request.getParameter("id");
            String cost=request.getParameter("costo");
            int id_item=0;
            String tipo="";
            double costo=0;
            int id_tipo=0;
            try{
                id_item=Integer.parseInt(id);
                costo=Double.parseDouble(cost);
                Item e=UsuarioDao.getItem(id_item);
                if (e.getItem()==null) {
                    response.sendRedirect("error2.jsp");
                }
                else if(e.getStock()<1){
                    response.sendRedirect("AdminCarro.jsp");
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
                    int estatus=UsuarioDao.changeCostoItem(costo, id_item);
                    if (estatus>0) {
                        response.sendRedirect("AdminCarro.jsp");
                    }
                    else{
                        response.sendRedirect("error.jsp");
                    }
                }
                
            }
            catch(Exception ex){
                response.sendRedirect("error2.jsp");
            }
    }
}
