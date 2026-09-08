# Script para compilar el proyecto manualmente

$libPath = "WEB-INF\lib\*"
$classesPath = "WEB-INF\classes"

# Crear carpeta de clases si no existe
if (!(Test-Path -Path $classesPath)) {
    New-Item -ItemType Directory -Path $classesPath | Out-Null
}

$javaFiles = Get-ChildItem -Path "backend" -Recurse -Filter "*.java"
$archivos = $javaFiles | Select-Object -ExpandProperty FullName

# Compilar todo de golpe para que resuelva las dependencias entre paquetes
Write-Host "Compilando clases Java..."
javac -d $classesPath -cp ".;$libPath" $archivos

Write-Host "Compilación finalizada."
