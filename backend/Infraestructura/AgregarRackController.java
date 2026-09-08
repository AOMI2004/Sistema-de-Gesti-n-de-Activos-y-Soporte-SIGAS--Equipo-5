package Backend.Infraestructura;

import Backend.DAO.RackDAO;
import Backend.Modelos.Rack;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AgregarRack")
public class AgregarRackController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nombre_ubicacion = request.getParameter("nombre_ubicacion");

        Rack rack = new Rack();
        rack.setNombreUbicacion(nombre_ubicacion);

        RackDAO rackDAO = new RackDAO();
        boolean exito = rackDAO.agregarRack(rack);

        if (exito) {
            response.sendRedirect(request.getContextPath() + "/Frontend/mapa_rack/racks.html?registro=exito");
        } else {
            response.sendRedirect(request.getContextPath() + "/Frontend/mapa_rack/racks.html?error=bd");
        }
    }
}
