package backend.DAO;
import backend.Infraestructura.DatabaseConnection;
import backend.Modelos.Prestamo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrestamoDAO {
    public List<Prestamo> obtenerPrestamos() {
        List<Prestamo> lista = new ArrayList<>();
        String sql = "SELECT * FROM PRESTAMO";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                Prestamo p = new Prestamo();
                p.setIdPrestamo(rs.getInt("ID_Prestamo"));
                p.setFechaSalida(rs.getDate("Fecha_Salida"));
                p.setFechaLimite(rs.getDate("Fecha_Limite"));
                p.setFechaDevolucion(rs.getDate("Fecha_Devolucion"));
                p.setEstadoPrestamo(rs.getString("Estado_Prestamo"));
                p.setMatriculaId(rs.getString("Matricula_ID"));
                p.setIdEquipoQR(rs.getString("ID_Equipo_QR"));
                lista.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}
