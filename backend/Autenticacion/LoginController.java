package backend.Autenticacion;

import backend.DAO.UsuarioDAO;
import backend.Modelos.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        // Obtenemos la ruta base exacta de tu proyecto automáticamente
        String contextPath = request.getContextPath();

        if (correo == null || correo.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect(contextPath + "/Frontend/pantalla_login/login.jsp?error=campos_vacios");
            return;
        }

        // Validación estricta de correo institucional
        if (!correo.endsWith("@saltillo.tecnm.mx")) {
            response.sendRedirect(contextPath + "/Frontend/pantalla_login/login.jsp?error=correo_invalido");
            return;
        }

        // Llamada a la capa DAO para la validación en la base de datos
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.validarLogin(correo, password);

        if (usuario != null) {
            // Usuario encontrado, iniciar sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario.getNombreCompleto());
            session.setAttribute("rol", usuario.getRol());
            session.setAttribute("matricula", usuario.getMatriculaId());
            
            // Redirigir al dashboard con la ruta correcta
            response.sendRedirect(contextPath + "/Frontend/dashboard_administrador/dashboard.jsp");
        } else {
            // Verificar si el error fue por contraseña o porque el correo no existe
            if (usuarioDAO.existeCorreo(correo)) {
                response.sendRedirect(contextPath + "/Frontend/pantalla_login/login.jsp?error=password_incorrecta");
            } else {
                response.sendRedirect(contextPath + "/Frontend/pantalla_login/login.jsp?error=correo_no_existe");
            }
        }
    }
}
