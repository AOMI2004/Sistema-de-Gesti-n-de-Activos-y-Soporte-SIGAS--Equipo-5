import os
import re

path = r'c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend\dashboard_administrador\dashboard.jsp'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Add imports if not there
if "DashboardDAO" not in content:
    imports = """<%@ page import="backend.DAO.DashboardDAO" %>
<%
    DashboardDAO dashboardDAO = new DashboardDAO();
    int prestados = dashboardDAO.getEquiposPrestados();
    int bajoStock = dashboardDAO.getMaterialBajoStock();
    int mantenimiento = dashboardDAO.getEquiposEnMantenimiento();
    String ultimaAuditoria = dashboardDAO.getUltimaAuditoria();
%>
"""
    # Insert after charset directive
    content = re.sub(r'(<%@ page contentType="text/html;charset=UTF-8" language="java" %>)', r'\1\n' + imports, content)

# Replace the hardcoded numbers
content = re.sub(r'(<p class="text-muted mb-1 small fw-bold text-uppercase">Equipos Prestados Hoy</p>\s*<h2 class="fw-bold mb-0">)12(</h2>)', r'\1<%= prestados %>\2', content)

content = re.sub(r'(<p class="text-muted mb-1 small fw-bold text-uppercase">Material con Bajo Stock</p>\s*<h2 class="fw-bold mb-0">)3(</h2>)', r'\1<%= bajoStock %>\2', content)

content = re.sub(r'(<p class="text-muted mb-1 small fw-bold text-uppercase">Equipos en Mantenimiento</p>\s*<h2 class="fw-bold mb-0">)5(</h2>)', r'\1<%= mantenimiento %>\2', content)

content = re.sub(r'(<h5 class="fw-bold mb-3">Actividad de Auditoría Reciente</h5>\s*<p class="text-muted small">)Última auditoría QR realizada hace 2 horas por Admin.(</p>)', r'\1Última auditoría general registrada el: <b><%= ultimaAuditoria %></b>\2', content)

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print("Dashboard updated!")
