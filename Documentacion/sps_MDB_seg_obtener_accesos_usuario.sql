use BD_ROP
go

-- =============================================  
-- Author:  <Luis Hmberto Chavez>  
-- Create date: <2017-03-10>  
-- Description:   
-- =============================================  
/*  
sps_MDB_seg_obtener_accesos_usuario '187163'  
  
*/  
alter PROCEDURE [dbo].[sps_MDB_seg_obtener_accesos_usuario]  
(  
  @pc_usuario varchar(100) =''  
)  
AS  
BEGIN   
 SET NOCOUNT ON  
  
declare @error int = 0,  
        @msg varchar(300) = ''
  
  
--if(@pc_usuario is null) or len(@pc_usuario)=0  
--begin  
    
--   select @error = 2,  
--     @msg='Debes especificar un usuario. '  
--   goto ERROR     
   
--end  

     
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
  
  where  R.fi_id_rol  in (
	  select fi_id_rol from [mdb_seg_tbl_usuario_rol]  
	 where fc_usuario = @pc_usuario  )
  and I.fl_estatus_item = 1  
    
   order by S.fi_id_sistema desc,  
   M.fi_id_modulo asc,  
   I.fi_id_item_padre desc,  
   I.fi_id_orden asc  
  
   -- Obtiene los sistemas  
  
   SELECT        
    
  S.fi_id_sistema,  
  S.fc_nombre_sistema,  
  S.fc_logo,  
  S.fc_url_home,  
  S.fl_embebido  
     
  FROM  [dbo].[mdb_seg_cat_item_de_modulo] I with(nolock)    
  inner join   [dbo].[mdb_seg_cat_modulo]  M with(nolock) on M.fi_id_modulo = I.fi_id_modulo  
  inner join   [dbo].[mdb_seg_cat_sistema]  S with(nolock) on S.fi_id_sistema= M.fi_id_sistema  
  left join [dbo].[mdb_seg_tbl_rol_item] R with(nolock) on R.fi_id_item_modulo = I.fi_id_item_modulo  
  
  where   R.fi_id_rol  in (
	  select fi_id_rol from [mdb_seg_tbl_usuario_rol]  
	 where fc_usuario = @pc_usuario  )
  and I.fl_estatus_item = 1  
  
  group by S.fi_id_sistema,  
  S.fc_nombre_sistema,  
  S.fc_logo,  
  S.fc_url_home,  
  S.fl_embebido  
    
--SELECT        
    
--  I.fc_desc_item,  
--  I.fc_url,  
--  I.fc_url_icono,  
--  I.fi_id_item_modulo,  
--  I.fi_id_item_padre,    
--  isnull( I.fi_id_orden,0) as fi_id_orden,  
--  I.fl_estatus_item,  
--  M.fi_id_modulo,  
--  M.fc_url_destino,  
--  M.fc_nombre_modulo,  
--  M.fc_url_icono as fc_url_icono_modulo,  
--  S.fi_id_sistema,  
--  S.fc_nombre_sistema  
     
--  FROM  [dbo].[mdb_seg_cat_item_de_modulo] I with(nolock)  
--  inner join   [dbo].[mdb_seg_cat_modulo]  M with(nolock) on M.fi_id_modulo = I.fi_id_modulo  
--  inner join   [dbo].[mdb_seg_cat_sistema]  S with(nolock) on S.fi_id_sistema= M.fi_id_sistema  
--  inner join [dbo].[mdb_seg_tbl_rol_item] R with(nolock) on R.fi_id_item_modulo = I.fi_id_modulo  
--  inner join [dbo].[mdb_seg_tbl_usuario_rol] U with(nolock) on U.fi_id_rol =  R.fi_id_rol  
  
--  where U.fc_usuario = @pc_usuario  
    
--   order by S.fi_id_sistema desc,  
--   M.fi_id_modulo asc,  
--   I.fi_id_item_padre desc,  
--   I.fi_id_orden asc  
     
    
  goto FIN  
  
ERROR:  
  
  raiserror(@msg,18,1)    
  
   
  
FIN:  
  
SET NOCOUNT OFF  
  
select 'status'= @error  
  
  
END  