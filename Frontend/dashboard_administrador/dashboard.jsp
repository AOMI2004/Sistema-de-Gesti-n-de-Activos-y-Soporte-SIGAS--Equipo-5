<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIGAS - Dashboard Administrador</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
    <div class="container-fluid p-0">
        <div class="d-flex">
            <div id="sidebar-container" class="col-md-2 p-0" style="min-width: 280px; max-width: 280px;"></div><script src="../assets/js/sidebar.js"></script>

            <div class="main-content flex-grow-1 p-4 bg-light">
                <header class="mb-4">
                    <h2 class="fw-bold mb-1">Dashboard</h2>
                    <p class="text-muted">Resumen general del estado de inventario y préstamos.</p>
                </header>

                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="stat-card d-flex justify-content-between align-items-center shadow-sm">
                            <div>
                                <p class="text-muted mb-1 small fw-bold text-uppercase">Equipos Prestados Hoy</p>
                                <h2 class="fw-bold mb-0">12</h2>
                            </div>
                            <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                                <i class="bi bi-display"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="stat-card d-flex justify-content-between align-items-center shadow-sm">
                            <div>
                                <p class="text-muted mb-1 small fw-bold text-uppercase">Material con Bajo Stock</p>
                                <h2 class="fw-bold mb-0">3</h2>
                            </div>
                            <div class="stat-icon bg-warning bg-opacity-10 text-warning">
                                <i class="bi bi-exclamation-triangle"></i>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="stat-card d-flex justify-content-between align-items-center shadow-sm">
                            <div>
                                <p class="text-muted mb-1 small fw-bold text-uppercase">Equipos en Mantenimiento</p>
                                <h2 class="fw-bold mb-0">5</h2>
                            </div>
                            <div class="stat-icon bg-secondary bg-opacity-10 text-secondary">
                                <i class="bi bi-wrench"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row mt-5">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm p-4">
                            <h5 class="fw-bold mb-3">Actividad de Auditoría Reciente</h5>
                            <p class="text-muted small">Última auditoría QR realizada hace 2 horas por Admin.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>