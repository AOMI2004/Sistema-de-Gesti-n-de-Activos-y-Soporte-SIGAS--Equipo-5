import backend.Infraestructura.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class InsertarUsuarios {
    public static void main(String[] args) {
        String sql = "INSERT INTO USUARIO (Matricula_ID, Nombre_Completo, Correo, Contrasena_Hash, Rol, Estatus) " +
                     "VALUES (?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE Nombre_Completo=VALUES(Nombre_Completo)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            // Docente
            ps.setString(1, "DOC-001");
            ps.setString(2, "Prof. Roberto Gómez");
            ps.setString(3, "docente@saltillo.tecnm.mx");
            ps.setString(4, "docente123");
            ps.setString(5, "Docente");
            ps.setString(6, "Activo");
            ps.executeUpdate();
            
            // Alumno
            ps.setString(1, "ALU-001");
            ps.setString(2, "Juan Pérez");
            ps.setString(3, "alumno@saltillo.tecnm.mx");
            ps.setString(4, "alumno123");
            ps.setString(5, "Alumno");
            ps.setString(6, "Activo");
            ps.executeUpdate();
            
            System.out.println("Cuentas creadas exitosamente!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
