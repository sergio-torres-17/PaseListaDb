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
GO
	IF OBJECT_ID('Sp_Insertar_Maestro_En_Clase') IS NOT NULL BEGIN
		DROP PROCEDURE [dbo].[Sp_Insertar_Maestro_En_Clase];
	END
GO
CREATE PROCEDURE [dbo].[Sp_Insertar_Maestro_En_Clase](@CodigoClase NVARCHAR(40), @NombreProfesor NVARCHAR(100))
AS
BEGIN
	DECLARE @MateriaHorarioId BIGINT;
	DECLARE @ProfesorId BIGINT;
	DECLARE @ExisteProfesorAsignado bit;
	SET @MateriaHorarioId = (select 
								 mh.MateriaHorarioId
								from MateriaHorario mh
								JOIN Materia m ON m.MateriaId = mh.MateriaId
								JOIN Horario h ON h.HorarioId = mh.HorarioId
								JOIN Aula a ON a.AulaId = mh.AulaId
								JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
								WHERE CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) = @CodigoClase
								);
	SET @ProfesorId = (SELECT ProfesorId FROM Profesor WHERE (Nombres+' '+Apellidos) = @NombreProfesor);
	SET @ExisteProfesorAsignado = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM MateriaHorarioProfesor WHERE MateriaHorarioId = @MateriaHorarioId AND ProfesorId = @ProfesorId)
	IF @ProfesorId IS NOT NULL BEGIN
		IF @MateriaHorarioId IS NOT NULL BEGIN
			IF @ExisteProfesorAsignado = 0 BEGIN
				INSERT INTO MateriaHorarioProfesor(MateriaHorarioId, ProfesorId,FechaInsercion) VALUES(@MateriaHorarioId, @ProfesorId, GETDATE());
				SELECT 0 [Rsp], 'El profesor ' +@NombreProfesor+' fue asignada a la clase con el código '+@CodigoClase+' no existe.' [Rsp];
			END 
			ELSE BEGIN
				SELECT 1 [Rsp], 'La clase con ya tiene profesor asignado.' [Rsp]
			END
		END
		ELSE BEGIN
			SELECT 1 [Rsp], 'La clase con el código: '+@CodigoClase+' no existe.' [Rsp]
		END
	END
	ELSE BEGIN
		SELECT 1 [Rsp], 'El profesor '+@NombreProfesor+' no existe.' [Rsp]
	END
END
GO
/************************************************************************************/
/***************************************Vistas***************************************/
/************************************************************************************/
GO
	IF OBJECT_ID('Vw_Vistas_Principal_Clas') IS NOT NULL BEGIN
		DROP VIEW [dbo].[Vw_Vistas_Principal_Clase];
	END
GO
CREATE VIEW [dbo].[Vw_Vistas_Principal_Clase]
AS
select 
CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) [CodigoClase]
,m.Nombre [NombreMateria]
,h.Descripcion [NombreHorario]
,a.Nombre [Aula]
,dc.Nombre [DiaClase]
from MateriaHorario mh
JOIN Materia m ON m.MateriaId = mh.MateriaId
JOIN Horario h ON h.HorarioId = mh.HorarioId
JOIN Aula a ON a.AulaId = mh.AulaId
JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId;
GO
GO
	IF OBJECT_ID('Vw_Vista_Clase_Para_Alumnos') IS NOT NULL BEGIN
		DROP VIEW [dbo].[Vw_Vista_Clase_Para_Alumnos];
	END
GO
CREATE VIEW [dbo].[Vw_Vista_Clase_Para_Alumnos]
AS
SELECT 
CAST(p.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) [CodigoClase]
,(p.Nombres+' '+p.Apellidos) [Profesor]
,m.Nombre [NombreMateria]
,h.Descripcion [NombreHorario]
,a.Nombre [Aula]
,dc.Nombre [DiaClase]
FROM MateriaHorarioProfesor mhp
JOIN MateriaHorario mh ON mhp.MateriaHorarioId =mh.MateriaHorarioId
JOIN Materia m ON m.MateriaId = mh.MateriaId
JOIN Horario h ON h.HorarioId = mh.HorarioId
JOIN Aula a ON a.AulaId = mh.AulaId
JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
JOIN Profesor p ON p.ProfesorId =mhp.ProfesorId;
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
USE master;
