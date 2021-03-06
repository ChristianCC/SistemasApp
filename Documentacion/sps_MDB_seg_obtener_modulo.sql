USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_obtener_modulo]    Script Date: 28/11/2017 11:04:36 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sps_MDB_seg_obtener_modulo]
(
  @pi_id_modulo  INT = NULL,
  @pi_id_sistema INT = NULL,
  @pl_item_activo int = null
)
AS
BEGIN
SET NOCOUNT ON
	IF (@pi_id_modulo  IS NULL OR @pi_id_modulo = 0) AND (@pi_id_sistema IS NULL OR @pi_id_sistema = 0) -- ontiene todo
	BEGIN
			SELECT fi_id_modulo,ISNULL(fc_nombre_modulo,'')[fc_nombre_modulo],ISNULL(fc_url_icono,'')[fc_url_icono]
			,ISNULL(fc_url_destino,'')[fc_url_destino],fi_id_sistema,fl_estatus_modulo,ISNULL(fc_db_conexion ,'')[fc_db_conexion]
			FROM [dbo].[mdb_seg_cat_modulo] WITH(NOLOCK)
			ORDER BY 1 ASC
			
	END
	ELSE
	BEGIN
		IF @pi_id_modulo IS NOT NULL AND @pi_id_modulo <> 0 AND @pi_id_sistema IS NULL OR @pi_id_sistema = 0 -- obtiene los del modulo
		BEGIN
			SELECT fi_id_modulo,ISNULL(fc_nombre_modulo,'')[fc_nombre_modulo],ISNULL(fc_url_icono,'')[fc_url_icono]
			,ISNULL(fc_url_destino,'')[fc_url_destino],fi_id_sistema,fl_estatus_modulo,ISNULL(fc_db_conexion ,'')[fc_db_conexion]
			FROM [dbo].[mdb_seg_cat_modulo] WITH(NOLOCK)
			WHERE fi_id_modulo = @pi_id_modulo
			ORDER BY 1 ASC
			
		END
		IF @pi_id_modulo IS NULL OR @pi_id_modulo = 0 AND @pi_id_sistema IS NOT NULL AND @pi_id_sistema <> 0 -- Ontiene los del sistema
		BEGIN
			SELECT fi_id_modulo,ISNULL(fc_nombre_modulo,'')[fc_nombre_modulo],ISNULL(fc_url_icono,'')[fc_url_icono]
			,ISNULL(fc_url_destino,'')[fc_url_destino],fi_id_sistema,fl_estatus_modulo,ISNULL(fc_db_conexion ,'')[fc_db_conexion]
			FROM [dbo].[mdb_seg_cat_modulo] WITH(NOLOCK)
			WHERE fi_id_sistema = @pi_id_sistema
			ORDER BY 1 ASC

			SELECT fi_id_item_modulo,fc_desc_item,fc_url,fc_url_icono,fi_id_item_padre,fi_id_modulo,fl_estatus_item,fi_id_orden 
			FROM [dbo].[mdb_seg_cat_item_de_modulo] 
			WHERE fi_id_modulo 
			in (SELECT fi_id_modulo FROM [dbo].[mdb_seg_cat_modulo] WITH(NOLOCK) WHERE fi_id_sistema = @pi_id_sistema)
			--and (1 = fl_estatus_item)
			and (@pl_item_activo is null or @pl_item_activo = fl_estatus_item)

			ORDER BY fi_id_modulo ASC
			
		END
		IF @pi_id_modulo IS NOT NULL AND @pi_id_modulo <> 0 AND @pi_id_sistema IS NOT NULL AND @pi_id_sistema <> 0 -- obtiene los del sistema y modulo
		BEGIN
			SELECT fi_id_modulo,ISNULL(fc_nombre_modulo,'')[fc_nombre_modulo],ISNULL(fc_url_icono,'')[fc_url_icono]
			,ISNULL(fc_url_destino,'')[fc_url_destino],fi_id_sistema,fl_estatus_modulo,ISNULL(fc_db_conexion ,'')[fc_db_conexion]
			FROM [dbo].[mdb_seg_cat_modulo] WITH(NOLOCK)
			WHERE fi_id_modulo = @pi_id_modulo AND fi_id_sistema = @pi_id_sistema
			ORDER BY 1 ASC
			
		END

	END
SET NOCOUNT OFF
END
