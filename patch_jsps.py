import os
import re

frontend_dir = r"c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend"

jsps = {
    "gestion_inventario/inventario.jsp": {
        "imports": """<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.DAO.EquipoDAO" %>
<%@ page import="backend.Modelos.Equipo" %>
<%
    EquipoDAO equipoDAO = new EquipoDAO();
    List<Equipo> listaEquipos = equipoDAO.obtenerEquipos();
%>
""",
        "loop": """<% for (Equipo equipo : listaEquipos) { %>
                            <tr>
                                <td class="fw-bold"><%= equipo.getIdEquipoQR() %></td>
                                <td><%= equipo.getMarca() %> / <%= equipo.getModelo() %></td>
                                <td class="text-muted"><%= equipo.getNumSerie() %></td>
                                <td>
                                    <% if ("Disponible".equals(equipo.getEstado())) { %>
                                        <span class="badge bg-success bg-opacity-10 border border-success border-opacity-10 text-success rounded-pill px-3 py-2"><i class="bi bi-check-circle-fill me-1"></i> Disponible</span>
                                    <% } else if ("En Mantenimiento".equals(equipo.getEstado())) { %>
                                        <span class="badge bg-warning bg-opacity-10 border border-warning border-opacity-10 text-warning rounded-pill px-3 py-2"><i class="bi bi-tools me-1"></i> En Mantenimiento</span>
                                    <% } else { %>
                                        <span class="badge bg-primary bg-opacity-10 border border-primary border-opacity-10 text-primary rounded-pill px-3 py-2"><i class="bi bi-person-badge me-1"></i> Prestado</span>
                                    <% } %>
                                </td>
                                <td>
                                    <a href="#" class="icon-action icon-edit" onclick="abrirModalEditar('<%= equipo.getIdEquipoQR() %>', '<%= equipo.getMarca() %>', '<%= equipo.getModelo() %>', '<%= equipo.getNumSerie() %>', '<%= equipo.getEstado() %>')">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="#" class="icon-action icon-delete text-danger" onclick="confirmarEliminacion(event, '../../EliminarEquipo?id_qr=<%= equipo.getIdEquipoQR() %>')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <% } %>"""
    },
    "gestion_inventario/materiales.jsp": {
        "imports": """<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.DAO.MaterialDAO" %>
<%@ page import="backend.Modelos.Material" %>
<%
    MaterialDAO materialDAO = new MaterialDAO();
    List<Material> listaMateriales = materialDAO.obtenerMateriales();
%>
""",
        "loop": """<% for (Material material : listaMateriales) { %>
                            <tr>
                                <td class="fw-bold"><%= material.getIdMaterial() %></td>
                                <td><%= material.getNombrePieza() %></td>
                                <td class="text-muted"><%= material.getDescripcion() %></td>
                                <td><span class="badge bg-primary bg-opacity-10 border border-primary border-opacity-10 text-primary rounded-pill px-3 py-2"><%= material.getCantidadStock() %> pz</span></td>
                                <td class="text-muted"><%= material.getIdRack() %></td>
                                <td>
                                    <a href="#" class="icon-action icon-edit" onclick="abrirModalEditar('<%= material.getIdMaterial() %>', '<%= material.getNombrePieza() %>', '<%= material.getDescripcion() %>', '<%= material.getCantidadStock() %>', '<%= material.getIdRack() %>')">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="#" class="icon-action icon-delete text-danger" onclick="confirmarEliminacion(event, '../../EliminarMaterial?id_material=<%= material.getIdMaterial() %>')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <% } %>"""
    },
    "gestion_usuarios/usuarios.jsp": {
        "imports": """<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.DAO.UsuarioDAO" %>
<%@ page import="backend.Modelos.Usuario" %>
<%
    UsuarioDAO usuarioDAO = new UsuarioDAO();
    List<Usuario> listaUsuarios = usuarioDAO.obtenerUsuarios();
%>
""",
        "loop": """<% for (Usuario usuario : listaUsuarios) { %>
                            <tr>
                                <td class="fw-bold"><%= usuario.getMatriculaId() %></td>
                                <td><%= usuario.getNombreCompleto() %></td>
                                <td class="text-muted"><%= usuario.getCorreo() %></td>
                                <td><span class="badge bg-primary bg-opacity-10 border border-primary border-opacity-10 text-primary rounded-pill px-3 py-2"><i class="bi bi-person-badge me-1"></i> <%= usuario.getRol() %></span></td>
                                <td>
                                    <% if ("Activo".equals(usuario.getEstatus())) { %>
                                        <span class="badge bg-success bg-opacity-10 border border-success border-opacity-10 text-success rounded-pill px-3 py-2"><i class="bi bi-check-circle-fill me-1"></i> Activo</span>
                                    <% } else { %>
                                        <span class="badge bg-danger bg-opacity-10 border border-danger border-opacity-10 text-danger rounded-pill px-3 py-2"><i class="bi bi-x-circle-fill me-1"></i> Inactivo</span>
                                    <% } %>
                                </td>
                                <td>
                                    <a href="#" class="icon-action icon-edit" onclick="abrirModalEditar('<%= usuario.getMatriculaId() %>', '<%= usuario.getNombreCompleto() %>', '<%= usuario.getCorreo() %>', '<%= usuario.getRol() %>', '<%= usuario.getEstatus() %>')">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="#" class="icon-action icon-delete text-danger" onclick="confirmarEliminacion(event, '../../EliminarUsuario?matricula_id=<%= usuario.getMatriculaId() %>')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <% } %>"""
    },
    "prestamos_devoluciones/devoluciones.jsp": {
        "imports": """<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.DAO.PrestamoDAO" %>
<%@ page import="backend.Modelos.Prestamo" %>
<%
    PrestamoDAO prestamoDAO = new PrestamoDAO();
    List<Prestamo> listaPrestamos = prestamoDAO.obtenerPrestamos();
%>
""",
        "loop": """<% for (Prestamo prestamo : listaPrestamos) { %>
                            <tr>
                                <td class="fw-bold"><%= prestamo.getIdPrestamo() %></td>
                                <td><%= prestamo.getMatriculaId() %></td>
                                <td><%= prestamo.getIdEquipoQR() %></td>
                                <td class="text-muted"><%= prestamo.getFechaSalida() %></td>
                                <td class="text-danger fw-bold"><%= prestamo.getFechaLimite() %></td>
                                <td>
                                    <% if ("Activo".equals(prestamo.getEstadoPrestamo())) { %>
                                        <span class="badge bg-warning bg-opacity-10 border border-warning border-opacity-10 text-warning rounded-pill px-3 py-2"><i class="bi bi-clock-history me-1"></i> Activo</span>
                                    <% } else { %>
                                        <span class="badge bg-success bg-opacity-10 border border-success border-opacity-10 text-success rounded-pill px-3 py-2"><i class="bi bi-check-circle-fill me-1"></i> Devuelto</span>
                                    <% } %>
                                </td>
                                <td>
                                    <% if ("Activo".equals(prestamo.getEstadoPrestamo())) { %>
                                    <button class="btn btn-sm btn-outline-success fw-bold px-3 rounded-pill" onclick="confirmarDevolucion('../../DevolverEquipo?id_prestamo=<%= prestamo.getIdPrestamo() %>')">
                                        <i class="bi bi-check2-circle"></i> Marcar Devuelto
                                    </button>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>"""
    },
    "reportes/reportes.jsp": {
        "imports": """<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.DAO.ReporteFallaDAO" %>
<%@ page import="backend.Modelos.ReporteFalla" %>
<%
    ReporteFallaDAO reporteDAO = new ReporteFallaDAO();
    List<ReporteFalla> listaReportes = reporteDAO.obtenerReportes();
%>
""",
        "loop": """<% for (ReporteFalla reporte : listaReportes) { %>
                            <tr>
                                <td class="fw-bold"><%= reporte.getIdReporte() %></td>
                                <td><%= reporte.getIdEquipoQR() %></td>
                                <td><%= reporte.getFechaReporte() %></td>
                                <td class="text-muted"><%= reporte.getDescripcionDano() %></td>
                                <td>
                                    <% if ("Pendiente".equals(reporte.getEstadoResolucion())) { %>
                                        <span class="badge bg-danger bg-opacity-10 border border-danger border-opacity-10 text-danger rounded-pill px-3 py-2"><i class="bi bi-exclamation-triangle-fill me-1"></i> Pendiente</span>
                                    <% } else { %>
                                        <span class="badge bg-success bg-opacity-10 border border-success border-opacity-10 text-success rounded-pill px-3 py-2"><i class="bi bi-check-circle-fill me-1"></i> Resuelto</span>
                                    <% } %>
                                </td>
                                <td>
                                    <% if ("Pendiente".equals(reporte.getEstadoResolucion())) { %>
                                    <button class="btn btn-sm btn-outline-success fw-bold px-3 rounded-pill" onclick="confirmarResolucion('../../ResolverReporte?id_reporte=<%= reporte.getIdReporte() %>')">
                                        <i class="bi bi-tools"></i> Resolver
                                    </button>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>"""
    }
}

for rel_path, data in jsps.items():
    filepath = os.path.join(frontend_dir, rel_path.replace("/", os.sep))
    if os.path.exists(filepath):
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Add imports at the very top (before <!DOCTYPE html>)
        if "<%@ page" not in content:
            content = data["imports"] + content
        
        # Insert loop inside <tbody>
        pattern = re.compile(r'(<tbody>)(.*?)(</tbody>)', re.IGNORECASE | re.DOTALL)
        content = pattern.sub(rf'\1\n{data["loop"]}\n\3', content)
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Patched {rel_path}")
    else:
        print(f"Missing {rel_path}")
