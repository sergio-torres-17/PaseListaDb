CREATE DATABASE PaseListaDb;
GO
USE PaseListaDb;
GO
CREATE SCHEMA [Security];
GO
CREATE TABLE Usuario(
UsuarioId BIGINT PRIMARY KEY IDENTITY(1,1),
Nombres NVARCHAR(30) NOT NULL,
Apellidos NVARCHAR(30) NOT NULL,
Edad TINYINT NOT NULL,
Foto NVARCHAR(400),
FechaInsercion DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE Alumno(
AlumnoId INT PRIMARY KEY ,
UsuarioId BIGINT NOT NULL,
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE Profesor(
ProfesorId INT PRIMARY KEY IDENTITY(1,1),
UsuarioId BIGINT,
Correo NVARCHAR(90) NOT NULL,
Especialidad NVARCHAR(100),
FechaInsercion DATETIME NOT NULL
);
CREATE TABLE [Security].[CredencialAcceso](
CredencialesAccesoId BIGINT PRIMARY KEY IDENTITY(1,1),
UsuarioId BIGINT,
Password VARBINARY(MAX) NOT NULL,
FechaInsercion DATETIME NOT NULL DEFAULT GETDATE()
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
LimiteCupo INT NOT NULL,
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
	SET @ExisteAlumno = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM Alumno al 
							JOIN Usuario us ON us.UsuarioId = al.usuarioId
							WHERE Nombres = @Nombres AND Apellidos = @Apellidos AND 
							Edad = @Edad AND Foto = @Foto);
	IF @ExisteAlumno = 0 BEGIN
		WAITFOR DELAY '00:00:00.250';
		INSERT INTO Usuario(Nombres, Apellidos,Edad,Foto) VALUES(@Nombres, @Apellidos,@Edad, @Foto);
		DECLARE @UsuarioId BIGINT = (SELECT MAX(UsuarioId) FROM Usuario);
		DECLARE @AlumnoId INT = (SELECT dbo.Fn_Generar_Numero_control());
		INSERT INTO Alumno(AlumnoId,UsuarioId, FechaInsercion) VALUES(@AlumnoId,@UsuarioId, GETDATE());
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
	DECLARE @EmailProfesor NVARCHAR(100)  = (SELECT [dbo].[Fn_Generar_Correo_Docente](@Nombres, @Apellidos))
	SET @ExisteAlumno = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM Profesor pr
							JOIN Usuario us ON us.UsuarioId = pr.UsuarioId
							WHERE Nombres = @Nombres AND Apellidos = @Apellidos AND 
							Edad = @Edad AND Especialidad = @Especialidad);
	IF @ExisteAlumno = 0 BEGIN
		INSERT INTO Usuario(Nombres, Apellidos,Edad, Foto) VALUES(@Nombres, @Apellidos,@Edad, NULL);
		DECLARE @UsuarioId BIGINT = (SELECT MAX(UsuarioId) FROM Usuario);
		INSERT INTO Profesor(UsuarioId,Correo,Especialidad, FechaInsercion) VALUES(@UsuarioId,@EmailProfesor,@Especialidad, GETDATE());
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
@NombreDia NVARCHAR(20),
@LimiteCupo INT
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
				INSERT INTO MateriaHorario(MateriaId, HorarioId, AulaId,DiaClaseId, LimiteCupo,FechaInsercion) VALUES(@MateriaId, @HorarioId,@AulaId, @DiaId, @LimiteCupo,GETDATE());
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

--Registrar Alumno en materia-horario-maestro
IF OBJECT_ID('Sp_Registrar_Alumno_en_Clase') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[Sp_Registrar_Alumno_en_Clase];
END
GO
CREATE PROCEDURE [dbo].[Sp_Registrar_Alumno_en_Clase](
@CodigoClase NVARCHAR(30),
@NombreAlumno NVARCHAR(70)
)
AS
BEGIN
	DECLARE @AlumnoId INT;
	DECLARE @ExisteAlumnoEnClase BIT;
	DECLARE @Cupo INT
	DECLARE @MateriaHorarioProfesor BIGINT;
	DECLARE @TieneHorarioExistente BIT;
	DECLARE @HorarioClase NVARCHAR(15);


	SET @MateriaHorarioProfesor = (SELECT DISTINCT
									MHP.MateriaHorarioProfesorId
									FROM MateriaHorarioProfesor mhp
									JOIN MateriaHorario mh ON mhp.MateriaHorarioId =mh.MateriaHorarioId
									JOIN Materia m ON m.MateriaId = mh.MateriaId
									JOIN Horario h ON h.HorarioId = mh.HorarioId
									JOIN Aula a ON a.AulaId = mh.AulaId
									JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
									JOIN Profesor p ON p.ProfesorId =mhp.ProfesorId
									LEFT JOIN MateriaHorarioProfesorAlumno mhpa ON mhp.MateriaHorarioProfesorId = mhpa.MateriaHorarioProfesorId
									WHERE CAST(p.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) = @CodigoClase)
	SET @AlumnoId = (SELECT AlumnoId FROM Alumno al 
					JOIN Usuario us ON us.UsuarioId = al.UsuarioId
					WHERE (Nombres+' '+ Apellidos) = @NombreAlumno);
	SET @HorarioClase = (SELECT DISTINCT
									h.Descripcion
									FROM MateriaHorarioProfesor mhp
									JOIN MateriaHorario mh ON mhp.MateriaHorarioId =mh.MateriaHorarioId
									JOIN Materia m ON m.MateriaId = mh.MateriaId
									JOIN Horario h ON h.HorarioId = mh.HorarioId
									JOIN Aula a ON a.AulaId = mh.AulaId
									JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
									JOIN Profesor p ON p.ProfesorId =mhp.ProfesorId
									LEFT JOIN MateriaHorarioProfesorAlumno mhpa ON mhp.MateriaHorarioProfesorId = mhpa.MateriaHorarioProfesorId
									WHERE CAST(p.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) = @CodigoClase);

	IF @MateriaHorarioProfesor IS NOT NULL BEGIN
		IF @AlumnoId IS NOT NULL BEGIN
			set @Cupo = ((SELECT DISTINCT
									mh.LimiteCupo
									FROM MateriaHorarioProfesor mhp
									JOIN MateriaHorario mh ON mhp.MateriaHorarioId =mh.MateriaHorarioId
									JOIN Materia m ON m.MateriaId = mh.MateriaId
									JOIN Horario h ON h.HorarioId = mh.HorarioId
									JOIN Aula a ON a.AulaId = mh.AulaId
									JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
									JOIN Profesor p ON p.ProfesorId =mhp.ProfesorId
									LEFT JOIN MateriaHorarioProfesorAlumno mhpa ON mhp.MateriaHorarioProfesorId = mhpa.MateriaHorarioProfesorId
									WHERE CAST(p.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) = @CodigoClase)
									-
									(SELECT
											count(mhpa.AlumnoId)
											FROM MateriaHorarioProfesor mhp
											JOIN MateriaHorario mh ON mhp.MateriaHorarioId =mh.MateriaHorarioId
											JOIN Materia m ON m.MateriaId = mh.MateriaId
											JOIN Horario h ON h.HorarioId = mh.HorarioId
											JOIN Aula a ON a.AulaId = mh.AulaId
											JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
											JOIN Profesor p ON p.ProfesorId =mhp.ProfesorId
											JOIN Usuario us ON us.UsuarioId = p.UsuarioId
											LEFT JOIN MateriaHorarioProfesorAlumno mhpa ON mhp.MateriaHorarioProfesorId = mhpa.MateriaHorarioProfesorId
											WHERE CAST(p.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar)  = @CodigoClase
											GROUP BY CAST(p.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) 
											,(us.Nombres+' '+us.Apellidos) 
											,m.Nombre 
											,h.Descripcion 
											,a.Nombre 
											,dc.Nombre
											,(mh.LimiteCupo))
									);
			
			IF @Cupo> 0 AND (@Cupo - 1) >= 0 BEGIN
				SET @ExisteAlumnoEnClase = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM MateriaHorarioProfesorAlumno WHERE AlumnoId = @AlumnoId);
				IF @ExisteAlumnoEnClase = 0 BEGIN
					SET @TieneHorarioExistente = (select [dbo].[Fn_Verificar_Horario_existente_Alumno](@NombreAlumno, @HorarioClase, @HorarioClase));
					IF @TieneHorarioExistente = 0 BEGIN
						INSERT INTO [dbo].[MateriaHorarioProfesorAlumno]
							   ([MateriaHorarioProfesorId]
							   ,[AlumnoId]
							   ,[FechaInsercion])
						 VALUES
							   (@MateriaHorarioProfesor
							   ,@AlumnoId
							   ,GETDATE())
						SELECT 0 [Rsp], 'Se dió de alta al alumno '+@NombreAlumno+' en la clase  '+@CodigoClase+' correctamente.' [Msg]
					END
					ELSE BEGIN
					SELECT -1 [Rsp], 'El alumno '+@NombreAlumno+' ya tiene una clase asignada en el horario '+@HorarioClase+'.' [Msg]
					END
				END
				ELSE BEGIN
					SELECT -1 [Rsp], 'Este alumno ya se encuentra inscrito en este grupo' [Msg]
				END
			END
			ELSE BEGIN
				SELECT -1 [Rsp], 'El grupo se encuentra totalmente lleno' [Msg]
			END
		END
		ELSE BEGIN
			SELECT -1 [Rsp], 'El Alumno '+@NombreAlumno+' no está registrado o vigente en el sistema' [Msg]
		END
		
	END
	ELSE BEGIN
		SELECT -1 [Rsp], 'La clase que solicitas no está registrada en el sistema' [Msg]
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
	SET @AlumnoId = (SELECT AlumnoId FROM Alumno al
			JOIN Usuario us ON us.UsuarioId = al.UsuarioId
			WHERE (Nombres+' '+Apellidos) = @NombreAlumno);
	SET @ClaseIdMaster = (SELECT 
								MateriaHorarioProfesorAlumnoId
								FROM MateriaHorarioProfesor mhp
								JOIN MateriaHorario mh ON mhp.MateriaHorarioId =mh.MateriaHorarioId
								JOIN Materia m ON m.MateriaId = mh.MateriaId
								JOIN Horario h ON h.HorarioId = mh.HorarioId
								JOIN Aula a ON a.AulaId = mh.AulaId
								JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
								JOIN Profesor p ON p.ProfesorId =mhp.ProfesorId
								LEFT JOIN MateriaHorarioProfesorAlumno mhpa ON mhp.MateriaHorarioProfesorId = mhpa.MateriaHorarioProfesorId
								WHERE CAST(p.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar)= @IdClase
								AND	mhpa.AlumnoId = @AlumnoId
								);
	SET @ExisteAsistencia = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM Asistencia 
									WHERE MateriaHorarioProfesorAlumnoId = @ClaseIdMaster AND AlumnoId = @AlumnoId AND CAST(FechaClase as date) = CAST(GETDATE() AS date) AND Asistio = 1);

	IF @ExisteAsistencia = 0 BEGIN
		IF @ClaseIdMaster IS NOT NULL BEGIN
			UPDATE Asistencia SET Asistio = 1, FechaAsistencia = GETDATE() WHERE AlumnoId = @AlumnoId AND MateriaHorarioProfesorAlumnoId =  @ClaseIdMaster;
			SELECT 0 [Rsp], 'Se registró la asistencia correctamente.' [Msg]
		END
		ELSE BEGIN
			SELECT -1 [Rsp], 'El alumno no está registrado en la clase o la clase no existe.' [Msg]
		END
	END
	ELSE BEGIN
		SELECT -1 [Rsp], 'Este alumno ya tiene asistencia.' [Msg]
	END
END
GO
--Registrar Alumno en materia-horario-maestro
IF OBJECT_ID('Sp_Iniciar_Clase') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[Sp_Iniciar_Clase];
END
GO
CREATE PROCEDURE [dbo].[Sp_Iniciar_Clase](@NombreProfesor NVARCHAR(160), @IdClase nvarchar(15))
AS
BEGIN
	DECLARE @ProfesorId INT;
	DECLARE @ClaseIdMaster INT;
	SET @ProfesorId = (SELECT ProfesorId FROM Profesor pr 
						JOIN Usuario US ON us.UsuarioId = pr.UsuarioId
						WHERE (Nombres+' '+Apellidos) = @NombreProfesor);
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
	SET @ProfesorId = (SELECT ProfesorId FROM Profesor pr
						JOIN Usuario us ON us.UsuarioId = pr.UsuarioId
						WHERE (Nombres+' '+Apellidos) = @NombreProfesor);
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
,(u.Nombres+' '+u.Apellidos) [Profesor]
,m.Nombre [NombreMateria]
,h.Descripcion [NombreHorario]
,a.Nombre [Aula]
,dc.Nombre [DiaClase]
,CAST(count(mhpa.AlumnoId) AS VARCHAR)+'/'+ CAST(mh.LimiteCupo AS VARCHAR) [LugaresDsiponibles] 
FROM MateriaHorarioProfesor mhp
JOIN MateriaHorario mh ON mhp.MateriaHorarioId =mh.MateriaHorarioId
JOIN Materia m ON m.MateriaId = mh.MateriaId
JOIN Horario h ON h.HorarioId = mh.HorarioId
JOIN Aula a ON a.AulaId = mh.AulaId
JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
JOIN Profesor p ON p.ProfesorId =mhp.ProfesorId
JOIN Usuario u ON u.UsuarioId = p.UsuarioId
LEFT JOIN MateriaHorarioProfesorAlumno mhpa ON mhp.MateriaHorarioProfesorId = mhpa.MateriaHorarioProfesorId
GROUP BY CAST(p.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) 
,(u.Nombres+' '+u.Apellidos) 
,m.Nombre 
,h.Descripcion 
,a.Nombre 
,dc.Nombre
,(mh.LimiteCupo)
GO
	IF OBJECT_ID('Vw_Clases_Sin_Profesor_Asginado') IS NOT NULL BEGIN
		DROP VIEW [dbo].[Vw_Clases_Sin_Profesor_Asginado];
	END 
GO
CREATE VIEW [dbo].[Vw_Clases_Sin_Profesor_Asginado]
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
JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
LEFT JOIN MateriaHorarioProfesor mhp ON mhp.MateriaHorarioId = mh.MateriaHorarioId
WHERE mhp.MateriaHorarioId IS NULL;
GO
GO
	IF OBJECT_ID('Sp_View_Mis_Materias') IS NOT NULL BEGIN
		DROP PROCEDURE Sp_View_Mis_Materias;
	END
GO
CREATE PROCEDURE Sp_View_Mis_Materias(@Nombre NVARCHAR(60))
AS
SELECT CAST(p.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) [CodigoClase]
,d.Nombre [Día]
,h.Descripcion [Horario]
,m.Nombre [Materia]
,us.Nombres [Profesor]
FROM MateriaHorarioProfesorAlumno mhpa
JOIN MateriaHorarioProfesor mhp ON mhp.MateriaHorarioProfesorId =  mhpa.MateriaHorarioProfesorId
JOIN MateriaHorario mh ON mhp.MateriaHorarioId = mh.MateriaHorarioId
JOIN Materia m ON m.MateriaId = mh.MateriaId
JOIN DiaClase d ON d.DiaClaseId = mh.DiaClaseId
JOIN Aula a ON a.AulaId = mh.AulaId
JOIN Profesor p ON p.ProfesorId = mhp.ProfesorId
JOIN Horario h ON mh.HorarioId = h.HorarioId
JOIN Alumno al ON al.AlumnoId = mhpa.AlumnoId
JOIN Usuario us ON US.UsuarioId = AL.UsuarioId
WHERE (us.Nombres +' '+us.Apellidos) = @Nombre
;
GO
GO
	IF OBJECT_ID('Login') IS NOT NULL BEGIN
		DROP PROCEDURE [dbo].[Login];
	END
GO
CREATE PROCEDURE [dbo].[Login](
@Username NVARCHAR(100),
@PasswordEncrypted NVARCHAR(100)
)
AS
BEGIN
	DECLARE @TipoUsuario INT;
	DECLARE @NombreCompleto NVARCHAR(150)
	SET @TipoUsuario = (SELECT [dbo].[Fn_Buscar_Tipo_Usuario](@Username));
	
	IF @TipoUsuario != 400 BEGIN
		/***********************************************Login para profesores***********************************************/
		IF @TipoUsuario = 1050 BEGIN
			SET @NombreCompleto = (SELECT us.Nombres+' '+us.Apellidos  FROM Usuario us
									JOIN Profesor pr ON us.UsuarioId = pr.UsuarioId
									JOIN [Security].[CredencialAcceso] ca ON ca.UsuarioId = us.UsuarioId
									WHERE pr.Correo = @Username AND ca.Password = HASHBYTES('SHA2_512',@PasswordEncrypted));
			
			IF @NombreCompleto IS NOT NULL BEGIN
				SELECT '0' [Rsp], '+' [Token], @Username [Username], @TipoUsuario [UserType], @NombreCompleto [NombreCompleto];
			END
			ELSE BEGIN
				SELECT '-1' [Rsp], NULL [Token], NULL [Username], NULL [UserType], NULL [NombreCompleto];
				print 'paso profesores sin login'
			END
		END
		/**************************************************Login alumnos**************************************************/
		IF @TipoUsuario = 1150 BEGIN
			SET @NombreCompleto = (SELECT us.Nombres+' '+us.Apellidos  FROM Usuario us
									JOIN Alumno al ON al.UsuarioId = us.UsuarioId
									JOIN [Security].[CredencialAcceso] ca ON ca.UsuarioId = us.UsuarioId
									WHERE cast(al.AlumnoId as varchar) = @Username AND ca.Password = HASHBYTES('SHA2_512',CAST(@PasswordEncrypted AS VARCHAR(100))));
			PRINT @PasswordEncrypted
			PRINT CAST(@PasswordEncrypted AS VARCHAR(100))
			PRINT 'NOMBRE COMPLETO'	
			PRINT @NombreCompleto
			
			IF @NombreCompleto IS NOT NULL BEGIN
				SELECT '0' [Rsp], '+' [Token], CAST(@Username AS varchar) [Username], CAST(@TipoUsuario AS VARCHAR) [UserType], @NombreCompleto [NombreCompleto];
			END
			ELSE BEGIN
				SELECT '-1' [Rsp], NULL [Token], NULL [Username], NULL [UserType], NULL [NombreCompleto];
				print 'paso estudiantes sin login'
			END
		END
	END 
	ELSE BEGIN
		SELECT '-1' [Rsp], NULL [Token], NULL [Username], NULL [UserType], NULL [NombreCompleto];
		print 'No paso'
	END

END;
GO
	IF OBJECT_ID('Sp_Insertar_Asistencia') IS NOT NULL BEGIN
		DROP PROCEDURE [dbo].[Sp_Insertar_Asistencia];
	END
GO
CREATE PROCEDURE [dbo].[Sp_Insertar_Asistencia](
@CodigoClase NVARCHAR(30),
@NombreAlumno NVARCHAR(150)
)
AS
BEGIN
	-- Variables
	DECLARE @MateriaHorarioProfesorAlumnoId BIGINT;
	DECLARE @AlumnoId BIGINT;
	DECLARE @PertenceAlumnoClase BIT;

	SET @AlumnoId = (SELECT AlumnoId FROM Alumno al
			JOIN Usuario us ON us.UsuarioId = al.UsuarioId
			WHERE (us.Nombres+' '+us.Apellidos) = @NombreAlumno);
	SET @PertenceAlumnoClase = (SELECT 
									CASE 
										WHEN COUNT(*) > 0 THEN 1 
										ELSE 0
									END
									FROM MateriaHorarioProfesorAlumno mhpa
									JOIN MateriaHorarioProfesor mhp ON MHPA.MateriaHorarioProfesorId = mhp.MateriaHorarioProfesorId
									JOIN MateriaHorario mh ON mh.MateriaHorarioId = mhp.MateriaHorarioId
									WHERE CAST(mhp.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) = @CodigoClase
									AND mhpa.AlumnoId = @AlumnoId);
	SET @MateriaHorarioProfesorAlumnoId = (SELECT 
												mhpa.MateriaHorarioProfesorAlumnoId
												FROM MateriaHorarioProfesor mhp
												JOIN MateriaHorario mh ON mhp.MateriaHorarioId =mh.MateriaHorarioId
												JOIN Materia m ON m.MateriaId = mh.MateriaId
												JOIN Horario h ON h.HorarioId = mh.HorarioId
												JOIN Aula a ON a.AulaId = mh.AulaId
												JOIN DiaClase dc ON dc.DiaClaseId = mh.DiaClaseId
												JOIN Profesor p ON p.ProfesorId =mhp.ProfesorId
												LEFT JOIN MateriaHorarioProfesorAlumno mhpa ON mhp.MateriaHorarioProfesorId = mhpa.MateriaHorarioProfesorId
												WHERE CAST(p.ProfesorId AS varchar)+CAST(mh.MateriaId AS varchar)+CAST(mh.HorarioId AS varchar)+'-'+CAST(mh.AulaId AS varchar)+CAST(mh.DiaClaseId AS varchar) =@CodigoClase
												and mhpa.AlumnoId = @AlumnoId
												);
	

	IF @MateriaHorarioProfesorAlumnoId IS NOT NULL BEGIN
		IF @AlumnoId IS NOT NULL BEGIN
			IF @PertenceAlumnoClase = 1 BEGIN
				UPDATE Asistencia 
					SET 
						Asistio = 1, 
						FechaAsistencia = GETDATE() 
					WHERE 
						MateriaHorarioProfesorAlumnoId = @MateriaHorarioProfesorAlumnoId AND
						AlumnoId = @AlumnoId AND
						CAST(FechaClase AS DATE) = CAST(GETDATE() AS DATE );
				SELECT 0 [Rsp], 'Se insertó la asistencia correctamente' [Msg]
			END
			ELSE BEGIN 
				SELECT -1 [Rsp], 'El alumno no pertenece a esta clase' [Msg]
			END
		END
		ELSE BEGIN
			SELECT -1 [Rsp], 'El alumno '+@NombreAlumno+' no existe en el sistema' [Msg];
		END
	END
	ELSE BEGIN
		SELECT -1 [Rsp], 'La clase con el código '+@CodigoClase+' no existe en el sistema o el alumno no está registrado en la clase' [Msg];
	END
END;
GO
IF OBJECT_ID('Fn_Verificar_Horario_existente_Alumno') IS NOT NULL BEGIN
	DROP FUNCTION [dbo].[Fn_Verificar_Horario_existente_Alumno];
END	
go
CREATE FUNCTION [dbo].[Fn_Verificar_Horario_existente_Alumno](@NombreAlumno NVARCHAR(150), @Horario NVARCHAR(15),@DiaClase NVARCHAR(25))
RETURNS BIT
AS
begin
return
(SELECT 
	CASE 
		WHEN COUNT(*) > 0 THEN 1
		ELSE 0
	END
FROM MateriaHorarioProfesorAlumno mhpa
JOIN MateriaHorarioProfesor mhp ON mhp.MateriaHorarioProfesorId =  mhpa.MateriaHorarioProfesorId
JOIN MateriaHorario mh ON mhp.MateriaHorarioId = mh.MateriaHorarioId
JOIN Materia m ON m.MateriaId = mh.MateriaId
JOIN DiaClase d ON d.DiaClaseId = mh.DiaClaseId
JOIN Aula a ON a.AulaId = mh.AulaId
JOIN Profesor p ON p.ProfesorId = mhp.ProfesorId
JOIN Horario h ON mh.HorarioId = h.HorarioId
JOIN Alumno al ON al.AlumnoId = mhpa.AlumnoId
JOIN Usuario us ON us.UsuarioId = al.UsuarioId
WHERE (us.Nombres +' '+us.Apellidos) = @NombreAlumno AND h.Descripcion = @Horario AND d.Nombre = @DiaClase);
end
GO
GO
	CREATE FUNCTION [dbo].[Fn_Generar_Numero_control]()
	RETURNS NVARCHAR(40)
	AS
	BEGIN
	RETURN CAST((SELECT RIGHT(LEFT(CAST(GETDATE() AS DATE), 4), 2)+RIGHT(CAST(GETDATE() AS DATE), 2)+cast(DATEPART(SECOND, GETDATE()) as varchar)+CAST(LEFT(cast(RIGHT( CAST(GETDATE() as time), 7) as varchar), 2) AS varchar)) AS INT);
	END;
GO
GO
CREATE FUNCTION [dbo].[Fn_Generar_Correo_Docente](@Nombre NVARCHAR(100), @Apellidos NVARCHAR(100))
RETURNS NVARCHAR(200)
AS
BEGIN
	DECLARE @PrimerNombre as nvarchar(100) = (SELECT top 1 * FROM string_split(@Nombre, ' '))
RETURN (SELECT CASE
			WHEN @Apellidos <> '' THEN  @PrimerNombre+'.'+@Apellidos + '@controlescolar.com'
			ELSE @PrimerNombre + '@controlescolar.com'
		END [Correo]
		);
END
go
GO
	IF OBJECT_ID('Fn_Buscar_Tipo_Usuario') IS NOT NULL BEGIN
		DROP FUNCTION [dbo].[Fn_Buscar_Tipo_Usuario];
	END
GO
CREATE FUNCTION [dbo].[Fn_Buscar_Tipo_Usuario](
@Username NVARCHAR(100)
)
RETURNS INT
AS
BEGIN
		RETURN (select 
CASE
				WHEN pr.ProfesorId IS NOT NULL AND al.AlumnoId IS NULL THEN 1050
				WHEN pr.ProfesorId IS NULL AND al.AlumnoId IS NOT NULL THEN 1150
				ELSE 400
end
from Usuario us
LEFT JOIN Alumno al ON us.UsuarioId = al.UsuarioId
LEFT JOIN Profesor pr ON pr.UsuarioId = us.UsuarioId
WHERE cast(al.AlumnoId as varchar) = @Username AND pr.);
END
GO
CREATE TRIGGER [dbo].[Tr_Insertar_Credenciales_Profesor]
ON [dbo].[Profesor]
AFTER INSERT
AS
BEGIN
	DECLARE @NOMBRE NVARCHAR(30);
	DECLARE @APELLIDO NVARCHAR(30);
	DECLARE @UsuarioId BIGINT;

	SET @UsuarioId = (select UsuarioId from inserted);
	SET @NOMBRE = (SELECT us.Nombres FROM Usuario us JOIN Profesor al ON al.UsuarioId = us.UsuarioId WHERE us.UsuarioId = @UsuarioId);
	SET @APELLIDO = (SELECT us.Apellidos FROM Usuario us JOIN Profesor al ON al.UsuarioId = us.UsuarioId WHERE us.UsuarioId = @UsuarioId);
	
	INSERT INTO [Security].[CredencialAcceso](UsuarioId,Password) VALUES(@UsuarioId, HASHBYTES('SHA2_512', REPLACE(LOWER(TRIM(CONCAT(@NOMBRE, @APELLIDO))), ' ', '')));
END
GO
go
CREATE TRIGGER [dbo].[Tr_Insertar_Credenciales_Alumno]
ON [dbo].[Alumno]
AFTER INSERT
AS
BEGIN
	DECLARE @NOMBRE NVARCHAR(30);
	DECLARE @APELLIDO NVARCHAR(30);
	DECLARE @UsuarioId BIGINT;

	SET @UsuarioId = (select UsuarioId from inserted);
	SET @NOMBRE = (SELECT us.Nombres FROM Usuario us JOIN Alumno al ON al.UsuarioId = us.UsuarioId WHERE us.UsuarioId = @UsuarioId);
	SET @APELLIDO = (SELECT us.Apellidos FROM Usuario us JOIN Alumno al ON al.UsuarioId = us.UsuarioId WHERE us.UsuarioId = @UsuarioId);
	
	INSERT INTO [Security].[CredencialAcceso](UsuarioId,Password) VALUES(@UsuarioId, HASHBYTES('SHA2_512', REPLACE(LOWER(TRIM(CONCAT(@NOMBRE, @APELLIDO))), ' ', '')));
END
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
