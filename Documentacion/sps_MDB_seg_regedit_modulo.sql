USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_regedit_modulo]    Script Date: 23/11/2017 04:43:34 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sps_MDB_seg_regedit_modulo]
(
	@pi_id_modulo		int			  = NULL,
	@pc_nombre_modulo	varchar (50),
	@pc_url_icono		varchar (100) = NULL,
	@pc_url_destino		varchar (100) = NULL,
	@pi_id_sistema		int,
	@pl_estatus_modulo	bit,
	@pc_db_conexion		varchar (255) = NULL
)
AS
BEGIN
SET NOCOUNT ON
-----------------------------

DECLARE @ERROR int = 0,
        @MESSAGE varchar(300) = ''
		

		IF @pi_id_modulo IS NULL OR @pi_id_modulo = 0
		BEGIN
			BEGIN TRY
				SELECT @pi_id_modulo = ISNULL(MAX(fi_id_modulo),0)+1 FROM [dbo].[mdb_seg_cat_modulo] -- 
				INSERT INTO [dbo].[mdb_seg_cat_modulo]
				(
					fi_id_modulo,fc_nombre_modulo,fc_url_icono,fc_url_destino,
					fi_id_sistema,fl_estatus_modulo,fc_db_conexion
				)
				VALUES
				(
					@pi_id_modulo,@pc_nombre_modulo,@pc_url_icono,@pc_url_destino,
					@pi_id_sistema,@pl_estatus_modulo,@pc_db_conexion
				)
				
			END TRY
			BEGIN CATCH
				SELECT @ERROR = 1,@MESSAGE='No fue posible INSERTAR el registro. '+ERROR_MESSAGE()
				GOTO ERROR
			END CATCH
			SELECT fi_id_modulo,ISNULL(fc_nombre_modulo,'')[fc_nombre_modulo],ISNULL(fc_url_icono,'')[fc_url_icono]
			,ISNULL(fc_url_destino,'')fc_url_destino,fi_id_sistema,fl_estatus_modulo,ISNULL(fc_db_conexion ,'')[fc_db_conexion]
			FROM [dbo].[mdb_seg_cat_modulo]
				WHERE fi_id_modulo = @pi_id_modulo

		END
		ELSE
		BEGIN
			BEGIN TRY 
			 UPDATE [dbo].[mdb_seg_cat_modulo]
			 SET fc_nombre_modulo	= @pc_nombre_modulo,
				fc_url_icono		= @pc_url_icono,
				fc_url_destino		= @pc_url_destino,
				fi_id_sistema		= @pi_id_sistema,
				fl_estatus_modulo	= @pl_estatus_modulo,
				fc_db_conexion		= @pc_db_conexion
			 WHERE fi_id_modulo		= @pi_id_modulo
			END TRY
			BEGIN CATCH
				SELECT @ERROR = 1,@MESSAGE='Error al actualizar información de modulo. '+ ERROR_MESSAGE()
				GOTO ERROR
			END CATCH
		END

-----------------------------
GOTO FIN

ERROR:

  RAISERROR(@MESSAGE,18,1)		

FIN:
SET NOCOUNT OFF
	SELECT 'ERROR_MESSAGE'= @ERROR
END