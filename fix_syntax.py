import os
import re

d = r'c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend'
for root, _, files in os.walk(d):
    for f in files:
        if f.endswith(('.jsp', '.js', '.html')):
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8', errors='ignore') as file:
                content = file.read()
            
            orig = content
            content = re.sub(r"confirmButtonText:\s*'.*?'.*?,", "confirmButtonText: 'Sí, confirmar',", content)
            
            # Also catch any dangling eliminar stuff like: confirmButtonText: 'Sí, confirmar', eliminarǭ,
            content = re.sub(r"confirmButtonText:\s*'.*?',\s*eliminar.*?,", "confirmButtonText: 'Sí, confirmar',", content)
            
            if orig != content:
                with open(path, 'w', encoding='utf-8') as file:
                    file.write(content)
                print('Fixed syntax in', f)
