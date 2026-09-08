document.addEventListener("DOMContentLoaded", function() {
    const basePath = "../";
    
    // Check if userRole is defined (injected by JSP), default to Administrador for safety
    const role = (typeof userRole !== 'undefined' && userRole !== "") ? userRole : "Administrador";
    
    let linksHTML = `<a href="${basePath}dashboard_administrador/dashboard.jsp" data-page="dashboard"><i class="bi bi-grid-1x2"></i> Inicio</a>`;
    
    if (role === "Administrador") {
        linksHTML += `
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
        `;
    } else {
        linksHTML += `
            <div class="px-3 py-2 text-muted small fw-bold mt-2" style="font-size: 0.7rem; letter-spacing: 1px;">SERVICIOS</div>
            <a href="${basePath}prestamos_devoluciones/devoluciones.jsp" data-page="devoluciones"><i class="bi bi-arrow-left-right"></i> Mis Préstamos</a>
            <a href="${basePath}reportes/reportes.jsp" data-page="reportes"><i class="bi bi-file-earmark-medical"></i> Reportar Falla</a>
        `;
    }

    const title = (role === "Administrador") ? "Admin Panel" : "Panel de Usuario";

    const sidebarHTML = `
        <div class="sidebar d-flex flex-column p-0">
            <h4 class="text-center mb-4 text-white fw-bold mt-3">
                <i class="bi bi-layers"></i> ${title}
            </h4>
            ${linksHTML}
            <div class="mt-auto mb-4">
                <a href="../../Logout"><i class="bi bi-box-arrow-left"></i> Cerrar Sesión</a>
            </div>
        </div>
    `;

    const cssLink = document.createElement("link");
    cssLink.rel = "stylesheet";
    cssLink.href = basePath + "assets/css/sidebar.css";
    document.head.appendChild(cssLink);

    const container = document.getElementById("sidebar-container");
    if (container) {
        container.innerHTML = sidebarHTML;

        const currentPath = window.location.pathname;
        const currentFileName = currentPath.substring(currentPath.lastIndexOf('/') + 1);
        
        const links = container.querySelectorAll("a");
        links.forEach(link => {
            const pageId = link.getAttribute("data-page");
            if (pageId && currentFileName.includes(pageId)) {
                link.classList.add("active");
            }
        });
    }
});
