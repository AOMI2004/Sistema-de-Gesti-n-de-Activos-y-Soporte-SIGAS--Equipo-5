<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIGAS - Inventario de Equipos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
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
        .icon-action { color: #5f6368; cursor: pointer; margin-right: 10px; transition: 0.2s; }
        .icon-action:hover { color: #0d1b2a; }
        .icon-delete:hover { color: #d93025; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- MENÚ LATERAL -->
            <div class="col-md-2 sidebar d-flex flex-column p-0">
                <h4 class="text-center mb-4 text-white fw-bold mt-3"><i class="bi bi-layers"></i> Admin Panel</h4>
                <!-- CORRECCIÓN: Rutas relativas corregidas para que no se pierda -->
                <a href="../dashboard_administrador/dashboard.html"><i class="bi bi-grid-1x2"></i> Inicio</a>
                <a href="inventario.jsp" class="active"><i class="bi bi-pc-display"></i> Catálogo de Equipos</a>
                <a href="#"><i class="bi bi-box-seam"></i> Catálogo de Materiales</a>
                <a href="../auditoria_QR/auditoria.html"><i class="bi bi-qr-code-scan"></i> Auditoría QR</a>
                <a href="#"><i class="bi bi-arrow-left-right"></i> Préstamos y Devoluciones</a>
                <a href="../mapa_rack/racks.html"><i class="bi bi-hdd-rack"></i> Gestión de Racks</a>
                <a href="#"><i class="bi bi-people"></i> Usuarios</a>
                <a href="#"><i class="bi bi-file-earmark-text"></i> Reportes</a>
                <div class="mt-auto mb-4">
                    <a href="../../Logout"><i class="bi bi-box-arrow-left"></i> Cerrar Sesión</a>
                </div>
            </div>

            <!-- CONTENIDO PRINCIPAL -->
            <div class="col-md-10 main-content">
                <h2 class="fw-bold mb-4">Inventario de Equipos Principales</h2>

                <!-- MENSAJES DE ÉXITO O ERROR -->
                <% if(request.getParameter("registro") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>¡Éxito!</strong> El equipo se ha registrado correctamente en la base de datos.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>

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
                            <% 
                                String dbURL = "jdbc:mysql://localhost:3306/sigas_db";
                                String dbUser = "root";
                                String dbPass = "SIGAS123";
                                
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM EQUIPO");
                                    
                                    while(rs.next()) {
                                        String idQr = rs.getString("ID_Equipo_QR");
                                        String marca = rs.getString("Marca");
                                        String modelo = rs.getString("Modelo");
                                        String numSerie = rs.getString("Num_Serie");
                                        String estado = rs.getString("Estado");
                                        
                                        String badgeClass = "bg-success text-success border-success";
                                        String iconClass = "bi-check-circle";
                                        
                                        if("En Mantenimiento".equals(estado)) {
                                            badgeClass = "bg-danger text-danger border-danger";
                                            iconClass = "bi-wrench";
                                        } else if("Prestado".equals(estado)) {
                                            badgeClass = "bg-warning text-warning border-warning";
                                            iconClass = "bi-box-arrow-right";
                                        }
                            %>
                            <tr>
                                <td class="fw-bold"><%= idQr %></td>
                                <td><%= marca %> / <%= modelo %></td>
                                <td class="text-muted"><%= numSerie %></td>
                                <td><span class="badge <%= badgeClass %> bg-opacity-10 border rounded-pill px-3 py-2"><i class="bi <%= iconClass %>"></i> <%= estado %></span></td>
                                <td>
                                    <i class="bi bi-pencil icon-action"></i>
                                    <i class="bi bi-trash icon-action icon-delete text-danger"></i>
                                </td>
                            </tr>
                            <%
                                    }
                                    rs.close(); stmt.close(); conn.close();
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='5' class='text-center text-danger'>Error al cargar base de datos: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL PARA AGREGAR EQUIPO -->
    <div class="modal fade" id="modalAgregarEquipo" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Registrar Nuevo Equipo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <!-- CORRECCIÓN: Asegúrate de que esta ruta llegue al controlador -->
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>