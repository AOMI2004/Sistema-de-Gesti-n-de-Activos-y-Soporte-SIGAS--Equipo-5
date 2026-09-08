document.addEventListener("DOMContentLoaded", function() {
    // Determine base path for relative links based on current depth
    // All our files are currently inside a module folder (e.g. Frontend/auditoria_QR/auditoria.jsp)
    // So relative path to Frontend root is "../"
    const basePath = "../";

    const sidebarHTML = `
        <div class="sidebar d-flex flex-column p-0">
            <h4 class="text-center mb-4 text-white fw-bold mt-3">
                <i class="bi bi-layers"></i> Admin Panel
            </h4>
            
            <a href="${basePath}dashboard_administrador/dashboard.html" data-page="dashboard"><i class="bi bi-grid-1x2"></i> Inicio</a>
            
            <div class="px-3 py-2 text-muted small fw-bold mt-2" style="font-size: 0.7rem; letter-spacing: 1px;">INFRAESTRUCTURA</div>
            <a href="${basePath}mapa_rack/racks.jsp" data-page="racks"><i class="bi bi-hdd-rack"></i> Gestión de Racks</a>
            <a href="${basePath}gestion_inventario/inventario.jsp" data-page="inventario"><i class="bi bi-pc-display"></i> Catálogo de Equipos</a>
            <a href="${basePath}gestion_inventario/materiales.jsp" data-page="materiales"><i class="bi bi-box-seam"></i> Catálogo de Materiales</a>
            
            <div class="px-3 py-2 text-muted small fw-bold mt-2" style="font-size: 0.7rem; letter-spacing: 1px;">OPERACIONES</div>
            <a href="${basePath}auditoria_QR/auditoria.jsp" data-page="auditoria"><i class="bi bi-qr-code-scan"></i> Auditoría QR</a>
            <a href="${basePath}prestamos_devoluciones/devoluciones.jsp" data-page="devoluciones"><i class="bi bi-arrow-left-right"></i> Préstamos y Devoluciones</a>
            <a href="${basePath}reportes/reportes.jsp" data-page="reportes"><i class="bi bi-file-earmark-medical"></i> Reportes</a>
            
            <div class="px-3 py-2 text-muted small fw-bold mt-2" style="font-size: 0.7rem; letter-spacing: 1px;">SISTEMA</div>
            <a href="${basePath}gestion_usuarios/usuarios.jsp" data-page="usuarios"><i class="bi bi-people"></i> Usuarios</a>
            
            <div class="mt-auto mb-4">
                <a href="../../Logout"><i class="bi bi-box-arrow-left"></i> Cerrar Sesión</a>
            </div>
        </div>
    `;

    // Inject CSS
    const cssLink = document.createElement("link");
    cssLink.rel = "stylesheet";
    cssLink.href = basePath + "assets/css/sidebar.css";
    document.head.appendChild(cssLink);

    // Inject HTML
    const container = document.getElementById("sidebar-container");
    if (container) {
        container.innerHTML = sidebarHTML;

        // Set active link
        const currentPath = window.location.pathname;
        const links = container.querySelectorAll("a");
        links.forEach(link => {
            const pageId = link.getAttribute("data-page");
            if (pageId && currentPath.includes(pageId)) {
                link.classList.add("active");
            }
        });
    }
});
