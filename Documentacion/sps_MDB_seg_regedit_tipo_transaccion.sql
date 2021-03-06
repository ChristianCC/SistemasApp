USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_regedit_tipo_transaccion]    Script Date: 06/11/2017 10:56:31 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sps_MDB_seg_regedit_tipo_transaccion]
(
	@pi_id_tipo_transaccion [int] = null,
	@pc_descripcion [varchar] (50),
	@pl_activo [bit]
)
AS 
BEGIN
SET NOCOUNT ON

DECLARE @ERROR int = 0,
        @MESSAGE varchar(300) = ''

		IF @pi_id_tipo_transaccion IS NULL OR @pi_id_tipo_transaccion = 0
		BEGIN
			 BEGIN TRY
				SELECT @pi_id_tipo_transaccion = ISNULL(MAX(fi_id_tipo_transaccion),0)+1 FROM [dbo].[mdb_seg_cat_tipo_transaccion]
				INSERT INTO [dbo].[mdb_seg_cat_tipo_transaccion]
				(
					fi_id_tipo_transaccion,
					fc_descripcion,
					fl_activo
				)
				VALUES 
				(
					@pi_id_tipo_transaccion,
					@pc_descripcion,
					@pl_activo
				)
			 END TRY
			 BEGIN CATCH
				SELECT @ERROR = 1,@MESSAGE='No fue posible INSERTAR el registro. '+ERROR_MESSAGE()
				GOTO ERROR
			 END CATCH
			 SELECT 
				fi_id_tipo_transaccion,fc_descripcion 
			 FROM [dbo].[mdb_seg_cat_tipo_transaccion] 
			 WHERE fi_id_tipo_transaccion = @pi_id_tipo_transaccion
		END
		ELSE
		BEGIN
			BEGIN TRY
				 UPDATE [dbo].[mdb_seg_cat_tipo_transaccion] 
				 SET 
					fc_descripcion = @pc_descripcion,
					fl_activo = @pl_activo
				 WHERE fi_id_tipo_transaccion = @pi_id_tipo_transaccion
			END TRY
			BEGIN CATCH
				SELECT @ERROR = 1,@MESSAGE='Error al actualizar información: '+ ERROR_MESSAGE()
				GOTO ERROR
			END CATCH 
		END

GOTO FIN

ERROR:

  RAISERROR(@MESSAGE,18,1)		

FIN:
SET NOCOUNT OFF
	SELECT 'ERROR_MESSAGE'= @ERROR
END



/*
SqlCommand
Editar
Eliminar
*/

