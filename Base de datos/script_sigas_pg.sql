-- =========================================================
-- SCRIPT PARA POSTGRESQL
-- (Asegúrate de ejecutar esto dentro de la base de datos sigas_db)
-- =========================================================

-- =========================================================
-- ELIMINACIÓN DE TABLAS EXISTENTES (Para poder reiniciar la BD)
-- =========================================================
DROP TABLE IF EXISTS REPORTE_FALLA CASCADE;
DROP TABLE IF EXISTS PRESTAMO CASCADE;
DROP TABLE IF EXISTS MATERIAL CASCADE;
DROP TABLE IF EXISTS EQUIPO CASCADE;
DROP TABLE IF EXISTS RACK_UBICACION CASCADE;
DROP TABLE IF EXISTS USUARIO CASCADE;

-- =========================================================
-- 1. Tabla RACK_UBICACION
-- =========================================================
CREATE TABLE RACK_UBICACION (
    ID_Rack SERIAL PRIMARY KEY,
    Nombre_Ubicacion VARCHAR(100) NOT NULL
);

-- =========================================================
-- 2. Tabla USUARIO
-- =========================================================
CREATE TABLE USUARIO (
    Matricula_ID VARCHAR(20) PRIMARY KEY,
    Nombre_Completo VARCHAR(150) NOT NULL,
    Correo VARCHAR(100) NOT NULL UNIQUE,
    Contrasena_Hash VARCHAR(255) NOT NULL,
    Rol VARCHAR(50) NOT NULL, -- (Administrador, Docente, Alumno)
    Estatus VARCHAR(20) NOT NULL DEFAULT 'Activo'
);

-- =========================================================
-- 3. Tabla EQUIPO
-- =========================================================
CREATE TABLE EQUIPO (
    ID_Equipo_QR VARCHAR(50) PRIMARY KEY,
    Num_Serie VARCHAR(100) NOT NULL UNIQUE,
    Marca VARCHAR(100) NOT NULL,
    Modelo VARCHAR(100) NOT NULL,
    Estado VARCHAR(50) NOT NULL, -- (Disponible, En Mantenimiento, Prestado)
    Ultima_Auditoria DATE,
    ID_Rack INT,
    FOREIGN KEY (ID_Rack) REFERENCES RACK_UBICACION(ID_Rack) ON DELETE SET NULL
);

-- =========================================================
-- 4. Tabla MATERIAL
-- =========================================================
CREATE TABLE MATERIAL (
    ID_Material SERIAL PRIMARY KEY,
    Nombre_Pieza VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Cantidad_Stock INT NOT NULL,
    Ultima_Auditoria DATE,
    ID_Rack INT,
    FOREIGN KEY (ID_Rack) REFERENCES RACK_UBICACION(ID_Rack) ON DELETE SET NULL
);

-- =========================================================
-- 5. Tabla PRESTAMO
-- =========================================================
CREATE TABLE PRESTAMO (
    ID_Prestamo SERIAL PRIMARY KEY,
    Fecha_Salida DATE NOT NULL,
    Fecha_Limite DATE NOT NULL,
    Fecha_Devolucion DATE,
    Estado_Prestamo VARCHAR(50) NOT NULL,
    Matricula_ID VARCHAR(20),
    ID_Equipo_QR VARCHAR(50),
    FOREIGN KEY (Matricula_ID) REFERENCES USUARIO(Matricula_ID) ON DELETE SET NULL,
    FOREIGN KEY (ID_Equipo_QR) REFERENCES EQUIPO(ID_Equipo_QR) ON DELETE SET NULL
);

-- =========================================================
-- 6. Tabla REPORTE_FALLA
-- =========================================================
CREATE TABLE REPORTE_FALLA (
    ID_Reporte SERIAL PRIMARY KEY,
    Descripcion_Dano TEXT NOT NULL,
    Fecha_Reporte DATE NOT NULL,
    Estado_Resolucion VARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    ID_Equipo_QR VARCHAR(50),
    ID_Prestamo INT,
    FOREIGN KEY (ID_Equipo_QR) REFERENCES EQUIPO(ID_Equipo_QR) ON DELETE CASCADE,
    FOREIGN KEY (ID_Prestamo) REFERENCES PRESTAMO(ID_Prestamo) ON DELETE SET NULL
);

-- =========================================================
-- INSERCIONES POR DEFECTO
-- =========================================================
INSERT INTO USUARIO (Matricula_ID, Nombre_Completo, Correo, Contrasena_Hash, Rol, Estatus) 
VALUES ('ADMIN-001', 'Administrador Principal', 'admin@saltillo.tecnm.mx', 'SIGAS123', 'Administrador', 'Activo');
