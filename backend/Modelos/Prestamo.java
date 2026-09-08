package backend.Modelos;
public class Prestamo {
    private int idPrestamo;
    private java.sql.Date fechaSalida;
    private java.sql.Date fechaLimite;
    private java.sql.Date fechaDevolucion;
    private String estadoPrestamo;
    private String matriculaId;
    private String idEquipoQR;
    
    public int getIdPrestamo() { return idPrestamo; }
    public void setIdPrestamo(int id) { this.idPrestamo = id; }
    public java.sql.Date getFechaSalida() { return fechaSalida; }
    public void setFechaSalida(java.sql.Date d) { this.fechaSalida = d; }
    public java.sql.Date getFechaLimite() { return fechaLimite; }
    public void setFechaLimite(java.sql.Date d) { this.fechaLimite = d; }
    public java.sql.Date getFechaDevolucion() { return fechaDevolucion; }
    public void setFechaDevolucion(java.sql.Date d) { this.fechaDevolucion = d; }
    public String getEstadoPrestamo() { return estadoPrestamo; }
    public void setEstadoPrestamo(String e) { this.estadoPrestamo = e; }
    public String getMatriculaId() { return matriculaId; }
    public void setMatriculaId(String m) { this.matriculaId = m; }
    public String getIdEquipoQR() { return idEquipoQR; }
    public void setIdEquipoQR(String e) { this.idEquipoQR = e; }
}
