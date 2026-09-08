import os
path = r'c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend\gestion_usuarios\usuarios.jsp'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace("document.getElementById('edit_matricula_hidden').value = matricula;", "document.getElementById('e_mat').value = matricula;")
c = c.replace("document.getElementById('edit_matricula_display').value = matricula;", "// no display id")
c = c.replace("document.getElementById('edit_nombre').value = nombre;", "document.getElementById('e_nom').value = nombre;")
c = c.replace("document.getElementById('edit_correo').value = correo;", "document.getElementById('e_cor').value = correo;")
c = c.replace("document.getElementById('edit_rol').value = rol;", "document.getElementById('e_rol').value = rol;")
c = c.replace("document.getElementById('edit_estatus').value = estatus;", "document.getElementById('e_est').value = estatus;")

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)
