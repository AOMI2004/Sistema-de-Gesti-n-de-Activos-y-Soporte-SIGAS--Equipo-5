package backend.Infraestructura;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // ConfiguraciÃ³n centralizada de la base de datos
    private static final String DB_URL = "jdbc:mysql://localhost:4463/sigas_db?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root"; 
    private static final String DB_PASSWORD = "SIGAS123";

    /**
     * Obtiene una conexiÃ³n a la base de datos MySQL.
     * @return Connection objeto de conexiÃ³n.
     * @throws SQLException si ocurre un error de acceso a datos.
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Registrar el driver JDBC (necesario en versiones antiguas de Tomcat o Java)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver MySQL no encontrado.");
            e.printStackTrace();
        }
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
