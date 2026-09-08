package Backend.Infraestructura;

import Backend.DAO.RackDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EliminarRack")
public class EliminarRackController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_rack = Integer.parseInt(request.getParameter("id_rack"));
        
        RackDAO rackDAO = new RackDAO();

        try {
            boolean exito = rackDAO.eliminarRack(id_rack);
            if (exito) {
                response.sendRedirect(request.getContextPath() + "/Frontend/mapa_rack/racks.html?eliminacion=exito");
            } else {
                response.sendRedirect(request.getContextPath() + "/Frontend/mapa_rack/racks.html?error=noencontrado");
            }
        } catch (SQLException e) {
            // Si el rack tiene equipos o materiales asignados, MySQL bloqueará la eliminación por seguridad (Llave Foránea)
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Frontend/mapa_rack/racks.html?error=foranea");
        }
    }
}
