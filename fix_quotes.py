import os

d = r'c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend'
for root, _, files in os.walk(d):
    for f in files:
        if f.endswith(('.jsp', '.js', '.html')):
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8', errors='ignore') as file:
                content = file.read()
            
            orig = content
            content = content.replace("eliminará }", "eliminar' }")
            content = content.replace("volverá }", "volver' }")
            content = content.replace("cerrará }", "cerrar' }")
            
            if orig != content:
                with open(path, 'w', encoding='utf-8') as file:
                    file.write(content)
                print('Fixed quote syntax in', f)
