import backend.Infraestructura.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CheckDBUsers {
    public static void main(String[] args) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("--- USUARIOS ACTUALES ---");
            PreparedStatement ps = conn.prepareStatement("SELECT Matricula_ID, Correo FROM USUARIO");
            ResultSet rs = ps.executeQuery();
            int count = 0;
            while(rs.next()) {
                System.out.println(rs.getString("Matricula_ID") + " | " + rs.getString("Correo"));
                count++;
            }
            System.out.println("Total: " + count);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
