CREATE DATABASE PaseListaDb;
GO
USE PaseListaDb;
GO
CREATE TABLE Alumno(
AlumnoId INT PRIMARY KEY IDENTITY(1,1),
Nombres NVARCHAR(30) NOT NULL,
Apellidos NVARCHAR(30) NOT NULL,
Edad TINYINT NOT NULL,
Foto NVARCHAR(400),
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE Profesor(
ProfesorId INT PRIMARY KEY IDENTITY(1,1),
Nombres NVARCHAR(60) NOT NULL,
Apellidos NVARCHAR(60) NOT NULL,
Edad TINYINT NOT NULL,
Especialidad NVARCHAR(100),
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE Grado(
GradoId TINYINT PRIMARY KEY IDENTITY(1,1),
Nombre NVARCHAR(150) NOT NULL,
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE Horario(
HorarioId INT PRIMARY KEY IDENTITY(1,1),
Descripcion NVARCHAR(90) NOT NULL,
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE Aula(
AulaId BIGINT PRIMARY KEY IDENTITY(1,1),
Nombre NVARCHAR(20) NOT NULL,
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE DiaClase(
DiaClaseId TINYINT PRIMARY KEY IDENTITY(1,1),
Nombre NVARCHAR(15) NOT NULL,
FechaInsercion DATETIME NOT NULL
)
/****************************************************************/
/***********************Entidades débiles***********************/
/****************************************************************/
CREATE TABLE Materia(
MateriaId INT PRIMARY KEY IDENTITY(1,1),
Nombre NVARCHAR(60) NOT NULL,
GradoId TINYINT NOT NULL,
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE MateriaHorario(
MateriaHorarioId INT PRIMARY KEY IDENTITY(1,1),
MateriaId INT,
HorarioId INT,
AulaId BIGINT,
DiaClaseId TINYINT,
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE MateriaHorarioProfesor(
MateriaHorarioProfesorId INT PRIMARY KEY  IDENTITY(1,1),
MateriaHorarioId INT,
ProfesorId INT,
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE MateriaHorarioProfesorAlumno(
MateriaHorarioProfesorAlumnoId INT PRIMARY KEY IDENTITY(1,1),
MateriaHorarioProfesorId INT,
AlumnoId INT,
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE Asistencia(
AsistenciaId INT PRIMARY KEY IDENTITY(1,1),
MateriaHorarioProfesorAlumnoId INT,
AlumnoId INT,
Asistio BIT,
FechaClase DATETIME NOT NULL,
FechaAsistencia DATETIME
);
/****************************************************************/
/*************************Llaves Foráneas*************************/
/****************************************************************/
ALTER TABLE Materia
ADD CONSTRAINT FK_GradoId_Grado_Materia
FOREIGN KEY (GradoId) REFERENCES Grado(GradoId);
---
ALTER TABLE MateriaHorarioProfesor
ADD CONSTRAINT FK_ProfesorId_Profesor_MateriaHorarioProfesor
FOREIGN KEY (ProfesorId) REFERENCES Profesor(ProfesorId);
---
ALTER TABLE MateriaHorario
ADD CONSTRAINT FK_MateriaId_Materia_MateriaHorario
FOREIGN KEY (MateriaId) REFERENCES Materia(MateriaId);
---
ALTER TABLE MateriaHorario
ADD CONSTRAINT FK_HorarioId_Horario_MateriaHorario
FOREIGN KEY (HorarioId) REFERENCES Horario(HorarioId);
---
ALTER TABLE Asistencia
ADD CONSTRAINT FK_MateriaHorarioProfesorAlumnoId_MateriaHorarioProfesorAlumno
FOREIGN KEY (MateriaHorarioProfesorAlumnoId) REFERENCES MateriaHorarioProfesorAlumno(MateriaHorarioProfesorAlumnoId);
/**************************************************************************/
/******************************Procedimientos******************************/
/**************************************************************************/
--Insertar Alumno
GO
IF OBJECT_ID('Sp_Insertar_Alumno') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[Sp_Insertar_Alumno];
END
GO
CREATE PROCEDURE [dbo].[Sp_Insertar_Alumno](
@Nombres NVARCHAR(30),
@Apellidos NVARCHAR(30),
@Edad TINYINT ,
@Foto NVARCHAR(400)
)
AS
BEGIN
	DECLARE @ExisteAlumno BIT;
	SET @ExisteAlumno = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM Alumno 
							WHERE Nombres = @Nombres AND Apellidos = @Apellidos AND 
							Edad = @Edad AND Foto = @Foto);
	IF @ExisteAlumno = 0 BEGIN
		INSERT INTO Alumno(Nombres, Apellidos,Edad,Foto, FechaInsercion) VALUES(@Nombres, @Apellidos,@Edad, @Foto, GETDATE());
		SELECT 0 [Rsp], 'Se insertó el alumno correctamente' [Msg]
	END
	ELSE BEGIN
		SELECT -1 [Rsp], 'No se puede insertar el alumno. El alumno ya existe' [Msg]
	END

END
GO
	PRINT 'Procedimiento almacenado [dbo].[Sp_Insertar_Alumno] se ha creado correctamente';
GO
--Insertar Profesor
IF OBJECT_ID('Sp_Insertar_Profesor') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[Sp_Insertar_Profesor];
END
GO
CREATE PROCEDURE [dbo].[Sp_Insertar_Profesor](
@Nombres NVARCHAR(30),
@Apellidos NVARCHAR(30),
@Edad TINYINT ,
@Especialidad NVARCHAR(100)
)
AS
BEGIN
	DECLARE @ExisteAlumno BIT;
	SET @ExisteAlumno = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM Profesor 
							WHERE Nombres = @Nombres AND Apellidos = @Apellidos AND 
							Edad = @Edad AND Especialidad = @Especialidad);
	IF @ExisteAlumno = 0 BEGIN
		INSERT INTO Profesor(Nombres, Apellidos,Edad,Especialidad, FechaInsercion) VALUES(@Nombres, @Apellidos,@Edad, @Especialidad, GETDATE());
		SELECT 0 [Rsp], 'Se insertó el profesor correctamente' [Msg]
	END
	ELSE BEGIN
		SELECT -1 [Rsp], 'No se puede insertar el profesor. El profesor ya existe' [Msg]
	END

END
GO
	PRINT 'Procedimiento almacenado [dbo].[Sp_Insertar_Profesor] se ha creado correctamente';
GO
--Insertar Materia
IF OBJECT_ID('Sp_Insertar_Materia') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[Sp_Insertar_Materia];
END
GO
CREATE PROCEDURE [dbo].[Sp_Insertar_Materia](
@Nombre NVARCHAR(60),
@NombreGrado NVARCHAR(150)
)
AS
BEGIN
	DECLARE @ExisteMateria BIT;
	DECLARE @GradoId TINYINT;
	SET @GradoId = (SELECT GradoId FROM Grado WHERE Nombre = @NombreGrado);

	SET @ExisteMateria = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM Materia 
							WHERE Nombre = @Nombre AND GradoId = @GradoId);
	IF @ExisteMateria = 0 BEGIN
		if @GradoId IS NOT NULL BEGIN
			
			INSERT INTO [dbo].[Materia]([Nombre],[GradoId],[FechaInsercion])
				 VALUES(@Nombre,@GradoId,GETDATE())
			SELECT 0 [Rsp], 'Se insertó la materia correctamente' [Msg]
		END
		ELSE BEGIN
			SELECT -1 [Rsp], 'No se puede insertar la materia. El grado: "'+@NombreGrado+'" no está registrado.' [Msg]
		END
	END
	ELSE BEGIN
		SELECT -1 [Rsp], 'No se puede insertar la materia. la materia ya existe' [Msg]
	END

END
GO
	PRINT 'Procedimiento almacenado [dbo].[Sp_Insertar_Materia] se ha creado correctamente';
GO
--Registrar materia en horario
IF OBJECT_ID('Sp_Registrar_Horario_Materia') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[Sp_Registrar_Horario_Materia];
END
GO
CREATE PROCEDURE [dbo].[Sp_Registrar_Horario_Materia](
@NombreMateria NVARCHAR(60),
@NombreHorario NVARCHAR(150),
@NombreAula NVARCHAR(20),
@NombreDia NVARCHAR(20)
)
AS
BEGIN
	DECLARE @MateriaId TINYINT;
	DECLARE @HorarioId INT;
	DECLARE @AulaId BIGINT;
	DECLARE @DiaId TINYINT;
	DECLARE @ExisteClaseHoraAula BIT;

	SET @MateriaId = (SELECT MateriaId FROM Materia WHERE Nombre = @NombreMateria);
	SET @HorarioId = (SELECT HorarioId FROM Horario WHERE Descripcion = @NombreHorario);
	SET @AulaId = (SELECT AulaId FROM Aula WHERE Nombre = @NombreAula);
	SET @DiaId =(SELECT DiaClaseId FROM DiaClase WHERE Nombre =  @NombreDia);
	SET @ExisteClaseHoraAula = (SELECT CASE WHEN COUNT(*)> 0 THEN 1 ELSE 0 END FROM MateriaHorario WHERE AulaId = @AulaId AND DiaClaseId = @DiaId AND HorarioId = @HorarioId);
	

	IF @MateriaId IS NOT NULL BEGIN
		IF @HorarioId IS NOT NULL BEGIN
			IF @ExisteClaseHoraAula = 0 BEGIN
				INSERT INTO MateriaHorario(MateriaId, HorarioId, AulaId,DiaClaseId, FechaInsercion) VALUES(@MateriaId, @HorarioId,@AulaId, @DiaId, GETDATE());
				SELECT 0 [Rsp], 'La materia '+@NombreMateria +' se ha registrado en el horario '+@NombreHorario+' el día '+@NombreDia+' en el aula '+@NombreAula+' correctamente.' [Msg]
			END
			ELSE BEGIN
				DECLARE @NombreMateriaRegPrev NVARCHAR(25);
				SET @NombreMateriaRegPrev =(SELECT m.Nombre FROM MateriaHorario mh 
												JOIN Materia m ON mh.MateriaId = m.MateriaId
												WHERE mh.DiaClaseId = @DiaId AND mh.AulaId = @AulaId AND mh.HorarioId = @HorarioId)
				SELECT -1 [Rsp], 'Ya está registrtada la materia '+@NombreMateriaRegPrev +' en el horario '+@NombreHorario+' en el aula: "'+@NombreAula+' el día '+@NombreDia+'.' [Msg]
			END
		END
		ELSE BEGIN
			SELECT -1 [Rsp], 'No se puede registrar la materia '+@NombreMateria +' en el horario '+@NombreHorario+'. El horario no existe' [Msg]
		END;
	END
	ELSE BEGIN 
		SELECT -1 [Rsp], 'No se puede registrar la materia '+@NombreMateria +' en el horario '+@NombreHorario+'. La materia no existe' [Msg]
	END
END
GO
	PRINT 'Procedimiento almacenado [dbo].[Sp_Insertar_Horario_Materia] se ha creado correctamente';
GO
--Registrar MAESTRO en materia
IF OBJECT_ID('Sp_Registrar_Maestro_en_materia') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[Sp_Registrar_Maestro_en_materia];
END
GO
CREATE PROCEDURE [dbo].[Sp_Registrar_Maestro_en_materia](
@NombreMateria NVARCHAR(60),
@NombreHorario NVARCHAR(150),
@NombreProfesor NVARCHAR(120)
)
AS
BEGIN
	DECLARE @ExisteMateriaEnHorario BIT;
	DECLARE @MateriaId TINYINT;
	DECLARE @HorarioId INT;
	DECLARE @ProfesorId BIGINT;
	DECLARE @MateriaHorarioId INT;
	DECLARE @ExisteMaestroEnMateria BIT;
	declare @ExisteMaestroMateria BIT;
	SET @MateriaId = (SELECT MateriaId FROM Materia WHERE Nombre = @NombreMateria);
	SET @HorarioId = (SELECT HorarioId FROM Horario WHERE Descripcion = @NombreHorario);
	SET @ExisteMateriaEnHorario = (SELECT CASE WHEN COUNT(*)>0 THEN 1 ELSE 0 END FROM MateriaHorario WHERE MateriaId = @MateriaId AND HorarioId = @HorarioId);
	SET @ProfesorId =(SELECT ProfesorId FROM Profesor WHERE (Nombres +' '+Apellidos) = @NombreProfesor)
	SET @MateriaHorarioId = (SELECT MateriaHorarioId FROM MateriaHorario WHERE HorarioId = @HorarioId AND MateriaId = @MateriaId)
	SET @ExisteMaestroEnMateria = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM MateriaHorarioProfesor WHERE MateriaHorarioId = @MateriaHorarioId AND ProfesorId = @ProfesorId);
	SET @ExisteMaestroMateria = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM MateriaHorarioProfesor WHERE MateriaHorarioId = @MateriaHorarioId AND ProfesorId IS NOT NULL )

	IF @ExisteMateriaEnHorario IS NOT NULL BEGIN
		IF @ProfesorId IS NOT NULL BEGIN
			SET @MateriaHorarioId = (SELECT MateriaHorarioId FROM MateriaHorario WHERE HorarioId = @HorarioId AND MateriaId = @MateriaId)
			IF @ExisteMaestroEnMateria = 0 BEGIN
				IF @ExisteMaestroMateria = 0 BEGIN
					INSERT INTO [dbo].[MateriaHorarioProfesor]
					   ([MateriaHorarioId]
					   ,[ProfesorId]
					   ,[FechaInsercion])
					 VALUES
						   (@MateriaHorarioId
						   ,@ProfesorId
						   ,@ProfesorId);

					SELECT 0 [Rsp], 'El profesor fue registrado en la materia: "'+@NombreMateria+'('+@NombreHorario+')" .' [Msg]
				END
				ELSE BEGIN
					DECLARE @NombreProfesorImparte NVARCHAR(150)
					SET @NombreProfesorImparte = (select (Nombres+' '+Apellidos) from MateriaHorarioProfesor mhp
										join Profesor pr ON pr.ProfesorId = mhp.ProfesorId
										WHERE mhp.MateriaHorarioId = @MateriaHorarioId);
					SELECT -1 [Rsp], 'La materia ya está asignada al profesor: "'+@NombreProfesorImparte+'".' [Msg]
				END
			END
			ELSE BEGIN
				SELECT -1 [Rsp], 'El profesor ya está registrado en esta clase.' [Msg]
			END
		END
		ELSE BEGIN
			SELECT -1 [Rsp], 'El profesor no existe en el sistema.' [Msg]
		END
	END
	ELSE BEGIN
		SELECT -1 [Rsp], 'El horario o la materia no existen en el sistema' [Msg]
	END
END
GO
	PRINT 'Procedimiento almacenado [dbo].[Sp_Insertar_Horario_Materia] se ha creado correctamente';
GO
--Registrar Alumno en materia-horario-maestro
IF OBJECT_ID('Sp_Registrar_Alumno_en_Clase') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[Sp_Registrar_Alumno_en_Clase];
END
GO
CREATE PROCEDURE [dbo].[Sp_Registrar_Alumno_en_Clase](
@NombreMateria NVARCHAR(60),
@NombreHorario NVARCHAR(150),
@NombreProfesor NVARCHAR(120),
@NombreAlumno NVARCHAR(200)
)
AS
BEGIN
	DECLARE @MateriaId TINYINT;
	DECLARE @HorarioId INT;
	DECLARE @ProfesorId BIGINT;
	DECLARE @MateriaHorarioId INT;
	DECLARE @MateriaHorarioProfesorId INT;
	DECLARE @AlumnoId INT;
	DECLARE @ExisteAlumnoEnClase BIT;

	SET @MateriaId = (SELECT MateriaId FROM Materia WHERE Nombre = @NombreMateria);
	SET @HorarioId = (SELECT HorarioId FROM Horario WHERE Descripcion = @NombreHorario);
	SET @MateriaHorarioId = (SELECT MateriaHorarioId FROM MateriaHorario WHERE MateriaId = @MateriaId AND HorarioId = @HorarioId);
	SET @ProfesorId =(SELECT ProfesorId FROM Profesor WHERE (Nombres +' '+Apellidos) = @NombreProfesor)
	SET @MateriaHorarioProfesorId = (SELECT MateriaHorarioProfesorId FROM MateriaHorarioProfesor WHERE MateriaHorarioId = @MateriaHorarioId AND ProfesorId = @ProfesorId);
	SET @AlumnoId = (SELECT AlumnoId FROM Alumno WHERE (Nombres+' '+Apellidos) = @NombreAlumno);
	SET @ExisteAlumnoEnClase = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM MateriaHorarioProfesorAlumno WHERE MateriaHorarioProfesorId = @MateriaHorarioProfesorId AND AlumnoId = @AlumnoId);

	IF @MateriaHorarioProfesorId IS NOT NULL BEGIN
		IF @AlumnoId IS NOT NULL BEGIN
			IF @ExisteAlumnoEnClase = 0 BEGIN
				INSERT INTO [dbo].[MateriaHorarioProfesorAlumno]
				   ([MateriaHorarioProfesorId]
				   ,[AlumnoId]
				   ,[FechaInsercion])
			 VALUES
				   (@MateriaHorarioProfesorId
				   ,@AlumnoId
				   ,GETDATE())
			SELECT 0 [Rsp], 'El alumno fue dado de alta en la clase '+@NombreMateria+'('+@NombreHorario+') profesor: '+@NombreProfesor [Msg];
			END
			ELSE BEGIN 
				SELECT -1 [Rsp], 'El alumno/a '+@NombreAlumno+' ya está registrado/a en la clase.' [Msg]
			END
		END
		ELSE BEGIN 
			SELECT -1 [Rsp], 'El alumno no existe en el sistema' [Msg]
		END
	END
	ELSE BEGIN
		SELECT -1 [Rsp], 'La clase no existe en el sistema' [Msg]
	END
END
GO
	PRINT 'Procedimiento almacenado [dbo].[Sp_Registrar_Alumno_en_Clase] se ha creado correctamente';
GO
--Registrar Alumno en materia-horario-maestro
IF OBJECT_ID('Sp_Registrar_Asistencia') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[Sp_Registrar_Asistencia];
END
GO
CREATE PROCEDURE [dbo].[Sp_Registrar_Asistencia](@NombreAlumno NVARCHAR(160), @IdClase nvarchar(15))
AS
BEGIN
	DECLARE @AlumnoId INT;
	DECLARE @ClaseIdMaster INT;
	DECLARE @ExisteAsistencia BIT;
	SET @AlumnoId = (SELECT AlumnoId FROM Alumno WHERE (Nombres+' '+Apellidos) = @NombreAlumno);
	SET @ClaseIdMaster = (SELECT MateriaHorarioProfesorAlumnoId  FROM MateriaHorarioProfesorAlumno WHERE cast(MateriaHorarioProfesorAlumnoId as varchar)+'-'+CAST(MateriaHorarioProfesorId AS VARCHAR)+'-'+CAST(AlumnoId  AS VARCHAR) = @IdClase)
	SET @ExisteAsistencia = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM Asistencia 
									WHERE MateriaHorarioProfesorAlumnoId = @ClaseIdMaster AND AlumnoId = @AlumnoId AND CAST(FechaClase as date) = CAST(GETDATE() AS date) AND Asistio = 1);

	IF @ExisteAsistencia = 0 BEGIN
		UPDATE Asistencia SET Asistio = 1, FechaAsistencia = GETDATE() WHERE AlumnoId = @AlumnoId AND MateriaHorarioProfesorAlumnoId =  @ClaseIdMaster;
		SELECT 0 [Rsp], 'Se registró la asistencia correctamente.' [Msg]
	END
	ELSE BEGIN
		SELECT -1 [Rsp], 'Este alumno ya tiene asistencia.' [Msg]
	END
END
GO
--Registrar Alumno en materia-horario-maestro
IF OBJECT_ID('Sp_Iniciar_Clase') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[SSp_Iniciar_Clase];
END
GO
CREATE PROCEDURE [dbo].[Sp_Iniciar_Clase](@NombreProfesor NVARCHAR(160), @IdClase nvarchar(15))
AS
BEGIN
	DECLARE @ProfesorId INT;
	DECLARE @ClaseIdMaster INT;
	SET @ProfesorId = (SELECT ProfesorId FROM Profesor WHERE (Nombres+' '+Apellidos) = @NombreProfesor);
	SET @ClaseIdMaster = (SELECT MateriaHorarioProfesorAlumnoId  FROM MateriaHorarioProfesorAlumno WHERE cast(MateriaHorarioProfesorAlumnoId as varchar)+'-'+CAST(MateriaHorarioProfesorId AS VARCHAR)+'-'+CAST(AlumnoId  AS VARCHAR) = @IdClase)
	
	IF @ProfesorId IS NOT NULL BEGIN
		if @ClaseIdMaster is not null BEGIN
			INSERT INTO [dbo].[Asistencia](MateriaHorarioProfesorAlumnoId, AlumnoId, Asistio, FechaClase,FechaAsistencia)
			SELECT @ClaseIdMaster,AlumnoId,0,GETDATE(), NULL  FROM MateriaHorarioProfesorAlumno where MateriaHorarioProfesorAlumnoId = @ClaseIdMaster
		END 
		ELSE BEGIN
			SELECT -1 [Rsp], 'La clase no existe' [Msg]
		END
	END
	ELSE BEGIN
		SELECT -1 [Rsp], 'El profesor no existe' [Msg]
	END
END
GO
	IF OBJECT_ID('Sp_Clases_Total_Vista') IS NOT NULL BEGIN
		DROP procedure [dbo].[Sp_Clases_Total_Vista];
	END
GO
CREATE procedure [dbo].[Sp_Clases_Total_Vista]
AS
select m.Nombre [Materia], a.Nombre [Aula], dc.Nombre [Dia], h.Descripcion [Horario] FROM MateriaHorario mh
JOIN Materia m ON m.MateriaId = mh.MateriaId
JOIN Horario h ON h.HorarioId = mh.HorarioId
JOIN Aula a ON a.AulaId = mh.AulaId
JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
ORDER BY dc.DiaClaseId asc
GO
/************************************************************************************/
/************************************Disparadores************************************/
/************************************************************************************/
/*GO
	IF OBJECT_ID('Tr_Crear_Fila_Relacion_Materia') IS NOT NULL BEGIN
		DROP TRIGGER [dbo].[Tr_Crear_Fila_Relacion_Materia];
	END
GO
CREATE TRIGGER [dbo].[Tr_Crear_Fila_Relacion_Materia]
ON [dbo].[Materia]
AFTER INSERT
AS
BEGIN
	DECLARE @MateriaId INT;
	SET @MateriaId = (SELECT MateriaId FROM inserted);
	INSERT INTO MateriaHorarioProfesor(MateriaId, HorarioId, ProfesorId, FechaInsercion) VALUES(@MateriaId, NULL,NULL,GETDATE());
	INSERT INTO MateriaHorarioAlumno(MateriaId, HorarioId, AlumnoId, FechaInsercion) VALUES(@MateriaId, NULL,NULL,GETDATE());
END
GO
	PRINT 'Se creó el disparador [dbo].[Tr_Crear_Fila_Relacion_Materia] correctamente'
GO*/
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
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Estructuras de datos','8:15 A.M','A','Lunes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de programación','8:15 A.M','B','Lunes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de bases de datos','8:15 A.M','C','Lunes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Dev de bases de datos','9:15 A.M','A','Lunes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Administrador de Base de datos','9:15 A.M','B','Lunes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de redes','9:15 A.M','C','Lunes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Backend Web','8:15 A.M','A','Martes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Desarrollo Móvil','8:15 A.M','A','Miercoles'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de programación','8:15 A.M','B','Jueves'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de bases de datos','8:15 A.M','C','Miercoles'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Dev de bases de datos','9:15 A.M','A','Martes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Administrador de Base de datos','9:15 A.M','B','Viernes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Fundamentos de redes','9:15 A.M','C','Martes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Backend Web','8:15 A.M','A','Martes'
EXECUTE [dbo].[Sp_Registrar_Horario_Materia] 'Desarrollo Móvil','8:15 A.M','A','Viernes'
---

EXECUTE [dbo].[Sp_Registrar_Maestro_en_materia] 'POO','8:15 A.M','Ana Cristina Argote Gasca'

EXECUTE [dbo].[Sp_Registrar_Alumno_en_Clase] 
   'POO'
  ,'8:15 A.M'
  ,'Ana Cristina Argote Gasca'
  ,'Sergio Saúl torres Ibarra'


USE master;
select * from grado
