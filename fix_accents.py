import os
import re

replacements = [
    (r'Ocurri.', 'Ocurrió'),
    (r'v.lido', 'válido'),
    (r'Cat.logo', 'Catálogo'),
    (r'Pr.stamos', 'Préstamos'),
    (r'Tecnol.gico', 'Tecnológico'),
    (r'C.mara', 'Cámara'),
    (r'dise.o', 'diseño'),
    (r'Contrase.a', 'Contraseña'),
    (r'conexi.n', 'conexión'),
    (r'.xito', 'Éxito'),
    (r'f.sica', 'física'),
    (r'Da.o', 'Daño'),
    (r'Pr.stamo', 'Préstamo'),
    (r'Sesi.n', 'Sesión'),
    (r'ubicaci.n', 'ubicación'),
    (r'acci.n', 'acción'),
    (r'eliminar.', 'eliminará'),
    (r'volver.', 'volverá'),
    (r'cerrar.', 'cerrará'),
    (r'est.n', 'están'),
    (r'est.', 'está'),
    (r'Est.s', 'Estás'),
    (r'.ltima', 'última'),
    (r'N.MERO', 'NÚMERO'),
    (r'N.mero', 'Número'),
    (r'M.s', 'Más'),
    (r'DESCRIPCI.N', 'DESCRIPCIÓN'),
    (r'UBICACI.N', 'UBICACIÓN'),
    (r'Auditor.a', 'Auditoría'),
    (r'Gesti.n', 'Gestión'),
    (r'inv.lidas', 'inválidas'),
    (r'secci.n', 'sección'),
    (r'autom.ticamente', 'automáticamente'),
    (r'c.digo', 'código'),
    (r'A.adir', 'Añadir'),
    (r'Tama.o', 'Tamaño')
]

d = r'c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend'
for root, _, files in os.walk(d):
    for f in files:
        if f.endswith(('.jsp', '.js', '.html')):
            filepath = os.path.join(root, f)
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as file:
                content = file.read()
            
            orig = content
            for bad, good in replacements:
                content = re.sub(bad.replace('.', r'[^\w\s<>\-"=]'), good, content)
            
            if orig != content:
                with open(filepath, 'w', encoding='utf-8') as file:
                    file.write(content)
                print('Fixed', f)
