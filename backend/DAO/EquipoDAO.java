package backend.DAO;
import backend.Infraestructura.DatabaseConnection;
import backend.Modelos.Equipo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EquipoDAO {
    public List<Equipo> obtenerEquipos() {
        List<Equipo> lista = new ArrayList<>();
        String sql = "SELECT * FROM EQUIPO";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                Equipo e = new Equipo();
                e.setIdEquipoQR(rs.getString("ID_Equipo_QR"));
                e.setNumSerie(rs.getString("Num_Serie"));
                e.setMarca(rs.getString("Marca"));
                e.setModelo(rs.getString("Modelo"));
                e.setEstado(rs.getString("Estado"));
                e.setUltimaAuditoria(rs.getDate("Ultima_Auditoria"));
                lista.add(e);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}
