-- Script base de datos

-- 1. Tabla sgi_alumnos
CREATE TABLE sgi_alumnos (
    id_alumno INT AUTO_INCREMENT PRIMARY KEY,
    nif_nie VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_entidad INT NOT NULL,
    id_ciclo INT NOT NULL,
    curso INT NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(255),
    cp VARCHAR(10),
    localidad VARCHAR(100),
    id_provincia INT, 
    observaciones TEXT,
    
    -- Claves foráneas apuntando a las tablas sgi_* existentes
    CONSTRAINT fk_alumnos_entidad FOREIGN KEY (id_entidad) REFERENCES sgi_entidades(id_entidad),
    CONSTRAINT fk_alumnos_ciclo FOREIGN KEY (id_ciclo) REFERENCES sgi_ciclos(id_ciclo),
    CONSTRAINT fk_alumnos_provincia FOREIGN KEY (id_provincia) REFERENCES sgi_provincias(id_provincia) 
);

-- 2. Tabla sgi_vacantes
CREATE TABLE sgi_vacantes (
    id_vacante INT AUTO_INCREMENT PRIMARY KEY,
    id_entidad INT NOT NULL,
    id_ciclo INT NOT NULL,
    curso INT NOT NULL,
    num_vacantes INT NOT NULL,
    observaciones TEXT,
    
    UNIQUE(id_entidad, id_ciclo, curso),
    
    CONSTRAINT fk_vacantes_entidad FOREIGN KEY (id_entidad) REFERENCES sgi_entidades(id_entidad),
    CONSTRAINT fk_vacantes_ciclo FOREIGN KEY (id_ciclo) REFERENCES sgi_ciclos(id_ciclo)
);

-- 3. Tabla auxiliar
CREATE TABLE sgi_vacantes_X_alumnos (
    id_vacante_x_alumno INT AUTO_INCREMENT PRIMARY KEY,
    id_vacante INT NOT NULL,
    id_alumno INT NOT NULL UNIQUE, 
    
    CONSTRAINT fk_va_vacante FOREIGN KEY (id_vacante) REFERENCES sgi_vacantes(id_vacante) ON DELETE CASCADE,
    CONSTRAINT fk_va_alumno FOREIGN KEY (id_alumno) REFERENCES sgi_alumnos(id_alumno) ON DELETE CASCADE
);