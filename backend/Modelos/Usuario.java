package backend.Modelos;

public class Usuario {
    private String matriculaId;
    private String nombreCompleto;
    private String correo;
    private String contrasenaHash;
    private String rol;
    private String estatus;

    // Constructor vacío
    public Usuario() {}

    // Constructor completo
    public Usuario(String matriculaId, String nombreCompleto, String correo, String contrasenaHash, String rol, String estatus) {
        this.matriculaId = matriculaId;
        this.nombreCompleto = nombreCompleto;
        this.correo = correo;
        this.contrasenaHash = contrasenaHash;
        this.rol = rol;
        this.estatus = estatus;
    }

    // Getters y Setters
    public String getMatriculaId() {
        return matriculaId;
    }

    public void setMatriculaId(String matriculaId) {
        this.matriculaId = matriculaId;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasenaHash() {
        return contrasenaHash;
    }

    public void setContrasenaHash(String contrasenaHash) {
        this.contrasenaHash = contrasenaHash;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
}
