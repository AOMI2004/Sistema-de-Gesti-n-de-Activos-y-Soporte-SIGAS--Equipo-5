<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.DAO.UsuarioDAO" %>
<%@ page import="backend.Modelos.Usuario" %>
<%
    UsuarioDAO usuarioDAO = new UsuarioDAO();
    List<Usuario> listaUsuarios = usuarioDAO.obtenerUsuarios();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>SIGAS - GestiÃ³n de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="usuarios.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <div class="d-flex">
                    <div id="sidebar-container" class="col-md-2 p-0" style="min-width: 280px; max-width: 280px;"></div><script>const userRole = "<%= session.getAttribute("rol") != null ? session.getAttribute("rol") : "" %>";</script>
<script src="../assets/js/sidebar.js"></script>
        <div class="main-content flex-grow-1">
            <div class="d-flex justify-content-between mb-4">
                <h2>Directorio de Usuarios</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">Nuevo Registro</button>
            </div>
            <div class="card-table">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>MatrÃ­cula</th><th>Nombre</th><th>Correo</th><th>Rol</th><th>Estatus</th><th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
<% for (Usuario usuario : listaUsuarios) { %>
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
                            <% } %>
</tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="modal fade" id="addModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="../../AgregarUsuario" method="POST" class="modal-content">
                <div class="modal-header"><h5>Registrar Persona</h5></div>
                <div class="modal-body">
                    <input type="text" name="matricula" class="form-control mb-3" placeholder="MatrÃ­cula" required>
                    <input type="text" name="nombre" class="form-control mb-3" placeholder="Nombre Completo" required>
                    <input type="email" name="correo" class="form-control mb-3" placeholder="Correo Institucional" required>
                    <select name="rol" class="form-select">
                        <option value="Alumno">Alumno</option>
                        <option value="Docente">Docente</option>
                    </select>
                </div>
                <div class="modal-footer"><button type="submit" class="btn btn-primary">Guardar</button></div>
            </form>
        </div>
    </div>
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="../../EditarUsuario" method="POST" class="modal-content">
                <div class="modal-header"><h5>Editar Datos</h5></div>
                <div class="modal-body">
                    <input type="text" name="matricula" id="e_mat" class="form-control mb-3" readonly>
                    <input type="text" name="nombre" id="e_nom" class="form-control mb-3" required>
                    <input type="email" name="correo" id="e_cor" class="form-control mb-3" required>
                    <select name="rol" id="e_rol" class="form-select mb-3">
                        <option value="Alumno">Alumno</option><option value="Docente">Docente</option><option value="Admin">Admin</option>
                    </select>
                    <select name="estatus" id="e_est" class="form-select">
                        <option value="Activo">Activo</option><option value="Inactivo">Inactivo</option>
                    </select>
                </div>
                <div class="modal-footer"><button type="submit" class="btn btn-primary">Actualizar</button></div>
            </form>
        </div>
    </div>
    <script>
        function editUser(m, n, c, r, e) {
            document.getElementById('e_mat').value = m;
            document.getElementById('e_nom').value = n;
            document.getElementById('e_cor').value = c;
            document.getElementById('e_rol').value = r;
            document.getElementById('e_estÃ¡).value = e;
            new bootstrap.Modal(document.getElementById('editModal')).show();
        }
        function confirmDel(m) {
            Swal.fire({title:'Â¿Eliminar?', text:'Esta acciÃ³n no se puede deshacer', icon:'warning', showCancelButton:true}).then(r => {
                if(r.isConfirmed) location.href='../../EliminarUsuario?matricula='+m;
            });
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('registro') && urlParams.get('registro') === 'exito') {
                Swal.fire('Â¡Ã‰xito!', 'Registro creado correctamente.', 'success');
            } else if (urlParams.has('eliminacion') && urlParams.get('eliminacion') === 'exito') {
                Swal.fire('Â¡Eliminado!', 'Registro borrado correctamente.', 'success');
            } else if (urlParams.has('edicion') && urlParams.get('edicion') === 'exito') {
                Swal.fire('Â¡Actualizado!', 'Datos guardados correctamente.', 'success');
            } else if (urlParams.has('prestamo') && urlParams.get('prestamo') === 'exito') {
                Swal.fire('Â¡Autorizado!', 'PrÃ©stamo registrado.', 'success');
            } else if (urlParams.has('devolucion') && urlParams.get('devolucion') === 'exito') {
                Swal.fire('Â¡Devuelto!', 'Equipo devuelto correctamente.', 'success');
            } else if (urlParams.has('reporte') && urlParams.get('reporte') === 'exito') {
                Swal.fire('Â¡Reportado!', 'Falla enviada a mantenimiento.', 'success');
            } else if (urlParams.has('error')) {
                const error = urlParams.get('error');
                let mensaje = 'OcurriÃ³ un error inesperado.';
                if (error === 'foranea') mensaje = 'No se puede eliminar porque tiene registros asociados.';
                else if (error === 'bd') mensaje = 'Error de conexiÃ³n con la base de datos.';
                Swal.fire('Error', mensaje, 'error');
            }
            
            if(window.history.replaceState && window.location.search) {
                window.history.replaceState(null, null, window.location.pathname);
            }
        });
    </script>
<script>
        function confirmarEliminacion(event, url) {
            event.preventDefault(); 
            Swal.fire({
                title: 'Â¿EstÃ¡s seguro?',
                text: 'Se eliminarÃ¡ el usuario del sistema.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#0d1b2a',
                confirmButtonText: 'SÃ­, confirmar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = url;
                }
            });
        }

        function abrirModalEditar(matricula, nombre, correo, rol, estatus) {
            document.getElementById('edit_matricula_hidden').value = matricula;
            document.getElementById('edit_matricula_display').value = matricula;
            document.getElementById('edit_nombre').value = nombre;
            document.getElementById('edit_correo').value = correo;
            document.getElementById('edit_rol').value = rol;
            document.getElementById('edit_estatus').value = estatus;
            new bootstrap.Modal(document.getElementById('editModal')).show();
        }
</script></body>

</html>
