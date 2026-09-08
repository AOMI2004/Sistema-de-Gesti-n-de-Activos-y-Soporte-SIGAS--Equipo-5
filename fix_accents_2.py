import os
d = r'c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend'
files_to_fix = ['auditoria_QR/auditoria.jsp', 'dashboard_administrador/dashboard.jsp', 'assets/js/sidebar.js', 'reportes/reportes.jsp', 'prestamos_devoluciones/devoluciones.jsp']

fixes = {
    "Ocurri\ufffd": "Ocurrió",
    "conexi\ufffdn": "conexión",
    "Auditor\ufffda": "Auditoría",
    "f\ufffdsica": "física",
    "Pr\ufffdstamo": "Préstamo",
    "C\ufffdmara": "Cámara",
    "\ufffdxito": "Éxito",
    "c\ufffddigo": "código",
    "Gesti\ufffdn": "Gestión",
    "Cat\ufffdlogo": "Catálogo",
    "Sesi\ufffdn": "Sesión",
    "secci\ufffdn": "sección",
    "Da\ufffdo": "Daño",
    "inv\ufffdlidas": "inválidas",
    "Est\ufffds": "Estás",
    "est\ufffd": "está",
    "est\ufffdn": "están",
    "autom\ufffdticamente": "automáticamente",
    "Pr\ufffdstamos": "Préstamos"
}

for rel in files_to_fix:
    path = os.path.join(d, rel.replace('/', os.sep))
    if os.path.exists(path):
        with open(path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        for b, g in fixes.items():
            content = content.replace(b, g)
            
        # Also replace CP1252 leftovers if any
        content = content.replace("ǭ", "á").replace("Ǹ", "é").replace("ǧ", "ú").replace("", "")
        
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        print("Fixed", rel)
