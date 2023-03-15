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
---Insertar profesores en clases 
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '31-21','Laura Torres'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '41-31','Ever Hugo Ever'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '52-11','Vladimir Stefano Vladimir'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '62-21','Nina Chanel Nina'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '72-31','Zohe Pilar Zohe'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '81-12','Allegra Gema Allegra'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '91-13','Rene Facundo Rene'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '31-24','NicolÃ¡s Ezequiel. NicolÃ¡s'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '41-33','Bruno Darius Bruno'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '52-12','Walter Fermín Walter'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '62-25','Lucio Efrain Lucio'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '72-32','Francesca Liliana Francesca'
EXECUTE [dbo].[Sp_Insertar_Maestro_En_Clase]  '91-15','Xiomara Miley Xiomara'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '131-21', 'Nayara Atikigua'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '131-21', 'Ambar Zoe'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '131-21', 'Luz Cuyen'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '131-21', 'Damaris Xiomara'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '131-21', 'Amin Mihair'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '131-21', 'Ashley Roxana'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '131-21', 'Maia Shasman'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1491-15', 'Giulianna Adel'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1491-15', 'Máxima Cielo'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1491-15', 'Delfina Maite'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1491-15', 'Renata Reina'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1491-15', 'Braiton Nicolas'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1491-15', 'Agustina Jeraldine'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1491-15', 'Umma Magaly'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '241-31', 'Josua '
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '241-31', 'Casiano Gael'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '241-31', 'Joaquin Cristiano'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '241-31', 'Tania Azul'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '241-31', 'Ahsley '
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '241-31', 'Georgiy '
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '241-31', 'Gael Anacleto'


EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '681-12', 'Gina Noelia'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '681-12', 'Miah Malena'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '681-12', 'Julieta Ainhoa'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '681-12', 'Josefina Antonella'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '681-12', 'Aliss Cristina'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '681-12', 'Cain Lihuen'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '791-13', 'Bianca Daniela'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '791-13', 'Maia '
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '791-13', 'Lisbet Yanina'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '791-13', 'Marisa Esmeralda'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '791-13', 'Quilla Aneley'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '791-13', 'Pablo Santiago'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '831-24', 'Celeste Miguelina'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '831-24', 'Fatima Luisana'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '831-24', 'Ximena Lucia'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '831-24', 'Natasha Liz'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '831-24', 'Bruno Cristian'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '831-24', 'Abigail Delfina'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '941-33', 'Paulo Valentino'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '941-33', 'Ma. Daniela'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '941-33', 'Sherazade Ihomara'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '941-33', 'Marimar Ana'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '941-33', 'Facundo Socrates'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '941-33', 'Xiomara Maylin'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '941-33', 'Melani Daniela'


EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1052-12', 'Rodrigo Eliazar'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1052-12', 'Alcides Angelo'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1052-12', 'Helene Noemi'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1052-12', 'Juan Galo'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1052-12', 'Gimena Carlina'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1052-12', 'Alexander Cristiano'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1052-12', 'India Rosario'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Mishel Nicol'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Estrellita Aline'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Alexia Mel'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Iara Emelin'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Abrahan Gaston'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Roman Felix'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Donatto Lorenzo'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Arwen Melody'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Britany Esperanza'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Eithan Uzziel'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Malvina Nahomi'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Dario Yutiel'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Elisa Micaela'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Milton Oscar'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Izan Benicio'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Felipe Guido'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Melina Shirley'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Daialen Yoselin'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Amir Azael'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Pedro Renan'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Francesca Yocelyn'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Dillan '
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Thian Yair'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Aitiana Delfina'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Erica Malena'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Jana Juanita'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Vera Tatiana'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Teo Facundo'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Mara Evelyn'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Genesis Angela'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Gianlucca Isaias'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Franco Rodrigo'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Tomas Yahir'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Lucio Leandro'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Anna Franccesca'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Isabela Aylen'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1272-32', 'Bastian Liam'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Karen Elsa'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Nerea Camila'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Walter Jaciel'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Yazmin Maiten'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Yamila Ailin'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Luna Ivonne'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Adabel Ayala'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Felipe Bernabeth'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Danna Liwen'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Benicio Tiziano'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Genesis Milagros'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '352-11', 'Valentin Sebastian'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Constantino Manuel'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Solange Costanza'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Ian Efrain'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Morena Miranda'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Ana Sol'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Bianca Yasmine'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Lujan Alexia'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Guila Ruth'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Lenny Amin'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Maite Leila'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Joscelyn Agustina'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Ignacio Raul'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '462-21', 'Elvis Hector'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Katia Delfina'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Tania Tomasa'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Lourdes Carlina'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Victoria Lorenza'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Bruno Francisco'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Elena Amarilis'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Francisco Clayton'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Gabriela Melody'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Julia Danielle'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Daniel Demir'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Amaralina '
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Eliseo Josue'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Maite Evangelina'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '572-31', 'Bautista Joshua'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Joselin Diamela'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Sohee Marilyn'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Giovanna Desiree'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1162-25', 'Xavier Lorenzo'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '1052-12', 'Benjamin Amadeo'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '791-13', 'Antonella Paloma'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '791-13', 'Briana Princesa'
EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] '941-33', 'Neylan Dilara'


-- exec Sp_Insert_Configuration_Property 'NombreDominio', '@leon.tecnm.mx';