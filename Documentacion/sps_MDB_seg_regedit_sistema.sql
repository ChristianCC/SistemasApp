USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_regedit_sistema]    Script Date: 22/09/2017 12:39:22 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Martin Vargas Gonzalez>
-- Create date: <2017-09-22>
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[sps_MDB_seg_regedit_sistema]
(
	@pi_id_sistema	int = NULL,
	@pc_nombre_sistema	varchar(50),
	@pl_estatus_sistema	bit,
	@pc_logo	varchar(250) = null,
	@pc_url_home	varchar(255) = null,
	@pl_embebido	bit
)
AS
BEGIN
SET NOCOUNT ON
------------------

DECLARE @ERROR int = 0,
        @MESSAGE varchar(300) = ''

IF @pi_id_sistema IS NULL OR @pi_id_sistema=0
BEGIN
	BEGIN TRY

			SELECT @pi_id_sistema = ISNULL(max(fi_id_sistema),0)+1 FROM [dbo].[mdb_seg_cat_sistema]
			INSERT INTO mdb_seg_cat_sistema
			(
			fi_id_sistema,fc_nombre_sistema,fl_estatus_sistema,
			fc_logo,fc_url_home,fl_embebido
			)
			VALUES
			(
			@pi_id_sistema,@pc_nombre_sistema,@pl_estatus_sistema,
			@pc_logo,@pc_url_home,@pl_embebido
			)

	END TRY
	BEGIN CATCH
		 select @ERROR = 1,
		   @MESSAGE='No fue posible INSERTAR el registro. '+ERROR_MESSAGE()
		   goto ERROR
	END CATCH

	SELECT * FROM mdb_seg_cat_sistema with(nolock) 
	WHERE fi_id_sistema=@pi_id_sistema
END
ELSE
BEGIN
	BEGIN TRY
		UPDATE [dbo].[mdb_seg_cat_sistema]
		SET fc_nombre_sistema	= @pc_nombre_sistema,
			fl_estatus_sistema	= @pl_estatus_sistema,
			fc_logo				= @pc_logo,
			fc_url_home			= @pc_url_home,
			fl_embebido			= @pl_embebido
		WHERE fi_id_sistema = @pi_id_sistema
	END TRY
	BEGIN CATCH
	SELECT @ERROR = 1,
	   @MESSAGE='Error al actualizar información del Sistema. '+ ERROR_MESSAGE()
	   GOTO ERROR
	END CATCH
END
------------------
GOTO FIN

ERROR:

  RAISERROR(@MESSAGE,18,1)		

FIN:

SET NOCOUNT OFF
	SELECT 'ERROR_MESSAGE'= @ERROR
END


