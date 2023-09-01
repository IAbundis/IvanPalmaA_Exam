USE [master]
GO
/****** Object:  Database [BdiExamen]    Script Date: 31/08/2023 06:44:16 p. m. ******/
CREATE DATABASE [BdiExamen]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BdiExamen', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BdiExamen.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BdiExamen_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BdiExamen_log.ldf' , SIZE = 5120KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BdiExamen] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BdiExamen].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BdiExamen] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BdiExamen] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BdiExamen] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BdiExamen] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BdiExamen] SET ARITHABORT OFF 
GO
ALTER DATABASE [BdiExamen] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BdiExamen] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BdiExamen] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BdiExamen] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BdiExamen] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BdiExamen] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BdiExamen] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BdiExamen] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BdiExamen] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BdiExamen] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BdiExamen] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BdiExamen] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BdiExamen] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BdiExamen] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BdiExamen] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BdiExamen] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BdiExamen] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BdiExamen] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BdiExamen] SET  MULTI_USER 
GO
ALTER DATABASE [BdiExamen] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BdiExamen] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BdiExamen] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BdiExamen] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BdiExamen] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BdiExamen] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BdiExamen] SET QUERY_STORE = OFF
GO
USE [BdiExamen]
GO
/****** Object:  Table [dbo].[tblExamen]    Script Date: 31/08/2023 06:44:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblExamen](
	[idExamen] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](255) NULL,
	[Descripcion] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spActualizar]    Script Date: 31/08/2023 06:44:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spActualizar] 
	-- Add the parameters for the stored procedure here
	   @Id int
	 , @Nombre varchar(255)
	 , @Descripcion varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
			BEGIN TRY 
				BEGIN TRAN Actualizar

					update tblExamen
						set Nombre = @Nombre,
							Descripcion = @Descripcion
					where idExamen = @Id

				COMMIT TRAN Actualizar
			END TRY
		
			BEGIN CATCH
				declare @Error varchar(max)
				declare @ErrorID int
				if(XACT_STATE()) = -1
				BEGIN
					set @Error = ERROR_MESSAGE()
					set @ErrorID = ERROR_NUMBER()
					ROLLBACK TRAN Actualizar
						select cast(@ErrorID as varchar(10))+ '  ' + @Error
				END
			END CATCH
	END
GO
/****** Object:  StoredProcedure [dbo].[spAgregar]    Script Date: 31/08/2023 06:44:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAgregar] 
	-- Add the parameters for the stored procedure here
	   @Id int
	 , @Nombre varchar(255)
	 , @Descripcion varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
			BEGIN TRY 
				BEGIN TRAN Insertar

					INSERT INTO tblExamen
					(
						  Nombre
						, Descripcion
					)
					Values 
					(
						  @Nombre
						, @Descripcion
					)

				COMMIT TRAN Insertar
			END TRY
		
			BEGIN CATCH
				declare @Error varchar(max)
				declare @ErrorID int
				if(XACT_STATE()) = -1
				BEGIN
					set @Error = ERROR_MESSAGE()
					set @ErrorID = ERROR_NUMBER()
					ROLLBACK TRAN Insertar
						select cast(@ErrorID as varchar(10))+ '  ' + @Error
				END
			END CATCH
	END
GO
/****** Object:  StoredProcedure [dbo].[spConsultar]    Script Date: 31/08/2023 06:44:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spConsultar] 
	-- Add the parameters for the stored procedure here
	     @Id int
AS
BEGIN
	
	SELECT idExamen
			, Nombre
			, Descripcion
	FROM tblExamen E with(nolock)
	WHERE idExamen = @Id
	

END
GO
/****** Object:  StoredProcedure [dbo].[spConsultarTodos]    Script Date: 31/08/2023 06:44:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spConsultarTodos] 
AS
BEGIN
	
	SELECT idExamen
			, Nombre
			, Descripcion
	FROM tblExamen E with(nolock)
	ORDER BY idExamen 

END
GO
/****** Object:  StoredProcedure [dbo].[spEliminar]    Script Date: 31/08/2023 06:44:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spEliminar] 
	-- Add the parameters for the stored procedure here
	   @Id int
AS
BEGIN
	SET NOCOUNT ON;
			BEGIN TRY 
				BEGIN TRAN Elimar

					DELETE FROM tblExamen where idExamen = @Id
					
				COMMIT TRAN Elimar
			END TRY
		
			BEGIN CATCH
				declare @Error varchar(max)
				declare @ErrorID int
				if(XACT_STATE()) = -1
				BEGIN
					set @Error = ERROR_MESSAGE()
					set @ErrorID = ERROR_NUMBER()
					ROLLBACK TRAN Elimar
						select cast(@ErrorID as varchar(10))+ '  ' + @Error
				END
			END CATCH
	END
GO
USE [master]
GO
ALTER DATABASE [BdiExamen] SET  READ_WRITE 
GO
