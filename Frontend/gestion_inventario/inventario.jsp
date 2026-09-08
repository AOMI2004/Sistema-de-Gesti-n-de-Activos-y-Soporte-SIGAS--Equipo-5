<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.DAO.EquipoDAO" %>
<%@ page import="backend.Modelos.Equipo" %>
<%
    EquipoDAO equipoDAO = new EquipoDAO();
    List<Equipo> listaEquipos = equipoDAO.obtenerEquipos();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIGAS - Inventario de Equipos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { background-color: #f8f9fa; font-family: Arial, sans-serif; overflow-x: hidden; }
        .sidebar { background-color: #0d1b2a; color: white; min-height: 100vh; padding-top: 20px; }
        .sidebar a { color: #a0aabf; text-decoration: none; padding: 15px 20px; display: block; font-weight: bold; font-size: 0.95rem; }
        .sidebar a:hover, .sidebar a.active { background-color: #1b263b; color: white; border-left: 4px solid #415a77; }
        .sidebar i { margin-right: 12px; font-size: 1.1rem; }
        .main-content { padding: 40px; }
        .card-table { background-color: white; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: none; padding: 20px; }
        .btn-add { background-color: #e6f4ea; color: #1e8e3e; font-weight: bold; border: none; }
        .btn-add:hover { background-color: #ceead6; color: #1e8e3e; }
        .search-bar { background-color: #f1f3f4; border: none; border-radius: 8px; }
        .table th { color: #5f6368; font-size: 0.85rem; text-transform: uppercase; }
        .icon-action { color: #5f6368; cursor: pointer; margin-right: 10px; transition: 0.2s; text-decoration: none; }
        .icon-action:hover { color: #0d1b2a; }
        .icon-delete:hover { color: #d93025; }
        .icon-edit:hover { color: #0a58ca; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 p-0">
                <div id="sidebar-container" class="col-md-2 p-0" style="min-width: 280px; max-width: 280px;"></div><script src="../assets/js/sidebar.js"></script>
            </div>
            <div class="col-md-10 main-content">
                <h2 class="fw-bold mb-4">Inventario de Equipos Principales</h2>
                    
                    
                    
                <div class="card-table">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="input-group" style="width: 350px;">
                            <span class="input-group-text bg-transparent border-0"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" class="form-control search-bar" placeholder="Buscar por Número de Serie...">
                        </div>
                        <button class="btn btn-add px-4 py-2" data-bs-toggle="modal" data-bs-target="#modalAgregarEquipo">
                            <i class="bi bi-plus-lg"></i> Agregar Equipo Nuevo
                        </button>
                    </div>
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID QR</th>
                                <th>MARCA / MODELO</th>
                                <th>NÚMERO DE SERIE</th>
                                <th>ESTADO</th>
                                <th>ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody>
<% for (Equipo equipo : listaEquipos) { %>
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
                            <% } %>
</tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAgregarEquipo" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Registrar Nuevo Equipo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="../../AgregarEquipo" method="POST">
                    <div class="modal-body">
                        <div class="mb-3"><label class="form-label fw-bold text-muted small">ID QR</label><input type="text" class="form-control" name="id_qr" required></div>
                        <div class="row">
                            <div class="col-md-6 mb-3"><label class="form-label fw-bold text-muted small">MARCA</label><input type="text" class="form-control" name="marca" required></div>
                            <div class="col-md-6 mb-3"><label class="form-label fw-bold text-muted small">MODELO</label><input type="text" class="form-control" name="modelo" required></div>
                        </div>
                        <div class="mb-3"><label class="form-label fw-bold text-muted small">NÚMERO DE SERIE</label><input type="text" class="form-control" name="numero_serie" required></div>
                        <div class="mb-3">
                            <label class="form-label fw-bold text-muted small">ESTADO INICIAL</label>
                            <select class="form-select" name="estado">
                                <option value="Disponible">Disponible</option>
                                <option value="En Mantenimiento">En Mantenimiento</option>
                                <option value="Prestado">Prestado</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary" style="background-color: #0d1b2a; border: none;">Guardar Equipo</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalEditarEquipo" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Editar Equipo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="../../EditarEquipo" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="id_qr" id="edit_id_qr_hidden">
                        <div class="mb-3">
                            <label class="form-label fw-bold text-muted small">ID QR (No editable)</label>
                            <input type="text" class="form-control bg-light" id="edit_id_qr_display" readonly>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-muted small">MARCA</label>
                                <input type="text" class="form-control" name="marca" id="edit_marca" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-muted small">MODELO</label>
                                <input type="text" class="form-control" name="modelo" id="edit_modelo" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold text-muted small">NÚMERO DE SERIE</label>
                            <input type="text" class="form-control" name="numero_serie" id="edit_numero_serie" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold text-muted small">ESTADO</label>
                            <select class="form-select" name="estado" id="edit_estado">
                                <option value="Disponible">Disponible</option>
                                <option value="En Mantenimiento">En Mantenimiento</option>
                                <option value="Prestado">Prestado</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary" style="background-color: #0d1b2a; border: none;">Guardar Cambios</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Función para confirmar la eliminación (SweetAlert)
        function confirmarEliminacion(event, url) {
            event.preventDefault(); 
            Swal.fire({
                title: '¿Estás seguro?',
                text: "Esta acción eliminará el equipo de la base de datos de forma permanente.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#0d1b2a',
                confirmButtonText: 'Sí, confirmar', eliminará,
                cancelButtonText: 'Cancelar',
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = url;
                }
            })
        }
        // Función para abrir el modal de Edición y rellenarlo con los datos
        function abrirModalEditar(id, marca, modelo, serie, estado) {
            document.getElementById('edit_id_qr_hidden').value = id;
            document.getElementById('edit_id_qr_display').value = id;
            document.getElementById('edit_marca').value = marca;
            document.getElementById('edit_modelo').value = modelo;
            document.getElementById('edit_numero_serie').value = serie;
            document.getElementById('edit_estado').value = estado;
            var modalEdit = new bootstrap.Modal(document.getElementById('modalEditarEquipo'));
            modalEdit.show();
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