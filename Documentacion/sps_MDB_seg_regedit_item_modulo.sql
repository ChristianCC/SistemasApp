USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_regedit_item_modulo]    Script Date: 24/11/2017 01:07:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sps_MDB_seg_regedit_item_modulo]
(
	@pi_id_item_modulo	int = null,
	@pc_desc_item		varchar(100),
	@pc_url				varchar(255),
	@pc_url_icono		varchar(255),
	@pi_id_item_padre	int = 0,
	@pi_id_modulo		int,
	@pl_estatus_item	bit = 1,
	@pi_id_orden		int = 0
)
AS
BEGIN
SET NOCOUNT ON
---------------------
DECLARE @ERROR int = 0,
        @MESSAGE varchar(300) = ''

		IF @pi_id_item_modulo IS NULL OR @pi_id_item_modulo = 0
		BEGIN
			BEGIN TRY
			   
				SELECT @pi_id_item_modulo = ISNULL(MAX(fi_id_item_modulo),0)+1 FROM [dbo].[mdb_seg_cat_item_de_modulo] --
				
				INSERT INTO [dbo].[mdb_seg_cat_item_de_modulo]
				(
				fi_id_item_modulo,fc_desc_item,fc_url,fc_url_icono,
				fi_id_item_padre,fi_id_modulo,fl_estatus_item,fi_id_orden
				)
				VALUES
				(
				@pi_id_item_modulo,@pc_desc_item,@pc_url,@pc_url_icono,
				@pi_id_item_padre,@pi_id_modulo,@pl_estatus_item,@pi_id_orden
				)				
				SELECT * FROM mdb_seg_cat_item_de_modulo order by 2 asc
			END TRY
			BEGIN CATCH
				SELECT @ERROR = 1,
			   @MESSAGE='No fue posible INSERTAR el registro. '+ERROR_MESSAGE()
			   GOTO ERROR
			END CATCH
			SELECT fi_id_item_modulo,fc_desc_item,fc_url,fc_url_icono,fi_id_item_padre,fi_id_modulo,fl_estatus_item,fi_id_orden 
			FROM [dbo].[mdb_seg_cat_item_de_modulo]
			WHERE fi_id_item_modulo=@pi_id_item_modulo
		END
		ELSE
		BEGIN
			BEGIN TRY
				UPDATE [dbo].[mdb_seg_cat_item_de_modulo]
				SET
				fc_desc_item		= @pc_desc_item,
				fc_url				= @pc_url,
				fc_url_icono		= @pc_url_icono,
				fi_id_item_padre	= @pi_id_item_padre,
				fi_id_modulo		= @pi_id_modulo,
				fl_estatus_item		= @pl_estatus_item,
				fi_id_orden			= @pi_id_orden
			WHERE fi_id_item_modulo = @pi_id_item_modulo
			END TRY
			BEGIN CATCH
				SELECT @ERROR = 1,@MESSAGE='Error al actualizar información de item_modulo. '+ ERROR_MESSAGE()
				GOTO ERROR
			END CATCH
		END
	
---------------------
GOTO FIN

ERROR:

  RAISERROR(@MESSAGE,18,1)		

FIN:
SET NOCOUNT OFF
	SELECT 'ERROR_MESSAGE'= @ERROR

END