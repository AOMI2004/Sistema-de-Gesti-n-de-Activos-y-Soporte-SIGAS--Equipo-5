<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.DAO.PrestamoDAO" %>
<%@ page import="backend.Modelos.Prestamo" %>
<%
    PrestamoDAO prestamoDAO = new PrestamoDAO();
    List<Prestamo> listaPrestamos = prestamoDAO.obtenerPrestamos();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIGAS - Préstamos y Devoluciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="devoluciones.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <div class="container-fluid p-0">
        <div class="d-flex">
                        <div id="sidebar-container" class="col-md-2 p-0" style="min-width: 280px; max-width: 280px;"></div><script src="../assets/js/sidebar.js"></script>
            <div class="main-content flex-grow-1 p-4 bg-light">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold mb-0">Gestión de Préstamos</h2>
                        <p class="text-muted">Control de salidas y retornos de equipo del laboratorio.</p>
                    </div>
                    <button class="btn btn-primary px-4 fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#modalPrestamo">
                        <i class="bi bi-plus-lg me-2"></i>Nuevo Préstamo
                    </button>
                </div>
                <div class="card border-0 shadow-sm p-4 mx-auto mb-4">
                    <form action="devoluciones.jsp" method="GET" class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" name="buscar_qr" class="form-control border-start-0 py-2" placeholder="Escanea el QR del equipo para devolverlo rápido" required>
                        <button type="submit" class="btn btn-dark px-4 fw-bold">Buscar</button>
                    </form>
                    
                                    <div class="text-center mt-4">
                                        <h6 class="text-success fw-bold mb-3"><i class="bi bi-record-circle-fill"></i> Préstamo Encontrado</h6>
                                        <div class="d-flex align-items-center justify-content-center bg-white border border-success rounded-4 p-3 shadow-sm mx-auto" style="max-width: 500px;">
                                            <i class="bi bi-person-badge fs-1 text-secondary me-3"></i>
                                            <div class="text-start">
                                                <p class="mb-0 fw-bold">...: ...</p>
                                                <p class="mb-0 text-muted small">Equipo: ... (QR: ...)</p>
                                            </div>
                                        </div>
                                        <div class="row g-3 mt-3 mx-auto" style="max-width: 500px;">
                                            <div class="col-md-6">
                                                <a href="../../DevolverEquipo?id_prestamo=...&id_equipo=..." class="btn btn-success w-100 py-3 fw-bold rounded-3">
                                                    <i class="bi bi-check2-circle me-2"></i> Devolver Bien
                                                </a>
                                            </div>
                                            <div class="col-md-6">
                                                <button class="btn btn-danger w-100 py-3 fw-bold rounded-3" data-bs-toggle="modal" data-bs-target="#modalFalla">
                                                    <i class="bi bi-tools me-2"></i> Reportar Falla
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal fade" id="modalFalla" tabindex="-1">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <form action="../../ReportarFalla" method="POST" class="modal-content border-0 shadow">
                                                <div class="modal-header bg-light border-0">
                                                    <h5 class="modal-title fw-bold">Reportar Daño o Falla</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body p-4 text-start">
                                                    <input type="hidden" name="id_equipo" value="...">
                                                    <input type="hidden" name="id_prestamo" value="...">
                                                    <label class="form-label small fw-bold text-muted">Describa el problema del equipo:</label>
                                                    <textarea name="descripcion" class="form-control bg-light border-0 mb-4" rows="4" placeholder="Ej. El lente está rayado..." required></textarea>
                                                    <button type="submit" class="btn btn-primary w-100 py-2 fw-bold" style="background-color: #0b5361; border: none;">
                                                        Confirmar Falla y Enviar a Mantenimiento
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                    
                                <div class="alert alert-warning text-center fw-bold mt-4 mb-0">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i> No se encontró préstamo activo para: ...
                                </div>
                    
                </div>
                <div class="card border-0 shadow-sm p-4">
                    <h5 class="fw-bold mb-4"><i class="bi bi-list-task me-2"></i>Historial General</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr><th>Folio</th><th>Usuario</th><th>Equipo (QR)</th><th>Fecha Salida</th><th>Estado</th><th>Acciones</th></tr>
                            </thead>
                            <tbody>
<% for (Prestamo prestamo : listaPrestamos) { %>
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
                            <% } %>
</tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalPrestamo" tabindex="-1">
        <div class="modal-dialog">
            <form action="../../NuevoPrestamo" method="POST" class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Registrar Salida de Equipo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted">USUARIO</label>
                        <select class="form-select" name="matricula" required>
                            <option value="" disabled selected>Selecciona un alumno o docente...</option>
                            
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted">EQUIPO A PRESTAR</label>
                        <select class="form-select" name="id_equipo" required>
                            <option value="" disabled selected>Selecciona el QR del equipo...</option>
                            
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted">FECHA LÍMITE</label>
                        <input type="date" class="form-control" name="fecha_limite" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary w-100 fw-bold">Autorizar Préstamo</button>
                </div>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmarDevolucion(url) {
            Swal.fire({ title: '¿Recibir equipo?', text: "El equipo regresará al inventario como Disponible.", icon: 'info', showCancelButton: true, confirmButtonColor: '#198754', confirmButtonText: 'Sí, confirmar' }).then((result) => {
                if (result.isConfirmed) { window.location.href = url; }
            });
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