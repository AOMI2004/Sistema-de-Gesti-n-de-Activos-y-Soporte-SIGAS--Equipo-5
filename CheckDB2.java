import backend.Infraestructura.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CheckDB2 {
    public static void main(String[] args) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("--- EQUIPOS ---");
            PreparedStatement ps = conn.prepareStatement("SELECT ID_Equipo_QR FROM EQUIPO");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                System.out.println(rs.getString("ID_Equipo_QR"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
