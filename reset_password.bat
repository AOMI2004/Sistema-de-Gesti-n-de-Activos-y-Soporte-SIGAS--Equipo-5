@echo off
echo ===================================================
echo     RESET CONTRASEÑA ROOT DE MARIADB / MYSQL
echo ===================================================
echo.
echo Creando archivo de reseteo...
echo ALTER USER 'root'@'localhost' IDENTIFIED BY 'SIGAS123'; > "C:\reset_mysql.txt"
echo FLUSH PRIVILEGES; >> "C:\reset_mysql.txt"

echo.
echo Intentando detener servicios de base de datos...
net stop MariaDB 2>nul
net stop MySQL80 2>nul

echo.
echo Aplicando nueva contrasena (SIGAS123) en MariaDB (si existe)...
if exist "C:\Program Files\MariaDB 12.2\bin\mysqld.exe" (
    start "" /B "C:\Program Files\MariaDB 12.2\bin\mysqld.exe" --init-file="C:\reset_mysql.txt" --console
    timeout /t 5 /nobreak >nul
    taskkill /F /IM mysqld.exe >nul
)

echo.
echo Aplicando nueva contrasena (SIGAS123) en MySQL 8.0 (si existe)...
if exist "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe" (
    start "" /B "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe" --init-file="C:\reset_mysql.txt" --console
    timeout /t 5 /nobreak >nul
    taskkill /F /IM mysqld.exe >nul
)

echo.
echo Limpiando archivos temporales...
del "C:\reset_mysql.txt"

echo.
echo Reiniciando servicios...
net start MariaDB 2>nul
net start MySQL80 2>nul

echo.
echo ===================================================
echo ¡LISTO! Tu contrasena ha sido cambiada a: SIGAS123
echo Ya puedes cerrar esta ventana negra.
echo ===================================================
pause
