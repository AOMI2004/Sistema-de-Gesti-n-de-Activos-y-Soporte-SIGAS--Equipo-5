package Backend.DAO;

import Backend.Infraestructura.DatabaseConnection;
import Backend.Modelos.Rack;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RackDAO {

    public boolean agregarRack(Rack rack) {
        String sql = "INSERT INTO RACK_UBICACION (Nombre_Ubicacion) VALUES (?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, rack.getNombreUbicacion());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean editarRack(Rack rack) {
        String sql = "UPDATE RACK_UBICACION SET Nombre_Ubicacion = ? WHERE ID_Rack = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, rack.getNombreUbicacion());
            ps.setInt(2, rack.getIdRack());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public java.util.List<Rack> obtenerRacks() {
        java.util.List<Rack> lista = new java.util.ArrayList<>();
        String sql = "SELECT ID_Rack, Nombre_Ubicacion FROM RACK_UBICACION";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             java.sql.ResultSet rs = ps.executeQuery()) {
            
            while(rs.next()) {
                Rack rack = new Rack();
                rack.setIdRack(rs.getInt("ID_Rack"));
                rack.setNombreUbicacion(rs.getString("Nombre_Ubicacion"));
                lista.add(rack);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean eliminarRack(int idRack) throws SQLException {
        String sql = "DELETE FROM RACK_UBICACION WHERE ID_Rack = ?";
        // No capturamos la excepción aquí para que el controlador sepa si falló 
        // por llave foránea (equipos asociados) y pueda mostrar un mensaje.
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idRack);
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        }
    }
}
