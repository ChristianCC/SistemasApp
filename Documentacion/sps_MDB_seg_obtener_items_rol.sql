USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_obtener_items_rol]    Script Date: 26/04/2017 10:18:48 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-03-10>
-- Description:	
-- =============================================
/*
sps_MDB_seg_obtener_items_rol 2
*/

ALTER PROCEDURE [dbo].[sps_MDB_seg_obtener_items_rol]
(
  @pi_id_rol int = null
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	
		
SELECT      
  
  I.fc_desc_item,
  I.fc_url,
  I.fc_url_icono,
  I.fi_id_item_modulo,
  I.fi_id_item_padre,  
  isnull( I.fi_id_orden,0) as fi_id_orden,
  I.fl_estatus_item,
  M.fi_id_modulo,
  M.fc_url_destino,
  M.fc_nombre_modulo,
  M.fc_url_icono as fc_url_icono_modulo,
  S.fi_id_sistema,
  S.fc_nombre_sistema
   
  FROM  [dbo].[mdb_seg_cat_item_de_modulo] I with(nolock)  
  inner join   [dbo].[mdb_seg_cat_modulo]  M with(nolock) on M.fi_id_modulo = I.fi_id_modulo
  inner join   [dbo].[mdb_seg_cat_sistema]  S with(nolock) on S.fi_id_sistema= M.fi_id_sistema
  left join [dbo].[mdb_seg_tbl_rol_item] R with(nolock) on R.fi_id_item_modulo = I.fi_id_item_modulo

  where @pi_id_rol = R.fi_id_rol
  
   order by S.fi_id_sistema desc,
   M.fi_id_modulo asc,
   I.fi_id_item_padre desc,
   I.fi_id_orden asc
   
   

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
