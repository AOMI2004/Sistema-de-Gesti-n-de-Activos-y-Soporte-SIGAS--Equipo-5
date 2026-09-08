<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    String context = request.getContextPath(); 
    String currentURI = request.getRequestURI();
%>
<div class="sidebar d-flex flex-column p-0" style="min-height: 100vh;">
    <h4 class="text-center mb-4 text-white fw-bold mt-3">
        <i class="bi bi-layers"></i> Admin Panel
    </h4>
    
    <a href="<%= context %>/Frontend/dashboard_administrador/dashboard.jsp" class="<%= currentURI.contains("dashboard.jsp") ? "active" : "" %>">
        <i class="bi bi-grid-1x2"></i> Inicio
    </a>
    
    <div class="px-3 py-2 text-muted small fw-bold mt-2" style="font-size: 0.7rem; letter-spacing: 1px;">INFRAESTRUCTURA</div>
    <a href="<%= context %>/Frontend/mapa_rack/racks.jsp" class="<%= currentURI.contains("racks.jsp") ? "active" : "" %>">
        <i class="bi bi-hdd-rack"></i> Gestión de Racks
    </a>
    <a href="<%= context %>/Frontend/gestion_inventario/inventario.jsp" class="<%= currentURI.contains("inventario.jsp") ? "active" : "" %>">
        <i class="bi bi-pc-display"></i> Catálogo de Equipos
    </a>
    <a href="<%= context %>/Frontend/gestion_inventario/materiales.jsp" class="<%= currentURI.contains("materiales.jsp") ? "active" : "" %>">
        <i class="bi bi-box-seam"></i> Catálogo de Materiales
    </a>
    
    <div class="px-3 py-2 text-muted small fw-bold mt-2" style="font-size: 0.7rem; letter-spacing: 1px;">OPERACIONES</div>
    <a href="<%= context %>/Frontend/auditoria_QR/auditoria.jsp" class="<%= currentURI.contains("auditoria.jsp") ? "active" : "" %>">
        <i class="bi bi-qr-code-scan"></i> Auditoría QR
    </a>
    <a href="<%= context %>/Frontend/prestamos_devoluciones/devoluciones.jsp" class="<%= currentURI.contains("devoluciones.jsp") ? "active" : "" %>">
        <i class="bi bi-arrow-left-right"></i> Préstamos y Devoluciones
    </a>
    <a href="<%= context %>/Frontend/reportes/reportes.jsp" class="<%= currentURI.contains("reportes.jsp") ? "active" : "" %>">
        <i class="bi bi-file-earmark-medical"></i> Reportes
    </a>
    
    <div class="px-3 py-2 text-muted small fw-bold mt-2" style="font-size: 0.7rem; letter-spacing: 1px;">SISTEMA</div>
    <a href="<%= context %>/Frontend/gestion_usuarios/usuarios.jsp" class="<%= currentURI.contains("usuarios.jsp") ? "active" : "" %>">
        <i class="bi bi-people"></i> Usuarios
    </a>
    
    <div class="mt-auto mb-4">
        <a href="<%= context %>/Logout"><i class="bi bi-box-arrow-left"></i> Cerrar Sesión</a>
    </div>
</div>
