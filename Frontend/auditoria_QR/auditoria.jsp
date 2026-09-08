<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIGAS - Auditoría QR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="auditoria.css">
</head>
<body style="overflow-y: scroll; background-color: #f8fafc;">
    <div class="container-fluid p-0">
        <div class="d-flex">
                        <div id="sidebar-container" class="col-md-2 p-0" style="min-width: 280px; max-width: 280px;"></div><script src="../assets/js/sidebar.js"></script>
            <div class="main-content flex-grow-1 p-4 text-center">
                <h2 class="fw-bold mb-1">Auditoría de Inventario mediante QR</h2>
                <p class="text-muted mb-4">Simula el escaneo del código para verificar su presencia física en el laboratorio.</p>
                <div class="scanner-container mx-auto" style="max-width: 600px;">
                    <div class="card border-0 shadow-sm p-4">
                        <h5 class="fw-bold mb-3">Auditoría en Tiempo Real</h5>
                        <div class="camera-view mb-4 position-relative rounded-3 bg-dark d-flex align-items-center justify-content-center text-white" style="height: 300px; overflow: hidden;">
                            <div class="scan-overlay"></div>
                            <div class="text-center opacity-50">
                                <i class="bi bi-camera-fill fs-1 mb-2"></i>
                                <p class="mb-0 small">Simulador de Cámara Activo...</p>
                            </div>
                        </div>
                            <div class="alert alert-success d-flex align-items-center justify-content-center py-2 mb-3" role="alert">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                <div>¡Equipo <b>...</b> auditado hoy!</div>
                            </div>
                            
                            </div>
                        <form action="../../AuditoriaQR" method="POST">
                            <div class="mb-3 text-start">
                                <label class="form-label small fw-bold text-muted">ID DEL EQUIPO DETECTADO</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-qr-code"></i></span>
                                    <input type="text" name="id_qr" class="form-control text-center py-2 fw-bold" placeholder="Ej. QR-10044" required autofocus>
                                    <button type="submit" class="btn btn-primary fw-bold px-4">Procesar</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

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
