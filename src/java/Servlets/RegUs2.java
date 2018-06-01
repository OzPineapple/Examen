package Servlets;

import Clases.Carro;
import Clases.Sesion;
import Clases.Usuario;
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

public class RegUs2 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String user,pass;
            user=request.getParameter("user");
            pass=request.getParameter("pass");
            if (user==null || pass==null) {
                response.sendRedirect("RegUs.jsp");
            }
            else{
                Usuario e = new Usuario();
                e.setUser(user);
                e.setPass(pass);
                int estatus1=UsuarioDao.AgregarUsuario(e,2);
                if (estatus1>0) {
                    int id_tipo=UsuarioDao.getId_TipoByEmail(user);
                    Sesion s= new Sesion();
                    s=UsuarioDao.getSesionUser(user);
                    Cookie id_usCookie = new Cookie("id_us",String.valueOf(s.getId_us()));
                    Cookie id_tipoCookie = new Cookie("id_tipo",String.valueOf(id_tipo));
                    Cookie nomCookie = new Cookie("user",s.getUser());
                    System.out.println("Tipo Usuario");
                    UsuarioDao.DropTableItems();
                    UsuarioDao.CreateViewItems1();
                    List<Carro> carro = new ArrayList<Carro>();
                    HttpSession sesion=request.getSession(true);
                    sesion.setAttribute("carro", carro);
                    response.addCookie(id_usCookie);
                    response.addCookie(id_tipoCookie);
                    response.addCookie(nomCookie);
                    response.sendRedirect("Carrito.jsp");
                }
                else{
                    response.sendRedirect("error.jsp");
                }
            }
        }
    }
}
