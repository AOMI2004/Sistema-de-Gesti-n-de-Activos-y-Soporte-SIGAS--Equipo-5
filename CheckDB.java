import backend.Infraestructura.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CheckDB {
    public static void main(String[] args) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("--- MATERIALES ---");
            PreparedStatement ps = conn.prepareStatement("SELECT ID_Material, Nombre_Pieza, Descripcion FROM MATERIAL");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                String desc = rs.getString("Descripcion");
                System.out.println(rs.getInt("ID_Material") + " | " + desc.replace("\n", "\\n").replace("\r", "\\r"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
