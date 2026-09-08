import backend.Infraestructura.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CheckDB3 {
    public static void main(String[] args) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String[] tables = {"RACK_UBICACION", "EQUIPO", "MATERIAL", "USUARIO"};
            for(String t : tables) {
                System.out.println("--- " + t + " ---");
                ResultSet rs = conn.prepareStatement("SELECT * FROM " + t).executeQuery();
                int count = 0;
                while(rs.next()) {
                    count++;
                }
                System.out.println(count + " rows.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
