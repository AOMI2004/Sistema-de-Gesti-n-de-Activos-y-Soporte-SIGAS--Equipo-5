import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class InitDB {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:4463/?allowMultiQueries=true&serverTimezone=UTC";
        String user = "root";
        String pass = "SIGAS123";
        String file = "Base de datos/script_sigas.sql";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);
                 Statement stmt = conn.createStatement();
                 BufferedReader br = new BufferedReader(new FileReader(file))) {
                 
                 StringBuilder sql = new StringBuilder();
                 String line;
                 while ((line = br.readLine()) != null) {
                     sql.append(line).append("\n");
                 }
                 
                 System.out.println("Ejecutando script de base de datos...");
                 stmt.executeUpdate(sql.toString());
                 System.out.println("¡EXITO!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
