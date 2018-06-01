package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogOut extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("error.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie ck[] = request.getCookies();
        for (int i = 0; i < ck.length; i++) {
            ck[i].setPath("/ExamenFinalV1.0");
            ck[i].setMaxAge(0);
            response.addCookie(ck[i]);
        }
        HttpSession sesion = request.getSession();
        sesion.invalidate();
        response.sendRedirect("/ExamenFinalV1.0");
    }
}
