package backend.Modelos;

public class Rack {
    private int idRack;
    private String nombreUbicacion;

    public Rack() {}

    public Rack(int idRack, String nombreUbicacion) {
        this.idRack = idRack;
        this.nombreUbicacion = nombreUbicacion;
    }

    public int getIdRack() {
        return idRack;
    }

    public void setIdRack(int idRack) {
        this.idRack = idRack;
    }

    public String getNombreUbicacion() {
        return nombreUbicacion;
    }

    public void setNombreUbicacion(String nombreUbicacion) {
        this.nombreUbicacion = nombreUbicacion;
    }
}
