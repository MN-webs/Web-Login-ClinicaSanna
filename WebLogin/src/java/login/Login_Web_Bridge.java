package login;

import Login_Modelo.Login_Modelo;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "login", urlPatterns = {"/Login_Web_Bridge"})
public class Login_Web_Bridge extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Obtener los parámetros enviados desde index.jsp
        String user = request.getParameter("txtUsuario");
        String pass = request.getParameter("txtPassword");

        // 2. Validar las credenciales con el modelo existente
        Login_Modelo modelo = new Login_Modelo();
        boolean esValido = modelo.validarCredenciales(user, pass);

        if (esValido) {
            // 3. Simulación de carga de datos (Se puede conectar al modelo después)
            List<String> citasPendientes = new ArrayList<>();
            citasPendientes.add("📋 Consulta General - Sede Javier Prado Oeste (Mañana 10:00 AM)");
            citasPendientes.add("🦷 Odontología Preventiva - Sede San Borja (Viernes 4:30 PM)");

            // 4. Adjuntar la lista de citas al objeto 'request' para que principal.jsp pueda leerla
            request.setAttribute("listaCitas", citasPendientes);

            // 5. Redireccionar internamente a la vista del panel central (principal.jsp)
            request.getRequestDispatcher("principal.jsp").forward(request, response);
            
        } else {
            // 6. Si es incorrecto, guardamos un mensaje de error y volvemos al login
            request.setAttribute("errorLogin", "Usuario o Contraseña incorrectos para Clínica Sanna.");
            
            // Puedes manejarlo con una alerta inyectada temporalmente o directo en el JSP
            response.setContentType("text/html;charset=UTF-8");
            try (java.io.PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Usuario o Contraseña incorrectos para Clínica Sanna.');");
                out.println("window.location='index.jsp';"); // Apunta al nuevo JSP
                out.println("</script>");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}