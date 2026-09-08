import os
import re

frontend_dir = r"c:\Users\Aster\Documents\Sistema-de-Gesti-n-de-Activos-y-Soporte-SIGAS--Equipo-5\Frontend"

for root, dirs, files in os.walk(frontend_dir):
    for file in files:
        if file.endswith('.html') and 'login' not in file and 'dashboard' not in file:
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            # Find the <tbody> and remove everything inside it
            # We'll replace <tbody>...</tbody> with <tbody>\n                        </tbody>
            pattern = re.compile(r'(<tbody>)(.*?)(</tbody>)', re.IGNORECASE | re.DOTALL)
            
            # Keep the tbody tags but remove the dummy rows
            new_content = pattern.sub(r'\1\n                        \3', content)

            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)
                
            print(f"Cleaned {file}")
