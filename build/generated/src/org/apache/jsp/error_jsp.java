package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class error_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Error</title>\n");
      out.write("    </head>\n");
      out.write("        <style type=\"text/css\">\n");
      out.write("            <!--\n");
      out.write("            H1 {\n");
      out.write("                font-family:Tahoma,Arial,sans-serif;\n");
      out.write("                color:white;\n");
      out.write("                background-color:#525D76;font-size:22px;\n");
      out.write("            } \n");
      out.write("            H2 {\n");
      out.write("                font-family:Tahoma,Arial,sans-serif;\n");
      out.write("                color:white;\n");
      out.write("                background-color:#525D76;\n");
      out.write("                font-size:16px;\n");
      out.write("            } \n");
      out.write("            H3 {\n");
      out.write("                font-family:Tahoma,Arial,sans-serif;\n");
      out.write("                color:white;\n");
      out.write("                background-color:#525D76;\n");
      out.write("                font-size:14px;\n");
      out.write("            } \n");
      out.write("            BODY {\n");
      out.write("                font-family:Tahoma,Arial,sans-serif;\n");
      out.write("                color:black;\n");
      out.write("                background-color:white;\n");
      out.write("            } \n");
      out.write("            B {\n");
      out.write("                font-family:Tahoma,Arial,sans-serif;\n");
      out.write("                color:white;\n");
      out.write("                background-color:#525D76;\n");
      out.write("            } \n");
      out.write("            P {\n");
      out.write("                font-family:Tahoma,Arial,sans-serif;\n");
      out.write("                background:white;\n");
      out.write("                color:black;\n");
      out.write("                font-size:12px;\n");
      out.write("            }\n");
      out.write("            A {\n");
      out.write("                color : black;\n");
      out.write("            }\n");
      out.write("            HR {color : #525D76;}\n");
      out.write("            -->\n");
      out.write("        </style>\n");
      out.write("    <body>\n");
      out.write("        <h1>Error</h1>\n");
      out.write("        <hr>\n");
      out.write("        <p><b>Mensaje</b>  Hubo un error en el sistema</p>\n");
      out.write("        <p><b>Descripcion</b>  No debes editar el codigo</p>\n");
      out.write("        <hr><h3>Examen Final</h3>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
