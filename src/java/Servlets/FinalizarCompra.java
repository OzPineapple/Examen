package Servlets;

import Clases.Carro;
import Dao.UsuarioDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FinalizarCompra extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("error2.");
        HttpSession sesion = request.getSession();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            HttpSession sesion = request.getSession();
            Cookie[] ck = request.getCookies();
            List<Carro> carro = new ArrayList<Carro>();
            String tipo="";
            int id_tipo=0;
            try{
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
                    carro=(ArrayList)sesion.getAttribute("carro");
                    if (carro.size()>0) {
                        for (int i = 0; i < carro.size(); i++) {
                            UsuarioDao.FinalizarCompra(carro.get(i));
                            carro.remove(i);
                        }
                        UsuarioDao.DropTableItems();
                        UsuarioDao.CreateViewItems1();
                        response.sendRedirect("Carrito.jsp");
                    }
                    else{
                        response.sendRedirect("error2.jsp");
                    }
            }
            catch(Exception ex){
                response.sendRedirect("error2.jsp");
            }
    }
}
