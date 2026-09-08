<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.DAO.MaterialDAO" %>
<%@ page import="backend.Modelos.Material" %>
<%
    MaterialDAO materialDAO = new MaterialDAO();
    List<Material> listaMateriales = materialDAO.obtenerMateriales();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIGAS - Catálogo de Materiales</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { background-color: #f8fafc; font-family: Arial, sans-serif; overflow-x: hidden; overflow-y: scroll; }
        .sidebar { background-color: #111827; min-width: 280px; height: 100vh; position: sticky; top: 0; }
        .sidebar a { color: #9ca3af; text-decoration: none; padding: 10px 25px; display: block; transition: 0.3s; font-size: 0.9rem; }
        .sidebar a:hover { background-color: rgba(255, 255, 255, 0.05); color: white; }
        .sidebar a.active { background-color: #3b82f6; color: white; }
        .sidebar i { margin-right: 12px; font-size: 1.1rem; }
        .main-content { padding: 40px; }
        .card-table { background-color: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: none; padding: 25px; }
        .btn-add { background-color: #e6f4ea; color: #1e8e3e; font-weight: bold; border: none; }
        .btn-add:hover { background-color: #ceead6; color: #1e8e3e; }
        .search-bar { background-color: #f1f3f4; border: none; border-radius: 8px; }
        .table th { color: #5f6368; font-size: 0.85rem; text-transform: uppercase; }
        .icon-action { color: #5f6368; cursor: pointer; margin-right: 10px; transition: 0.2s; text-decoration: none; }
        .icon-action:hover { color: #111827; }
        .icon-delete:hover { color: #d93025; }
        .icon-edit:hover { color: #0a58ca; }
    </style>
</head>
<body>
    
    <div class="container-fluid p-0">
        <div class="d-flex">
                        <div id="sidebar-container" class="col-md-2 p-0" style="min-width: 280px; max-width: 280px;"></div><script src="../assets/js/sidebar.js"></script>
            <div class="main-content flex-grow-1">
                <h2 class="fw-bold mb-4">Catálogo de Materiales y Refacciones</h2>
                <div class="card-table">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="input-group" style="width: 350px;">
                            <span class="input-group-text bg-transparent border-0"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" class="form-control search-bar" placeholder="Buscar por Nombre...">
                        </div>
                        <button class="btn btn-add px-4 py-2" data-bs-toggle="modal" data-bs-target="#modalAgregarMaterial">
                            <i class="bi bi-plus-lg"></i> Agregar Material
                        </button>
                    </div>
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>NOMBRE DE LA PIEZA</th>
                                <th>DESCRIPCIÓN</th>
                                <th>STOCK</th>
                                <th>RACK (ID)</th>
                                <th>ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody>
<% for (Material material : listaMateriales) { %>
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
                            <% } %>
</tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAgregarMaterial" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title fw-bold">Registrar Nuevo Material</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <form action="../../AgregarMaterial" method="POST">
                    <div class="modal-body">
                        <div class="mb-3"><label class="form-label fw-bold text-muted small">NOMBRE DE LA PIEZA</label><input type="text" class="form-control" name="nombre_pieza" required></div>
                        <div class="mb-3"><label class="form-label fw-bold text-muted small">DESCRIPCIÓN</label><textarea class="form-control" name="descripcion" rows="2" required></textarea></div>
                        <div class="row">
                            <div class="col-md-6 mb-3"><label class="form-label fw-bold text-muted small">CANTIDAD EN STOCK</label><input type="number" class="form-control" name="cantidad_stock" min="0" required></div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-muted small">ASIGNAR RACK</label>
                                <select class="form-select" name="id_rack" required>
                                    <option value="" disabled selected>Selecciona un Rack...</option>
                                    ...
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button><button type="submit" class="btn btn-primary">Guardar</button></div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalEditarMaterial" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title fw-bold">Editar Material</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <form action="../../EditarMaterial" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="id_material" id="edit_id_material_hidden">
                        <div class="mb-3"><label class="form-label fw-bold text-muted small">ID MATERIAL</label><input type="text" class="form-control bg-light" id="edit_id_material_display" readonly></div>
                        <div class="mb-3"><label class="form-label fw-bold text-muted small">NOMBRE DE LA PIEZA</label><input type="text" class="form-control" name="nombre_pieza" id="edit_nombre_pieza" required></div>
                        <div class="mb-3"><label class="form-label fw-bold text-muted small">DESCRIPCIÓN</label><textarea class="form-control" name="descripcion" id="edit_descripcion" rows="2" required></textarea></div>
                        <div class="row">
                            <div class="col-md-6 mb-3"><label class="form-label fw-bold text-muted small">CANTIDAD EN STOCK</label><input type="number" class="form-control" name="cantidad_stock" id="edit_cantidad_stock" min="0" required></div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-muted small">ASIGNAR RACK</label>
                                <select class="form-select" name="id_rack" id="edit_id_rack" required>
                                    ...
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button><button type="submit" class="btn btn-primary">Guardar Cambios</button></div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmarEliminacion(event, url) {
            event.preventDefault(); 
            Swal.fire({ title: '¿Estás seguro?', text: "Se eliminará permanentemente.", icon: 'warning', showCancelButton: true, confirmButtonColor: '#d33', confirmButtonText: 'Sí, eliminará, cancelButtonText: 'Cancelar' }).then((result) => { if (result.isConfirmed) { window.location.href = url; } })
        }
        function abrirModalEditar(id, nombre, desc, stock, rack) {
            document.getElementById('edit_id_material_hidden').value = id;
            document.getElementById('edit_id_material_display').value = id;
            document.getElementById('edit_nombre_pieza').value = nombre;
            document.getElementById('edit_descripcion').value = desc;
            document.getElementById('edit_cantidad_stock').value = stock;
            document.getElementById('edit_id_rack').value = rack;
            var modalEdit = new bootstrap.Modal(document.getElementById('modalEditarMaterial'));
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