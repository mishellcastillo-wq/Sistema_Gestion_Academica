USE sistema_academico;

CREATE TABLE Estudiante (
cedula varchar(10) primary key,
nombres varchar(40) not null,
apellidos varchar(40) not null,
direccion varchar(50) not null,
telefono varchar(10) not null,
correo varchar(50) not null
);

CREATE TABLE Curso (
identificador varchar(10) primary key,
nombre varchar(20) not null,
jornada enum("Matutina", "Vespertina", "Nocturna") not null
);

CREATE TABLE Docente (
cedula varchar(10) primary key,
nombres varchar(20) not null,
apellidos varchar(20) not null,
telefono varchar(10) not null,
correo varchar(20) not null
);

CREATE TABLE Materia (
codigo varchar(10) primary key,
nombre varchar(20) not null,
descripcion text,
identificador_Curso varchar(10) not null,
cedula_Docente varchar(10),
foreign key(identificador_Curso) references Curso(identificador),
foreign key(cedula_Docente) references Docente(cedula)
);

CREATE TABLE Matricula (
    codigo_Matricula int auto_increment primary key,
    cedula_Estudiante varchar(10) not null,
    codigo_Materia varchar(10) not null,
    foreign key (cedula_Estudiante) references Estudiante(cedula),
    foreign key (codigo_Materia) references Materia(codigo)
);

CREATE TABLE Calificacion (
    identificador int auto_increment primary key,
    nota_final decimal(4,2) not null,
    estado enum("Aprobado", "Supletorio") not null,
    codigo_Matricula int not null,
    foreign key (codigo_Matricula) references Matricula(codigo_Matricula)
);

CREATE TABLE Supletorio (
    identificador int auto_increment primary key,
    nota_examen_supletorio decimal(4,2) not null,
    nota_final decimal(4,2) NOT NULL,
    resultado enum("Aprobado", "Reprobado") not null,
    identificador_Calificacion int not null,
    foreign key (identificador_Calificacion) references Calificacion(identificador)
);
