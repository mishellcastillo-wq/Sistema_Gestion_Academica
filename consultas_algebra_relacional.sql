-- ===========================================================
-- Sistema de Gestión Académica
-- ============================================================

-- ============================================================
--   1. Nombres de las materias que pertenecen al curso Boxeo
-- ------------------------------------------------------------
-- ÁLGEBRA RELACIONAL:
--   π nombre(
--     σ nombre_Curso == 'Boxeo' (ρ nombre → nombre_Curso(curso))
--     ⋈
--     (ρ identificador_Curso → identificador (materia))
--   )
-- ------------------------------------------------------------
-- SQL:
SELECT materia.nombre
FROM
  (SELECT identificador, nombre AS nombre_Curso
   FROM Curso
   WHERE nombre = 'Boxeo') AS curso
INNER JOIN
  (SELECT codigo, nombre,
          identificador_Curso AS identificador
   FROM Materia) AS materia
ON curso.identificador = materia.identificador;


-- ============================================================
--   2. Nombres de docentes y las materias que imparten
-- ------------------------------------------------------------
-- ÁLGEBRA RELACIONAL:
--   π nombre, nombres(
--     (Docente)
--     ⋈
--     (ρ cedula_Docente → cedula (Materia))
--   )
-- ------------------------------------------------------------
-- SQL:
SELECT docente.nombres, materia.nombre
FROM
  Docente AS docente
INNER JOIN
  (SELECT codigo, nombre,
          cedula_Docente AS cedula
   FROM Materia) AS materia
ON docente.cedula = materia.cedula;


-- ============================================================
--   3. Nombres de estudiantes con nota aprobatoria en sus materias
-- ------------------------------------------------------------
-- ÁLGEBRA RELACIONAL:
--   π nombres, nombre, estado(
--     σ cedula == cedula_Estudiante
--       AND codigo == codigo_Materia
--       AND codigo_Matricula == cod_Matricula(
--       (π cedula, nombres (estudiante))
--     * (π codigo, nombre (materia))
--     * (ρ codigo_Matricula → cod_Matricula (matricula))
--     * (π estado, codigo_Matricula (calificacion))
--   ))
-- ------------------------------------------------------------
-- SQL:
SELECT estudiante.nombres, materia.nombre, calificacion.estado
FROM
  (SELECT cedula, nombres
   FROM Estudiante) AS estudiante
  CROSS JOIN
  (SELECT codigo, nombre
   FROM Materia) AS materia
  CROSS JOIN
  (SELECT cedula_Estudiante, codigo_Materia,
          codigo_Matricula AS cod_Matricula
   FROM Matricula) AS matricula
  CROSS JOIN
  (SELECT estado, codigo_Matricula
   FROM Calificacion) AS calificacion
WHERE estudiante.cedula               = matricula.cedula_Estudiante
  AND materia.codigo                  = matricula.codigo_Materia
  AND calificacion.codigo_Matricula   = matricula.cod_Matricula
  AND calificacion.estado             = 'Aprobado';


-- ============================================================
--   4. Materias de jornada matutina con su docente
-- ------------------------------------------------------------
-- ÁLGEBRA RELACIONAL:
--   π nombre, jornada, nombres(
--     σ identificador_Curso == identificador
--       AND cedula_Docente == cedula(
--       (π nombre, identificador_Curso, cedula_Docente (materia))
--     * (σ jornada == 'Matutina' (π identificador, jornada (curso)))
--     * (π cedula, nombres (docente))
--   ))
-- ------------------------------------------------------------
-- SQL:
SELECT materia.nombre, curso.jornada, docente.nombres
FROM
  (SELECT nombre, identificador_Curso, cedula_Docente
   FROM Materia) AS materia
  CROSS JOIN
  (SELECT identificador, jornada
   FROM Curso
   WHERE jornada = 'Matutina') AS curso
  CROSS JOIN
  (SELECT cedula, nombres
   FROM Docente) AS docente
WHERE materia.identificador_Curso = curso.identificador
  AND materia.cedula_Docente      = docente.cedula;


-- ============================================================
--   5. Nombres de estudiantes que reprobaron definitivamente en supletorio
-- ------------------------------------------------------------
-- ÁLGEBRA RELACIONAL:
--   π nombres, resultado(
--     σ cedula == cedula_Estudiante
--       AND cod_Matricula == codigo_Matricula
--       AND identificador == identificador_Calificacion(
--       (π cedula, nombres (estudiante))
--     * (π cedula_Estudiante, cod_Matricula (ρ codigo_Matricula → cod_Matricula (matricula)))
--     * (π identificador, codigo_Matricula (calificacion))
--     * (π resultado, identificador_Calificacion (σ resultado == 'Reprobado' (supletorio)))
--   ))
-- ------------------------------------------------------------
-- SQL:
SELECT estudiante.nombres, supletorio.resultado
FROM
  (SELECT cedula, nombres
   FROM Estudiante) AS estudiante
  CROSS JOIN
  (SELECT cedula_Estudiante,
          codigo_Matricula AS cod_Matricula
   FROM Matricula) AS matricula
  CROSS JOIN
  (SELECT identificador, codigo_Matricula
   FROM Calificacion) AS calificacion
  CROSS JOIN
  (SELECT resultado, identificador_Calificacion
   FROM Supletorio
   WHERE resultado = 'Reprobado') AS supletorio
WHERE estudiante.cedula          = matricula.cedula_Estudiante
  AND matricula.cod_Matricula    = calificacion.codigo_Matricula
  AND calificacion.identificador = supletorio.identificador_Calificacion;