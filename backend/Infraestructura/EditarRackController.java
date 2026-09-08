package Backend.Infraestructura;

import Backend.DAO.RackDAO;
import Backend.Modelos.Rack;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditarRack")
public class EditarRackController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id_rack = Integer.parseInt(request.getParameter("id_rack"));
        String nombre_ubicacion = request.getParameter("nombre_ubicacion");

        Rack rack = new Rack();
        rack.setIdRack(id_rack);
        rack.setNombreUbicacion(nombre_ubicacion);

        RackDAO rackDAO = new RackDAO();
        boolean exito = rackDAO.editarRack(rack);

        if (exito) {
            response.sendRedirect(request.getContextPath() + "/Frontend/mapa_rack/racks.html?edicion=exito");
        } else {
            response.sendRedirect(request.getContextPath() + "/Frontend/mapa_rack/racks.html?error=bd");
        }
    }
}
