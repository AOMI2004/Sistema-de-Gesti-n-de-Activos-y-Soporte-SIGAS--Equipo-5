package backend.Modelos;
public class ReporteFalla {
    private int idReporte;
    private String descripcionDano;
    private java.sql.Date fechaReporte;
    private String estadoResolucion;
    private String idEquipoQR;
    private int idPrestamo;
    
    public int getIdReporte() { return idReporte; }
    public void setIdReporte(int id) { this.idReporte = id; }
    public String getDescripcionDano() { return descripcionDano; }
    public void setDescripcionDano(String d) { this.descripcionDano = d; }
    public java.sql.Date getFechaReporte() { return fechaReporte; }
    public void setFechaReporte(java.sql.Date d) { this.fechaReporte = d; }
    public String getEstadoResolucion() { return estadoResolucion; }
    public void setEstadoResolucion(String e) { this.estadoResolucion = e; }
    public String getIdEquipoQR() { return idEquipoQR; }
    public void setIdEquipoQR(String id) { this.idEquipoQR = id; }
    public int getIdPrestamo() { return idPrestamo; }
    public void setIdPrestamo(int id) { this.idPrestamo = id; }
}
