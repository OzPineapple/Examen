package Servlets;

import Clases.Carro;
import Clases.Sesion;
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

public class LogIn extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user,pass;
        user=request.getParameter("user");
        pass=request.getParameter("pass");
        if (UsuarioDao.comprobarPassByEmail(user, pass)==true) {
            int id_tipo=UsuarioDao.getId_TipoByEmail(user);
            Sesion e= new Sesion();
            e=UsuarioDao.getSesionUser(user);
            if (id_tipo==1) {
                Cookie id_usCookie = new Cookie("id_us",String.valueOf(e.getId_us()));
                Cookie id_tipoCookie = new Cookie("id_tipo",String.valueOf(id_tipo));
                Cookie nomCookie = new Cookie("user",e.getUser());
                System.out.println("Tipo Admin");
                response.addCookie(id_usCookie);
                response.addCookie(id_tipoCookie);
                response.addCookie(nomCookie);
                response.sendRedirect("Admin.jsp");
            }
            else if (id_tipo==2) {
                Cookie id_usCookie = new Cookie("id_us",String.valueOf(e.getId_us()));
                Cookie id_tipoCookie = new Cookie("id_tipo",String.valueOf(id_tipo));
                Cookie userCookie = new Cookie("user",e.getUser());
                System.out.println("Tipo Usuario");
                UsuarioDao.CreateViewItems1();
                List<Carro> carro = new ArrayList<Carro>();
                HttpSession sesion=request.getSession(true);
                sesion.setAttribute("carro", carro);
                response.addCookie(id_usCookie);
                response.addCookie(id_tipoCookie);
                response.addCookie(userCookie);
                response.sendRedirect("Carrito.jsp");
            }
            else{
                response.sendRedirect("error.jsp");
            }
        }
        else{
            response.sendRedirect("index.jsp");
        }
    }
}
