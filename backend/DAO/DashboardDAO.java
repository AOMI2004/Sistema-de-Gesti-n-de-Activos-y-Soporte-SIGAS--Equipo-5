package backend.DAO;

import backend.Infraestructura.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardDAO {
    
    public int getEquiposPrestados() {
        int count = 0;
        // Cuenta prstamos activos que salieron hoy (o en general, prstamos activos)
        String sql = "SELECT COUNT(*) FROM PRESTAMO WHERE Estado_Prestamo = 'Activo'";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }
    
    public int getMaterialBajoStock() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM MATERIAL WHERE Cantidad_Stock <= 5";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }
    
    public int getEquiposEnMantenimiento() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM EQUIPO WHERE Estado = 'En Mantenimiento'";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }
    
    public String getUltimaAuditoria() {
        String fecha = "Ninguna";
        String sql = "SELECT MAX(Ultima_Auditoria) FROM EQUIPO";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next() && rs.getDate(1) != null) {
                fecha = rs.getDate(1).toString();
            }
        } catch (Exception e) { e.printStackTrace(); }
        return fecha;
    }
}
