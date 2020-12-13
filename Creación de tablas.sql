--creacion de las tablas

CREATE TABLE colegio(
    codigo int NOT NULL,
    nombre varchar(100) NOT NULL,
    ciudad varchar(100) NOT NULL,
    PRIMARY KEY (codigo),
    UNIQUE(codigo)
);

CREATE TABLE trabajador(
    dni varchar(8),
    col_codigo int,
    horario_i date,
    horario_s date,
    num_contacto varchar(12),
    nombre varchar(100) NOT NULL,
    apellido varchar(100) NOT NULL,
    PRIMARY KEY(dni),
    FOREIGN KEY(col_codigo) REFERENCES colegio(codigo),
    UNIQUE(dni)
);

CREATE TABLE profesor(
    t_dni varchar(8),
    horas_d int,
    PRIMARY KEY(t_dni),
    FOREIGN KEY(t_dni) REFERENCES trabajador(dni) 
);

CREATE TABLE administrativo(
    t_dni varchar(8),
    cargo varchar(100) NOT NULL,
    PRIMARY KEY(t_dni),
    FOREIGN KEY(t_dni) REFERENCES trabajador(dni)
);

CREATE TABLE matricula(
    codigo int,
    fecha date NOT NULL,
    seccion varchar(100) NOT NULL,
    PRIMARY KEY(codigo),
    UNIQUE(codigo)
);

CREATE TABLE estudiante(
    dni varchar(8),
    col_codigo int,
    m_codigo int,
    tlf_c varchar(12),
    nombre varchar(100) NOT NULL,
    apellido varchar(100) NOT NULL,
    nombre_ap varchar(100),
    direccion varchar(100),
    PRIMARY KEY(dni),
    FOREIGN KEY(col_codigo) REFERENCES colegio(codigo),
    FOREIGN KEY(m_codigo) REFERENCES matricula(codigo),
    UNIQUE(dni)
);

CREATE TABLE curso(
    codigo int,
    nombre varchar(100) NOT NULL,
    PRIMARY KEY(codigo),
    UNIQUE(codigo)
);

CREATE TABLE evaluacion(
    nombre varchar(100),
    c_codigo int,
    fecha date,
    PRIMARY KEY(nombre, c_codigo),
    FOREIGN KEY(c_codigo) REFERENCES curso(codigo),
    UNIQUE(nombre)
);

CREATE TABLE nota(
    es_dni varchar(8),
    ev_nombre varchar(100),
    c_codigo int,
    valor int NOT NULL,
    PRIMARY KEY(es_dni, ev_nombre, c_codigo),
    FOREIGN KEY(es_dni) REFERENCES estudiante(dni),
    FOREIGN KEY(ev_nombre) REFERENCES evaluacion(nombre),
    FOREIGN KEY(c_codigo) REFERENCES curso(codigo),   
    CONSTRAINT  CHK_Nota  CHECK (valor >=0 AND valor <=20)
);

CREATE TABLE inscribe(
    cu_codigo int,
    mat_codigo int,
    PRIMARY KEY(cu_codigo, mat_codigo),
    FOREIGN KEY(cu_codigo) REFERENCES curso(codigo),
    FOREIGN KEY(mat_codigo) REFERENCES matricula(codigo)
);

CREATE TABLE ensenha(
    t_dni varchar(8),
    cu_codigo int,
    PRIMARY KEY(cu_codigo, t_dni),
    FOREIGN KEY(cu_codigo) REFERENCES curso(codigo),
    FOREIGN KEY(t_dni) REFERENCES trabajador(dni)
);