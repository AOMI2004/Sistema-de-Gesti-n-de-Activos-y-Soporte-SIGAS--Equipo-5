package backend.Infraestructura;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Configuración centralizada de la base de datos
    private static final String DB_URL = "jdbc:mysql://localhost:3306/sigas_db";
    private static final String DB_USER = "root"; 
    private static final String DB_PASSWORD = "aster";

    /**
     * Obtiene una conexión a la base de datos MySQL.
     * @return Connection objeto de conexión.
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
