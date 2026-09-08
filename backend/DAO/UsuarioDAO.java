import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    /**
     * Valida si un usuario existe y sus credenciales son correctas.
     * En una implementación real, aquí se verificaría el hash de la contraseña.
     * 
     * @param correo Correo electrónico del usuario
     * @param contrasena Contraseña introducida
     * @return El objeto Usuario si las credenciales son válidas, o null si son incorrectas.
     */
    public Usuario validarLogin(String correo, String contrasena) {
        String sql = "SELECT Matricula_ID, Nombre_Completo, Correo, Rol, Estatus FROM USUARIO WHERE Correo = ? AND Contrasena_Hash = ? AND Estatus = 'Activo'";
        Usuario usuario = null;

        // Se usa try-with-resources para asegurar que la conexión se cierre automáticamente
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, correo);
            stmt.setString(2, contrasena);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setMatriculaId(rs.getString("Matricula_ID"));
                    usuario.setNombreCompleto(rs.getString("Nombre_Completo"));
                    usuario.setCorreo(rs.getString("Correo"));
                    usuario.setRol(rs.getString("Rol"));
                    usuario.setEstatus(rs.getString("Estatus"));
                    // No sacamos la contraseña por seguridad
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al validar el login del usuario: " + e.getMessage());
            e.printStackTrace();
        }

        return usuario;
    }
}
