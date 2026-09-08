package backend.Modelos;
public class Equipo {
    private String idEquipoQR;
    private String numSerie;
    private String marca;
    private String modelo;
    private String estado;
    private java.sql.Date ultimaAuditoria;
    
    public String getIdEquipoQR() { return idEquipoQR; }
    public void setIdEquipoQR(String id) { this.idEquipoQR = id; }
    public String getNumSerie() { return numSerie; }
    public void setNumSerie(String numSerie) { this.numSerie = numSerie; }
    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }
    public String getModelo() { return modelo; }
    public void setModelo(String modelo) { this.modelo = modelo; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    public java.sql.Date getUltimaAuditoria() { return ultimaAuditoria; }
    public void setUltimaAuditoria(java.sql.Date date) { this.ultimaAuditoria = date; }
}
