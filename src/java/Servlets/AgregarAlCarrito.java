package Servlets;

import Clases.Carro;
import Clases.Item;
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

public class AgregarAlCarrito extends HttpServlet {
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
            String id=request.getParameter("id");
            String cant=request.getParameter("cant");
            int id_item=0;
            int cantidad=0;
            String tipo="";
            int id_tipo=0;
            try{
                id_item=Integer.parseInt(id);
                cantidad=Integer.parseInt(cant);
                Item e=UsuarioDao.getVItem(id_item);
                if (e.getItem()==null) {
                    response.sendRedirect("error2.jsp");
                }
                else if(e.getStock()<1){
                    response.sendRedirect("Carrito.jsp");
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
                    carro=(ArrayList)sesion.getAttribute("carro");
                    int cantini=0;
                    boolean exist=false;
                    for (int i = 0; i < carro.size(); i++) {
                        if (carro.get(i).getId_item()==id_item) {
                            cantini=carro.get(i).getCantidad();
                            carro.get(i).setCantidad(cantini+cantidad);
                            exist=true;
                            break;
                        }
                    }
                    if (exist==false) {
                        Carro c = new Carro();
                        c.setCantidad(cantidad);
                        c.setId_item(id_item);
                        c.setItem(e.getItem());
                        carro.add(c);
                    }
                    int estatus=UsuarioDao.ElimStock(cantidad, id_item);
                    if (estatus>0) {
                        response.sendRedirect("Carrito.jsp");
                    }
                    else{
                        response.sendRedirect("error2.jsp");
                    }
                }
            }
            catch(Exception ex){
                response.sendRedirect("error2.jsp");
            }
    }
}
