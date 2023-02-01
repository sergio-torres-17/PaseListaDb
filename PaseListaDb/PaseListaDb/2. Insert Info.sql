use PaseListaDb
/************************************************************************************/
/*******************************Inserción de registros*******************************/
/************************************************************************************/
--Dias habiles clase
INSERT INTO [dbo].[DiaClase]([Nombre],[FechaInsercion]) VALUES ('Lunes',GETDATE())
INSERT INTO [dbo].[DiaClase]([Nombre],[FechaInsercion]) VALUES ('Martes',GETDATE())
INSERT INTO [dbo].[DiaClase]([Nombre],[FechaInsercion]) VALUES ('Miercoles',GETDATE())
INSERT INTO [dbo].[DiaClase]([Nombre],[FechaInsercion]) VALUES ('Jueves',GETDATE())
INSERT INTO [dbo].[DiaClase]([Nombre],[FechaInsercion]) VALUES ('Viernes',GETDATE())
-- Aulas
INSERT INTO [dbo].[Aula]([Nombre],[FechaInsercion]) VALUES('A',GETDATE())
INSERT INTO [dbo].[Aula]([Nombre],[FechaInsercion]) VALUES('B',GETDATE())
INSERT INTO [dbo].[Aula]([Nombre],[FechaInsercion]) VALUES('C',GETDATE())
INSERT INTO [dbo].[Aula]([Nombre],[FechaInsercion]) VALUES('D',GETDATE())
INSERT INTO [dbo].[Aula]([Nombre],[FechaInsercion]) VALUES('E',GETDATE())
--Insertar Horarios
INSERT INTO [dbo].[Horario]([Descripcion],[FechaInsercion])VALUES('8:15 A.M',GETDATE())
INSERT INTO [dbo].[Horario]([Descripcion],[FechaInsercion])VALUES('9:15 A.M',GETDATE())
INSERT INTO [dbo].[Horario]([Descripcion],[FechaInsercion])VALUES('10:15 A.M',GETDATE())
--Insertar Grados
INSERT INTO [dbo].[Grado]([Nombre],[FechaInsercion])VALUES('Principiante',GETDATE())
INSERT INTO [dbo].[Grado]([Nombre],[FechaInsercion])VALUES('Intermedio',GETDATE())
INSERT INTO [dbo].[Grado]([Nombre],[FechaInsercion])VALUES('Avanzado',GETDATE())
--Insertar Alumnos
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Nayara','Atikigua',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Ambar','Zoe',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Luz','Cuyen',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Damaris','Xiomara',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Amin','Mihair',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Ashley','Roxana',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Maia','Shasman',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Giulianna','Adel',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'MÃ¡xima','Cielo',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Delfina','Maite',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Renata','Reina',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Braiton','Nicolas',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Agustina','Jeraldine',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Umma','Magaly',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Josua','',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Casiano','Gael',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Joaquin','Cristiano',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Tania','Azul',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Ahsley','',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Georgiy','',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Gael','Anacleto',18,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Gina','Noelia',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Miah','Malena',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Julieta','Ainhoa',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Josefina','Antonella',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Aliss','Cristina',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Cain','Lihuen',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Bianca','Daniela',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Maia','',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Lisbet','Yanina',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Marisa','Esmeralda',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Quilla','Aneley',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Pablo','Santiago',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Celeste','Miguelina',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Fatima','Luisana',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Ximena','Lucia',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Natasha','Liz',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Bruno','Cristian',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Abigail','Delfina',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Paulo','Valentino',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Ma.','Daniela',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Sherazade','Ihomara',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Marimar','Ana',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Facundo','Socrates',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Xiomara','Maylin',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Melani','Daniela',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Rodrigo','Eliazar',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Alcides','Angelo',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Helene','Noemi',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Juan','Galo',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Gimena','Carlina',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Alexander','Cristiano',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'India','Rosario',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Mishel','Nicol',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Estrellita','Aline',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Alexia','Mel',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Iara','Emelin',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Abrahan','Gaston',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Roman','Felix',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Donatto','Lorenzo',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Arwen','Melody',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Britany','Esperanza',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Eithan','Uzziel',19,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Malvina','Nahomi',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Dario','Yutiel',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Elisa','Micaela',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Milton','Oscar',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Izan','Benicio',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Felipe','Guido',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Melina','Shirley',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Daialen','Yoselin',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Amir','Azael',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Pedro','Renan',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Francesca','Yocelyn',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Dillan','',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Thian','Yair',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Aitiana','Delfina',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Erica','Malena',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Jana','Juanita',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Vera','Tatiana',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Teo','Facundo',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Mara','Evelyn',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Genesis','Angela',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Gianlucca','Isaias',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Franco','Rodrigo',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Tomas','Yahir',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Lucio','Leandro',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Anna','Franccesca',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Isabela','Aylen',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Bastian','Liam',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Karen','Elsa',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Nerea','Camila',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Walter','Jaciel',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Yazmin','Maiten',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Yamila','Ailin',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Luna','Ivonne',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Adabel','Ayala',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Felipe','Bernabeth',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Danna','Liwen',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Benicio','Tiziano',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Genesis','Milagros',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Valentin','Sebastian',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Constantino','Manuel',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Solange','Costanza',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Ian','Efrain',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Morena','Miranda',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Ana','Sol',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Bianca','Yasmine',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Lujan','Alexia',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Guila','Ruth',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Lenny','Amin',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Maite','Leila',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Joscelyn','Agustina',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Ignacio','Raul',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Elvis','Hector',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Katia','Delfina',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Tania','Tomasa',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Lourdes','Carlina',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Victoria','Lorenza',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Bruno','Francisco',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Elena','Amarilis',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Francisco','Clayton',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Gabriela','Melody',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Julia','Danielle',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Daniel','Demir',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Amaralina','',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Eliseo','Josue',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Maite','Evangelina',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Bautista','Joshua',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Joselin','Diamela',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Sohee','Marilyn',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Giovanna','Desiree',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Xavier','Lorenzo',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Benjamin','Amadeo',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Antonella','Paloma',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Briana','Princesa',20,NULL
EXECUTE [dbo].[Sp_Insertar_Alumno] 'Neylan','Dilara',20,NULL
--Insertar profesores
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Laura','Torres',22,'Programación'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Ever Hugo','Ever',40,'Matematicas'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Vladimir Stefano','Vladimir',40,'Programacion'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Nina Chanel','Nina',40,'Robotica'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Zohe Pilar','Zohe',40,'Bases de datos'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Allegra Gema','Allegra',40,'IoT'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Rene Facundo','Rene',40,'Mantenimiento'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'NicolÃ¡s Ezequiel.','NicolÃ¡s',40,'Computo en la nube'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Bruno Darius','Bruno',40,'Matematicas'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Walter Fermín','Walter',40,'Programacion'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Lucio Efrain','Lucio',40,'Robotica'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Francesca Liliana','Francesca',40,'Bases de datos'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Liliana Esmeralda','Liliana',40,'IoT'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Xiomara Miley','Xiomara',40,'Mantenimiento'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Aylen Alison','Aylen',40,'Computo en la nube'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Belle Indigo','Belle',40,'Matematicas'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Natanael Dylan','Natanael',40,'Programacion'
EXECUTE [dbo].[Sp_Insertar_Profesor] 'Umma Aimara','Umma',40,'Robotica'
--Insertar materias
EXECUTE [dbo].[Sp_Insertar_Materia] 'POO','Intermedio'
EXECUTE [dbo].[Sp_Insertar_Materia] 'Estructuras de datos','Intermedio'
EXECUTE [dbo].[Sp_Insertar_Materia] 'Fundamentos de programación','Principiante'
EXECUTE [dbo].[Sp_Insertar_Materia] 'Fundamentos de bases de datos','Principiante'
EXECUTE [dbo].[Sp_Insertar_Materia] 'Dev de bases de datos','Intermedio'
EXECUTE [dbo].[Sp_Insertar_Materia] 'Administrador de Base de datos','Avanzado'
EXECUTE [dbo].[Sp_Insertar_Materia] 'Fundamentos de redes','Principiante'
EXECUTE [dbo].[Sp_Insertar_Materia] 'Backend Web','Avanzado'
EXECUTE [dbo].[Sp_Insertar_Materia] 'Desarrollo Móvil','Avanzado'
--Registrar materias en horarios
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Estructuras de datos','8:15 A.M','A','Lunes', 30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de programación','8:15 A.M','B','Lunes',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de bases de datos','8:15 A.M','C','Lunes',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Dev de bases de datos','9:15 A.M','A','Lunes',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Administrador de Base de datos','9:15 A.M','B','Lunes',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de redes','9:15 A.M','C','Lunes',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Backend Web','8:15 A.M','A','Martes',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Desarrollo Móvil','8:15 A.M','A','Miercoles',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de programación','8:15 A.M','B','Jueves',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de bases de datos','8:15 A.M','C','Miercoles',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Dev de bases de datos','9:15 A.M','A','Martes',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Administrador de Base de datos','9:15 A.M','B','Viernes',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de redes','9:15 A.M','C','Martes',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Backend Web','8:15 A.M','A','Martes',30
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Desarrollo Móvil','8:15 A.M','A','Viernes',30
---

EXECUTE [dbo].[Sp_Registrar_Maestro_en_materia] 'POO','8:15 A.M','Ana Cristina Argote Gasca'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] 
   'POO'
  ,'8:15 A.M'
  ,'Ana Cristina Argote Gasca'
  ,'Sergio Saúl torres Ibarra'

