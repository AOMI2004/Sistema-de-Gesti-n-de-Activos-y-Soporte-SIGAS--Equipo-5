import os

backend_dir = r"c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\backend"
frontend_dir = r"c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend"

models = {
    "Equipo": """package backend.Modelos;
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
""",
    "Material": """package backend.Modelos;
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
""",
    "Prestamo": """package backend.Modelos;
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
""",
    "ReporteFalla": """package backend.Modelos;
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
"""
}

daos = {
    "EquipoDAO": """package backend.DAO;
import backend.Infraestructura.DatabaseConnection;
import backend.Modelos.Equipo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EquipoDAO {
    public List<Equipo> obtenerEquipos() {
        List<Equipo> lista = new ArrayList<>();
        String sql = "SELECT * FROM EQUIPO";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                Equipo e = new Equipo();
                e.setIdEquipoQR(rs.getString("ID_Equipo_QR"));
                e.setNumSerie(rs.getString("Num_Serie"));
                e.setMarca(rs.getString("Marca"));
                e.setModelo(rs.getString("Modelo"));
                e.setEstado(rs.getString("Estado"));
                e.setUltimaAuditoria(rs.getDate("Ultima_Auditoria"));
                lista.add(e);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}
""",
    "MaterialDAO": """package backend.DAO;
import backend.Infraestructura.DatabaseConnection;
import backend.Modelos.Material;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaterialDAO {
    public List<Material> obtenerMateriales() {
        List<Material> lista = new ArrayList<>();
        String sql = "SELECT * FROM MATERIAL";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                Material m = new Material();
                m.setIdMaterial(rs.getInt("ID_Material"));
                m.setNombrePieza(rs.getString("Nombre_Pieza"));
                m.setDescripcion(rs.getString("Descripcion"));
                m.setCantidadStock(rs.getInt("Cantidad_Stock"));
                m.setIdRack(rs.getInt("ID_Rack"));
                lista.add(m);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}
""",
    "PrestamoDAO": """package backend.DAO;
import backend.Infraestructura.DatabaseConnection;
import backend.Modelos.Prestamo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrestamoDAO {
    public List<Prestamo> obtenerPrestamos() {
        List<Prestamo> lista = new ArrayList<>();
        String sql = "SELECT * FROM PRESTAMO";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                Prestamo p = new Prestamo();
                p.setIdPrestamo(rs.getInt("ID_Prestamo"));
                p.setFechaSalida(rs.getDate("Fecha_Salida"));
                p.setFechaLimite(rs.getDate("Fecha_Limite"));
                p.setFechaDevolucion(rs.getDate("Fecha_Devolucion"));
                p.setEstadoPrestamo(rs.getString("Estado_Prestamo"));
                p.setMatriculaId(rs.getString("Matricula_ID"));
                p.setIdEquipoQR(rs.getString("ID_Equipo_QR"));
                lista.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}
""",
    "ReporteFallaDAO": """package backend.DAO;
import backend.Infraestructura.DatabaseConnection;
import backend.Modelos.ReporteFalla;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReporteFallaDAO {
    public List<ReporteFalla> obtenerReportes() {
        List<ReporteFalla> lista = new ArrayList<>();
        String sql = "SELECT * FROM REPORTE_FALLA";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                ReporteFalla r = new ReporteFalla();
                r.setIdReporte(rs.getInt("ID_Reporte"));
                r.setDescripcionDano(rs.getString("Descripcion_Dano"));
                r.setFechaReporte(rs.getDate("Fecha_Reporte"));
                r.setEstadoResolucion(rs.getString("Estado_Resolucion"));
                r.setIdEquipoQR(rs.getString("ID_Equipo_QR"));
                r.setIdPrestamo(rs.getInt("ID_Prestamo"));
                lista.add(r);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}
"""
}

# Write Models
for model_name, code in models.items():
    path = os.path.join(backend_dir, "Modelos", f"{model_name}.java")
    with open(path, "w", encoding="utf-8") as f:
        f.write(code)

# Write DAOs
for dao_name, code in daos.items():
    path = os.path.join(backend_dir, "DAO", f"{dao_name}.java")
    with open(path, "w", encoding="utf-8") as f:
        f.write(code)

# Add obtenerUsuarios to UsuarioDAO
user_dao_path = os.path.join(backend_dir, "DAO", "UsuarioDAO.java")
with open(user_dao_path, "r", encoding="utf-8") as f:
    user_dao_code = f.read()

if "obtenerUsuarios" not in user_dao_code:
    new_method = """
    public java.util.List<Usuario> obtenerUsuarios() {
        java.util.List<Usuario> lista = new java.util.ArrayList<>();
        String sql = "SELECT * FROM USUARIO";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                Usuario u = new Usuario();
                u.setMatriculaId(rs.getString("Matricula_ID"));
                u.setNombreCompleto(rs.getString("Nombre_Completo"));
                u.setCorreo(rs.getString("Correo"));
                u.setRol(rs.getString("Rol"));
                u.setEstatus(rs.getString("Estatus"));
                lista.add(u);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}"""
    user_dao_code = user_dao_code.rsplit('}', 1)[0] + new_method
    with open(user_dao_path, "w", encoding="utf-8") as f:
        f.write(user_dao_code)

print("Generated Models and DAOs")
