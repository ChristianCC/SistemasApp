USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_obtener_tools_item]    Script Date: 28/08/2017 11:57:28 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-03-10>
-- Description:	  sps_MDB_seg_obtener_tools_item 88
-- =============================================
ALTER PROCEDURE [dbo].[sps_MDB_seg_obtener_tools_item]
(
  @pi_id_usuario_permisos int=null  
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	
		
SELECT      
  H.fi_id_usuario_permisos,
  H.fi_id_herramienta,
  H.fl_permitir,
  HE.fc_nombre  


  FROM  [dbo].[mdb_seg_tbl_usuario_herramientas] H with(nolock)    
  inner join [dbo].[mdb_seg_tbl_item_herramientas] HE with(nolock) on HE.fi_id_herramienta = H.fi_id_herramienta
  inner join  [dbo].[mdb_seg_cat_item_de_modulo] I with(nolock) on I.fi_id_item_modulo = HE.fi_id_item_modulo
  inner join  [dbo].[mdb_seg_cat_modulo] M with(nolock ) on M.fi_id_modulo = I.fi_id_modulo
  
  
  where @pi_id_usuario_permisos = H.fi_id_usuario_permisos
  and HE.fl_activo = 1

  order by M.fc_nombre_modulo desc
   

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
