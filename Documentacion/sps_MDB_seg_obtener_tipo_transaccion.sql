USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_obtener_tipo_transaccion]    Script Date: 06/11/2017 05:33:28 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sps_MDB_seg_obtener_tipo_transaccion]
(
	@pi_id_tipo_transaccion [int] = null,
	@pl_activo [bit] = null
)
AS
BEGIN

SET NOCOUNT ON

DECLARE @error INT = 0,
        @msg VARCHAR(300) = ''

SET @pi_id_tipo_transaccion = CASE WHEN @pi_id_tipo_transaccion = 0 THEN NULL ELSE @pi_id_tipo_transaccion END


		SELECT 
		        [TPT].fi_id_tipo_transaccion,
				[TPT].fc_descripcion, 
				[TPT].fl_activo
		FROM [dbo].[mdb_seg_cat_tipo_transaccion] [TPT]
		WHERE (@pi_id_tipo_transaccion IS NULL OR [TPT].fi_id_tipo_transaccion = @pi_id_tipo_transaccion)
		AND  (@pl_activo IS NULL OR [TPT].fl_activo = @pl_activo)

FIN:

SET NOCOUNT OFF

SELECT 'status'= @error
END


	

	