# Script para compilar el proyecto manualmente

$libPath = "WEB-INF\lib\*"
$classesPath = "WEB-INF\classes"

# Crear carpeta de clases si no existe
if (!(Test-Path -Path $classesPath)) {
    New-Item -ItemType Directory -Path $classesPath | Out-Null
}

# Obtener todos los archivos .java
$javaFiles = Get-ChildItem -Path "backend" -Recurse -Filter "*.java"

# Compilar
Write-Host "Compilando clases Java..."
foreach ($file in $javaFiles) {
    # -d indica el directorio de destino
    # -cp indica el classpath (librerias)
    javac -d $classesPath -cp ".;$libPath" $file.FullName
}

Write-Host "Compilación finalizada."
