package backend.Modelos;
public class Material {
    private int idMaterial;
    private String nombrePieza;
    private String descripcion;
    private int cantidadStock;
    private int idRack;
    
    public int getIdMaterial() { return idMaterial; }
    public void setIdMaterial(int id) { this.idMaterial = id; }
    public String getNombrePieza() { return nombrePieza; }
    public void setNombrePieza(String nombre) { this.nombrePieza = nombre; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String desc) { this.descripcion = desc; }
    public int getCantidadStock() { return cantidadStock; }
    public void setCantidadStock(int cant) { this.cantidadStock = cant; }
    public int getIdRack() { return idRack; }
    public void setIdRack(int idRack) { this.idRack = idRack; }
}
