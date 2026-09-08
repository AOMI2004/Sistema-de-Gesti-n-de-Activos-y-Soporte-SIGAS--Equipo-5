<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="backend.Modelos.Rack" %>
<%@ page import="backend.DAO.RackDAO" %>
<%
    RackDAO rackDAO = new RackDAO();
    List<Rack> listaRacks = rackDAO.obtenerRacks();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIGAS - Gestión de Racks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="racks.css">
</head>
<body>
    <div class="container-fluid p-0">
        <div class="d-flex">
                        <div id="sidebar-container" class="col-md-2 p-0" style="min-width: 280px; max-width: 280px;"></div><script src="../assets/js/sidebar.js"></script>
            <div class="main-content flex-grow-1 p-4 bg-light">
                <header class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold mb-0 text-dark">Gestión de Racks e Infraestructura</h2>
                        <p class="text-muted">Administración física del laboratorio LS5.</p>
                    </div>
                    <button class="btn btn-primary shadow-sm px-4" data-bs-toggle="modal" data-bs-target="#modalAgregarRack">
                        <i class="bi bi-plus-lg me-2"></i>Nuevo Rack
                    </button>
                </header>

                <div class="row g-4 mb-5">
                    <% for(Rack rack : listaRacks) { %>
                    <div class="col-md-4">
                        <div class="card border-0 shadow-sm p-4 rack-card">
                            <div class="d-flex justify-content-between align-items-start">
                                <div class="d-flex align-items-center">
                                    <div class="icon-container-rack me-3">
                                        <i class="bi bi-hdd-stack fs-4"></i>
                                    </div>
                                    <div>
                                        <h5 class="fw-bold mb-0"><%= rack.getNombreUbicacion() %></h5>
                                        <small class="text-muted">ID: <%= rack.getIdRack() %></small>
                                    </div>
                                </div>
                                <div class="d-flex gap-2">
                                    <a href="#" class="text-primary" onclick="abrirModalEditar('<%= rack.getIdRack() %>', '<%= rack.getNombreUbicacion().replace("'", "\\'") %>')"><i class="bi bi-pencil fs-5"></i></a>
                                    <a href="#" class="text-danger" onclick="confirmarEliminacion(event, '../../EliminarRack?id_rack=<%= rack.getIdRack() %>')"><i class="bi bi-trash fs-5"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
                <div class="card border-0 shadow-sm p-4 mt-4 bg-white">
                    <h5 class="fw-bold mb-4 text-secondary"><i class="bi bi-search me-2"></i>Vista Docente: Disponibilidad</h5>
                    <div class="d-flex gap-3 mb-4">
                        <button class="btn btn-rack-selector active flex-fill py-3 shadow-none">
                            <span class="fw-bold d-block">RACK 1</span>
                            <small class="text-success">● 12 Equipos Libres</small>
                        </button>
                        <button class="btn btn-rack-selector flex-fill py-3 shadow-none">
                            <span class="fw-bold d-block text-muted">RACK 2</span>
                            <small class="text-warning">⚠️ 2 Equipos Libres</small>
                        </button>
                    </div>
                    <div class="list-container p-4">
                        <p class="text-muted small mb-0">Esta sección permite a los docentes ver rápidamente qué equipos están disponibles sin entrar a la base de datos completa.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAgregarRack" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title fw-bold">Registrar Nuevo Rack</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <form action="../../AgregarRack" method="POST">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-bold text-muted small">UBICACIÓN O NOMBRE</label>
                            <input type="text" class="form-control" name="nombre_ubicacion" required>
                        </div>
                    </div>
                    <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button><button type="submit" class="btn btn-primary">Guardar</button></div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalEditarRack" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title fw-bold">Editar Rack</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <form action="../../EditarRack" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="id_rack" id="edit_id_rack_hidden">
                        <div class="mb-3"><label class="form-label fw-bold text-muted small">NOMBRE O UBICACIÓN</label><input type="text" class="form-control" name="nombre_ubicacion" id="edit_nombre_ubicacion" required></div>
                    </div>
                    <div class="modal-footer"><button type="submit" class="btn btn-primary">Guardar Cambios</button></div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmarEliminacion(event, url) {
            event.preventDefault(); 
            Swal.fire({ title: '¿Borrar Rack?', text: "Se eliminará la ubicación del sistema.", icon: 'warning', showCancelButton: true, confirmButtonColor: '#d33', confirmButtonText: 'Sí, eliminará }).then((result) => { if (result.isConfirmed) { window.location.href = url; } })
        }
        function abrirModalEditar(id, nombre) {
            document.getElementById('edit_id_rack_hidden').value = id;
            document.getElementById('edit_nombre_ubicacion').value = nombre;
            new bootstrap.Modal(document.getElementById('modalEditarRack')).show();
        }

        // Mostrar alertas basadas en la URL (para Backend)
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('registro') && urlParams.get('registro') === 'exito') {
                Swal.fire('¡Éxito!', 'Rack registrado correctamente.', 'success');
            } else if (urlParams.has('eliminacion') && urlParams.get('eliminacion') === 'exito') {
                Swal.fire('¡Eliminado!', 'Rack borrado correctamente.', 'success');
            } else if (urlParams.has('edicion') && urlParams.get('edicion') === 'exito') {
                Swal.fire('¡Actualizado!', 'Datos guardados correctamente.', 'success');
            } else if (urlParams.has('error')) {
                const error = urlParams.get('error');
                let mensaje = 'Ocurrió un error inesperado.';
                if (error === 'foranea') mensaje = 'No se puede eliminar el rack porque tiene equipos asociados.';
                else if (error === 'bd') mensaje = 'Error de conexión con la base de datos.';
                Swal.fire('Error', mensaje, 'error');
            }
            
            // Limpiar la URL para que no vuelva a salir la alerta si recarga la página
            if(window.history.replaceState && window.location.search) {
                window.history.replaceState(null, null, window.location.pathname);
            }
        });
    </script>
</body>
</html>