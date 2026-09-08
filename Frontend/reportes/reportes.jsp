<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.DAO.ReporteFallaDAO" %>
<%@ page import="backend.Modelos.ReporteFalla" %>
<%
    ReporteFallaDAO reporteDAO = new ReporteFallaDAO();
    List<ReporteFalla> listaReportes = reporteDAO.obtenerReportes();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIGAS - Reportes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="reportes.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <div class="container-fluid p-0">
        <div class="d-flex">
                        <div id="sidebar-container" class="col-md-2 p-0" style="min-width: 280px; max-width: 280px;"></div><script src="../assets/js/sidebar.js"></script>
            <div class="main-content flex-grow-1 p-4 bg-light">
                <header class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold mb-0">Reportes de Fallas y Daños</h2>
                        <p class="text-muted">Equipos enviados a mantenimiento tras la devolución.</p>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-secondary btn-sm" onclick="window.print()"><i class="bi bi-printer me-1"></i> Imprimir</button>
                    </div>
                </header>
                <div class="card border-0 shadow-sm overflow-hidden">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-white border-bottom">
                                <tr>
                                    <th class="ps-4 py-3 text-muted small fw-bold">EQUIPO / SN</th>
                                    <th class="py-3 text-muted small fw-bold">REPORTADO POR</th>
                                    <th class="py-3 text-muted small fw-bold">FECHA REPORTE</th>
                                    <th class="py-3 text-muted small fw-bold">DESCRIPCIÓN DE FALLA</th>
                                    <th class="py-3 text-muted small fw-bold">ESTADO</th>
                                    <th class="py-3 text-end pe-4 text-muted small fw-bold">ACCIONES</th>
                                </tr>
                            </thead>
                            <tbody>
<% for (ReporteFalla reporte : listaReportes) { %>
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
                            <% } %>
</tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function confirmarResolucion(url) {
            Swal.fire({
                title: '¿Marcar equipo como Resuelto?',
                text: "El reporte se cerrará y el equipo volverá a estar Disponible en el inventario principal.",
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#198754',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Sí, confirmar', resolver',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = url;
                }
            })
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('registro') && urlParams.get('registro') === 'exito') {
                Swal.fire('¡Éxito!', 'Registro creado correctamente.', 'success');
            } else if (urlParams.has('eliminacion') && urlParams.get('eliminacion') === 'exito') {
                Swal.fire('¡Eliminado!', 'Registro borrado correctamente.', 'success');
            } else if (urlParams.has('edicion') && urlParams.get('edicion') === 'exito') {
                Swal.fire('¡Actualizado!', 'Datos guardados correctamente.', 'success');
            } else if (urlParams.has('prestamo') && urlParams.get('prestamo') === 'exito') {
                Swal.fire('¡Autorizado!', 'Préstamo registrado.', 'success');
            } else if (urlParams.has('devolucion') && urlParams.get('devolucion') === 'exito') {
                Swal.fire('¡Devuelto!', 'Equipo devuelto correctamente.', 'success');
            } else if (urlParams.has('reporte') && urlParams.get('reporte') === 'exito') {
                Swal.fire('¡Reportado!', 'Falla enviada a mantenimiento.', 'success');
            } else if (urlParams.has('error')) {
                const error = urlParams.get('error');
                let mensaje = 'Ocurrió un error inesperado.';
                if (error === 'foranea') mensaje = 'No se puede eliminar porque tiene registros asociados.';
                else if (error === 'bd') mensaje = 'Error de conexión con la base de datos.';
                Swal.fire('Error', mensaje, 'error');
            }
            
            if(window.history.replaceState && window.location.search) {
                window.history.replaceState(null, null, window.location.pathname);
            }
        });
    </script>
</body>

</html>