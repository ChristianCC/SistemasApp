USE [BD_ROP]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-03-10>
-- Description:	
-- =============================================
alter PROCEDURE [dbo].[sps_MDB_seg_obtener_items_sistema]
(
  @pi_id_sistema int = null
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
  S.fi_id_sistema,
  S.fc_nombre_sistema
   
  FROM  [dbo].[mdb_seg_cat_item_de_modulo] I with(nolock)
  inner join   [dbo].[mdb_seg_cat_modulo]  M with(nolock) on M.fi_id_modulo = I.fi_id_modulo
  inner join   [dbo].[mdb_seg_cat_sistema]  S with(nolock) on S.fi_id_sistema= M.fi_id_sistema

  where @pi_id_sistema is null 
   or @pi_id_sistema = M.fi_id_sistema

   order by S.fi_id_sistema desc,
   M.fi_id_modulo asc,
   I.fi_id_item_padre desc,
   I.fi_id_orden asc
   
   

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
