import os

d = r'c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend'

scripts = {
    "gestion_inventario/materiales.jsp": """
        function confirmarEliminacion(event, url) {
            event.preventDefault(); 
            Swal.fire({
                title: '¿Estás seguro?',
                text: "Se eliminará el material del sistema.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#0d1b2a',
                confirmButtonText: 'Sí, confirmar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = url;
                }
            });
        }

        function abrirModalEditar(id, nombre, desc, cant, rack_id) {
            document.getElementById('edit_id_material_hidden').value = id;
            document.getElementById('edit_id_material_display').value = id;
            document.getElementById('edit_nombre_pieza').value = nombre;
            document.getElementById('edit_descripcion').value = desc;
            document.getElementById('edit_cantidad_stock').value = cant;
            document.getElementById('edit_id_rack').value = rack_id;
            new bootstrap.Modal(document.getElementById('modalEditarMaterial')).show();
        }
""",
    "gestion_usuarios/usuarios.jsp": """
        function confirmarEliminacion(event, url) {
            event.preventDefault(); 
            Swal.fire({
                title: '¿Estás seguro?',
                text: "Se eliminará el usuario del sistema.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#0d1b2a',
                confirmButtonText: 'Sí, confirmar',
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
            new bootstrap.Modal(document.getElementById('modalEditarUsuario')).show();
        }
""",
    "reportes/reportes.jsp": """
        function confirmarResolucion(url) {
            Swal.fire({
                title: '¿Marcar como resuelto?',
                text: "El reporte se cerrará y quedará como resuelto.",
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#28a745',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Sí, resolver',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = url;
                }
            });
        }
""",
    "prestamos_devoluciones/devoluciones.jsp": """
        function confirmarDevolucion(url) {
            Swal.fire({
                title: '¿Registrar devolución?',
                text: "El equipo quedará marcado como devuelto.",
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#28a745',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Sí, devolver',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = url;
                }
            });
        }
"""
}

for rel_path, js in scripts.items():
    path = os.path.join(d, rel_path.replace("/", os.sep))
    if os.path.exists(path):
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Inject just before the closing script tag of the sweetalert listener
        # Or simply append another script block before </body>
        if "abrirModalEditar" not in content and "confirmarDevolucion" not in content and "confirmarResolucion" not in content:
            content = content.replace("</body>", f"<script>{js}</script>\n</body>")
            with open(path, 'w', encoding='utf-8') as f:
                f.write(content)
            print("Injected JS into", rel_path)
