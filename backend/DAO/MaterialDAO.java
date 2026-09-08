package backend.DAO;
import backend.Infraestructura.DatabaseConnection;
import backend.Modelos.Material;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaterialDAO {
    public List<Material> obtenerMateriales() {
        List<Material> lista = new ArrayList<>();
        String sql = "SELECT * FROM MATERIAL";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                Material m = new Material();
                m.setIdMaterial(rs.getInt("ID_Material"));
                m.setNombrePieza(rs.getString("Nombre_Pieza"));
                m.setDescripcion(rs.getString("Descripcion"));
                m.setCantidadStock(rs.getInt("Cantidad_Stock"));
                m.setIdRack(rs.getInt("ID_Rack"));
                lista.add(m);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}
