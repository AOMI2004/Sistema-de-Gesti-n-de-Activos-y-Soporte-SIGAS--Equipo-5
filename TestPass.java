import java.sql.Connection;
import java.sql.DriverManager;

public class TestPass {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/?serverTimezone=UTC";
        String[] passwords = {"", "root", "1234", "123456", "12345678", "admin", "password", "SIGAS123", "mysql"};
        
        System.out.println("Buscando la contraseña...");
        for (String pass : passwords) {
            try {
                Connection conn = DriverManager.getConnection(url, "root", pass);
                System.out.println("¡BINGO! La contraseña de tu base de datos es: '" + pass + "'");
                conn.close();
                return;
            } catch (Exception e) {
                // Ignorar fallos
            }
        }
        System.out.println("No se pudo adivinar la contraseña con las opciones más comunes.");
    }
}
