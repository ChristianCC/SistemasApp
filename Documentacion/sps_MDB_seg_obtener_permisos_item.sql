use BD_ROP
go

-- =============================================  
-- Author:  <Luis Hmberto Chavez>  
-- Create date: <2017-03-10>  
-- Description:   
-- =============================================  
/*
 sps_MDB_seg_obtener_permisos_item 'test', 6
*/

alter PROCEDURE [dbo].[sps_MDB_seg_obtener_permisos_item]  
(  
  @pc_usuario varchar(100)=null,
  @pi_id_sistema int = null ,
  @pi_id_rol int = null
)  
AS  
BEGIN   
 SET NOCOUNT ON  
  
declare @error int = 0,  
        @msg varchar(300) = ''   
        
  SELECT        
  X.fi_id_usuario_permisos,  
  X.fi_id_item_modulo, 
  X.fi_id_rol,     
  R.fc_nombre_rol,
  X.fi_id_sistema,
  X.fc_desc_item,  
  X.fl_delete,  
  X.fl_write  
  from
  
  ( select P.fi_id_usuario_permisos,  
	  P.fi_id_item_modulo, 
	  P.fi_id_rol,     
	  M.fi_id_modulo,
	  M.fi_id_sistema,
	  I.fc_desc_item,  
	  P.fl_delete,  
	  P.fl_write  
	  FROM  [dbo].[mdb_seg_tbl_usuario_permisos] P with(nolock)    
	  inner join  [dbo].[mdb_seg_cat_item_de_modulo] I with(nolock) on I.fi_id_item_modulo = P.fi_id_item_modulo    
	  inner join  [dbo].[mdb_seg_cat_modulo] M with(nolock ) on M.fi_id_modulo = I.fi_id_modulo  
	  where @pc_usuario = P.fc_usuario  
	  and (M.fi_id_sistema = @pi_id_sistema or @pi_id_sistema is null)
	  and (P.fi_id_rol = @pi_id_rol or @pi_id_rol is null)
	  --inner join  dbo.mdb_seg_tbl_rol R with(nolock ) on R.fi_id_rol = X.fi_id_rol
    ) as X
  inner join   dbo.mdb_seg_tbl_rol R with(nolock ) on R.fi_id_rol = X.fi_id_rol
    
  order by X.fi_id_sistema  desc 
          , X.fi_id_modulo desc
    
    
  
FIN:  
  
SET NOCOUNT OFF  
  
select 'status'= @error  
  
  
END  