
-- INSERCIÓN DE DATOS - SISTEMA DE GESTIÓN ACADÉMICA
-- Academia "Vida Activa"
-- ============================================================
 
USE sistema_academico;

-- ============================================================
-- TABLA: Estudiante
-- ============================================================
INSERT INTO Estudiante (cedula, nombres, apellidos, direccion, telefono, correo) VALUES
  ('0485964547', 'Milena Samanta',     'Malla Vega',      'Loja, La Banda',       '0965842154', 'samanta@gmail.com'),
  ('1100451213', 'Pauleth Monserrath', 'Vazquez Ojeda',   'Loja, Daniel Alvarez', '0925485645', 'monserrath@gmail.com'),
  ('1150528899', 'Mishell Vanessa',    'Castillo Flores', 'Loja, Barrio Isidro',  '0967926342', 'mishellvcastillo@gmail.com'),
  ('1184597457', 'Marco David',        'Martinez Reyes',  'Loja, San Sebastian',  '0965865214', 'davidreyes@gmail.com'),
  ('2645256895', 'Jhon Alejandro',     'Jimenez Suarez',  'Loja, Clodoveo',       '0965821451', 'jhonjimenez@gmail.com');
 
-- ============================================================
-- TABLA: Curso
-- ============================================================
INSERT INTO Curso (identificador, nombre, jornada) VALUES
  ('01', 'Repostería', 'Matutina'),
  ('02', 'Boxeo',      'Vespertina'),
  ('04', 'Tejido',     'Matutina'),
  ('06', 'Cocina',     'Vespertina');
 
 
-- ============================================================
-- TABLA: Docente
-- ============================================================
INSERT INTO Docente (cedula, nombres, apellidos, telefono, correo) VALUES
  ('1150246325', 'Angel Fabricio', 'Mendieta Sari',   '0954862151', 'angelfa@gmail.com'),
  ('1152632362', 'Franco Leodan',  'Baculima Silva',  '0965348521', 'baculima@gmail.com'),
  ('1452156241', 'Maria Elena',    'Alberca Mendoza', '0935621458', 'mariaelena@gmail.com'),
  ('1452845412', 'Lady Vanessa',   'Abad Bravo',      '0925652325', 'ladyabad@gmail.com'),
  ('1524158454', 'Paulina Dalila', 'Mosquera Duran',  '0925421562', 'paulinam@gmail.com');
 
 
-- ============================================================
-- TABLA: Materia
-- ============================================================
INSERT INTO Materia (codigo, nombre, descripcion, identificador_Curso, cedula_Docente) VALUES
  ('BOX201', 'Tecnicas de Golpeo', 'Ensena golpes y combinaciones basicas.', '02', '1152632362'),
  ('BOX202', 'Defensa y Resistencia', 'Desarrollo de defensa personal y condicion fisica.', '02', '1152632362'),
  ('COC601', 'Cocina Internacional',  'Preparacion de platos internacionales.', '06', '1452845412'),
  ('COC602', 'Cocina Saludable',      'Elaboracion de platos para dieta balanceada.',       '06', '1452845412'),
  ('REP101', 'Pasteleria Basica',     'Preparacion de bizcochos y postres sencillos.',      '01', '1150246325'),
  ('REP102', 'Decoracion de Tortas',  'Tecnicas basicas de decoracion de postres.',         '01', '1150246325'),
  ('TEJ401', 'Tejido a Mano',         'Creacion de prendas basicas con aguja e hilo.',      '04', '1452156241'),
  ('TEJ402', 'Diseno de Prendas',     'Elaboracion de patrones y diseno.',                  '04', '1452156241');
 
 
-- ============================================================
-- TABLA: Matricula
-- ============================================================
INSERT INTO Matricula (cedula_Estudiante, codigo_Materia) VALUES
  ('0485964547', 'COC601'),   -- Milena Samanta    → Cocina Internacional
  ('1100451213', 'TEJ402'),   -- Pauleth Monserrath → Diseno de Prendas
  ('1150528899', 'BOX201'),   -- Mishell Vanessa   → Tecnicas de Golpeo
  ('1184597457', 'COC602'),   -- Marco David       → Cocina Saludable
  ('2645256895', 'BOX202');   -- Jhon Alejandro    → Defensa y Resistencia
 
 
-- ============================================================
-- TABLA: Calificacion
-- ============================================================
INSERT INTO Calificacion ( nota_final, estado, codigo_Matricula) VALUES
  (8.00, 'Aprobado',   3),   -- Mishell Vanessa    / Tecnicas de Golpeo
  (5.00, 'Supletorio', 5),   -- Jhon Alejandro     / Defensa y Resistencia
  (7.00, 'Aprobado',   1),   -- Milena Samanta     / Cocina Internacional
  (9.80, 'Aprobado',   2),   -- Pauleth Monserrath / Diseno de Prendas
  (6.95, 'Supletorio', 4);   -- Marco David        / Cocina Saludable
 
 
-- ============================================================
-- TABLA: Supletorio
-- (nota_final = promedio(nota_final_calificacion + nota_examen_supletorio) / 2)
-- ============================================================
INSERT INTO Supletorio (nota_examen_supletorio, nota_final, resultado, identificador_Calificacion) VALUES
  (9.00, 7.00, 'Aprobado',  2),   -- Jhon Alejandro:  (5.00 + 9.00) / 2 = 7.00 → Aprobado
  (7.00, 6.98, 'Reprobado', 5);   -- Marco David:     (6.95 + 7.00) / 2 = 6.98 → Reprobado