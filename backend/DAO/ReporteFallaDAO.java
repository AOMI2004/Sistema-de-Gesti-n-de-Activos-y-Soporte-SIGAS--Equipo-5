package backend.DAO;
import backend.Infraestructura.DatabaseConnection;
import backend.Modelos.ReporteFalla;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReporteFallaDAO {
    public List<ReporteFalla> obtenerReportes() {
        List<ReporteFalla> lista = new ArrayList<>();
        String sql = "SELECT * FROM REPORTE_FALLA";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                ReporteFalla r = new ReporteFalla();
                r.setIdReporte(rs.getInt("ID_Reporte"));
                r.setDescripcionDano(rs.getString("Descripcion_Dano"));
                r.setFechaReporte(rs.getDate("Fecha_Reporte"));
                r.setEstadoResolucion(rs.getString("Estado_Resolucion"));
                r.setIdEquipoQR(rs.getString("ID_Equipo_QR"));
                r.setIdPrestamo(rs.getInt("ID_Prestamo"));
                lista.add(r);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}
