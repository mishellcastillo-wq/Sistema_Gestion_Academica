-- ============================================================
-- CONSULTAS SQL - ÁLGEBRA RELACIONAL
-- Academia de Formación "Vida Activa"
-- Sistema de Gestión Académica
-- ============================================================

USE sistema_academico;

-- ============================================================
-- CONSULTA 1: Materias que pertenecen al curso de Boxeo
-- π nombre(σ identificador == identificador_Curso(
--   (π nombre, identificador_Curso(Materia))
--   × (π identificador(σ nombre == "Boxeo"(Curso)))
-- ))
-- ============================================================
SELECT materia1.nombre
FROM
  (SELECT nombre, identificador_Curso FROM Materia) AS materia1
  CROSS JOIN
  (SELECT identificador FROM Curso WHERE nombre = 'Boxeo') AS curso1
WHERE materia1.identificador_Curso = curso1.identificador;


-- ============================================================
-- CONSULTA 2: Nombres de docentes y las materias que imparten
-- π nombre, nombres(σ cedula == cedula_Docente(
--   (π nombre, cedula_Docente(Materia))
--   × (π cedula, nombres(Docente))
-- ))
-- ============================================================
SELECT materia1.nombre, docente1.nombres
FROM
  (SELECT nombre, cedula_Docente FROM Materia) AS materia1
  CROSS JOIN
  (SELECT cedula, nombres FROM Docente) AS docente1
WHERE materia1.cedula_Docente = docente1.cedula;


-- ============================================================
-- CONSULTA 3: Estudiantes con nota aprobatoria en sus materias
-- π nombres, nombre, estado(σ cedula == cedula_Estudiante
--   AND codigo == codigo_Materia
--   AND codigo_Matricula == cod_Matricula(
--   (π cedula, nombres(Estudiante))
--   × (π codigo, nombre(Materia))
--   × (ρ codigo_Matricula → cod_Matricula(Matricula))
--   × (π estado, codigo_Matricula(Calificacion))
-- ))
-- ============================================================
SELECT estudiante1.nombres, materia1.nombre, calificacion1.estado
FROM
  (SELECT cedula, nombres
   FROM Estudiante) AS estudiante1
  CROSS JOIN
  (SELECT codigo, nombre
   FROM Materia) AS materia1
  CROSS JOIN
  (SELECT cedula_Estudiante, codigo_Materia,
          codigo_Matricula AS cod_Matricula
   FROM Matricula) AS matricula1
  CROSS JOIN
  (SELECT estado, codigo_Matricula
   FROM Calificacion) AS calificacion1
WHERE estudiante1.cedula    = matricula1.cedula_Estudiante
  AND materia1.codigo       = matricula1.codigo_Materia
  AND calificacion1.codigo_Matricula = matricula1.cod_Matricula
  AND calificacion1.estado  = 'Aprobado';


-- ============================================================
-- CONSULTA 4: Materias de jornada Matutina con su docente
-- π nombre, jornada, nombres(σ identificador_Curso == identificador
--   AND cedula_Docente == cedula(
--   (π nombre, identificador_Curso, cedula_Docente(Materia))
--   × (σ jornada == 'Matutina'(π identificador, jornada(Curso)))
--   × (π cedula, nombres(Docente))
-- ))
-- ============================================================
SELECT materia1.nombre, curso1.jornada, docente1.nombres
FROM
  (SELECT nombre, identificador_Curso, cedula_Docente
   FROM Materia) AS materia1
  CROSS JOIN
  (SELECT identificador, jornada
   FROM Curso
   WHERE jornada = 'Matutina') AS curso1
  CROSS JOIN
  (SELECT cedula, nombres
   FROM Docente) AS docente1
WHERE materia1.identificador_Curso = curso1.identificador
  AND materia1.cedula_Docente      = docente1.cedula;


-- ============================================================
-- CONSULTA 5: Estudiantes que reprobaron definitivamente en supletorio
-- π nombres, resultado(σ cedula == cedula_Estudiante
--   AND cod_Matricula == codigo_Matricula
--   AND identificador == identificador_Calificacion(
--   (π cedula, nombres(Estudiante))
--   × (π cedula_Estudiante, cod_Matricula(ρ codigo_Matricula → cod_Matricula(Matricula)))
--   × (π identificador, codigo_Matricula(Calificacion))
--   × (π resultado, identificador_Calificacion(σ resultado == 'Reprobado'(Supletorio)))
-- ))
-- ============================================================
SELECT estudiante1.nombres, supletorio1.resultado
FROM
  (SELECT cedula, nombres
   FROM Estudiante) AS estudiante1
  CROSS JOIN
  (SELECT cedula_Estudiante, codigo_Matricula AS cod_Matricula
   FROM Matricula) AS matricula1
  CROSS JOIN
  (SELECT identificador, codigo_Matricula
   FROM Calificacion) AS calificacion1
  CROSS JOIN
  (SELECT resultado, identificador_Calificacion
   FROM Supletorio
   WHERE resultado = 'Reprobado') AS supletorio1
WHERE estudiante1.cedula             = matricula1.cedula_Estudiante
  AND matricula1.cod_Matricula       = calificacion1.codigo_Matricula
  AND calificacion1.identificador    = supletorio1.identificador_Calificacion;
