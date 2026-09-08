import os
import re

d = r'c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend'
for root, _, files in os.walk(d):
    for f in files:
        if f.endswith('.jsp') and 'login' not in f:
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8', errors='ignore') as file:
                content = file.read()
            
            orig = content
            # find <script src="../assets/js/sidebar.js"></script> or similar
            # and prepend the global variable
            if "const userRole =" not in content:
                content = re.sub(r'(<script src="\.\./assets/js/sidebar\.js"></script>)', 
                                 r'<script>const userRole = "<%= session.getAttribute("rol") != null ? session.getAttribute("rol") : "" %>";</script>\n\1', 
                                 content)
            
            if orig != content:
                with open(path, 'w', encoding='utf-8') as file:
                    file.write(content)
                print('Injected role into', f)
