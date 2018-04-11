use BD_rop
go


-- =============================================  
-- Author:  <Luis Hmberto Chavez>  
-- Create date: <2017-04-24>  
-- Description:   
-- =============================================  
Alter PROCEDURE [dbo].[sps_MDB_seg_regedit_rol_usuario]  
(     
   @pi_id_rol int = null ,  
   @pc_usuario varchar(100)='',  
   @pl_eliminar bit =1   ,  
   @pi_id_pais int = null  
)  
AS  
BEGIN   
 SET NOCOUNT ON  
  
declare @error int = 0,  
        @msg varchar(300) = '',  
  @id_rol_usu int=0    
    
begin try  
  
    delete H  
  from [dbo].[mdb_seg_tbl_usuario_herramientas] H  
 inner join [dbo].[mdb_seg_tbl_usuario_permisos] P on P.fi_id_usuario_permisos = H.fi_id_usuario_permisos  
 inner join [dbo].[mdb_seg_tbl_rol_item] R on R.fi_id_item_modulo =  P.fi_id_item_modulo  
    where R.fi_id_rol = @pi_id_rol and @pc_usuario = P.fc_usuario   
  
 delete P from  [dbo].[mdb_seg_tbl_usuario_permisos] P  
 inner join [dbo].[mdb_seg_tbl_rol_item] R on R.fi_id_item_modulo =  P.fi_id_item_modulo  
    where R.fi_id_rol = @pi_id_rol and @pc_usuario = P.fc_usuario   
      
   -- delete from [dbo].[mdb_seg_tbl_usuario_permisos]   
   --where fc_usuario = @pc_usuario  
  
 delete A  
   from  [dbo].[mdb_seg_tbl_usuario_rol] A   
 --  inner join [dbo].[mdb_seg_tbl_rol] R  on R.fi_id_rol = A.fi_id_rol  
   --where R.fi_id_pais = @pi_id_pais and fc_usuario = @pc_usuario  
    where @pi_id_rol = A.fi_id_rol  
    and A.fc_usuario =  @pc_usuario   
  
     
  
  -- delete  [dbo].[mdb_seg_tbl_usuario_rol]  
  --where   
  --@pc_usuario=fc_usuario and  
  --@pi_id_rol =  fi_id_rol  
       
 end try  
 begin catch  
     select @error = 1,  
    @msg='No fue posible eliminar el registro. '+ERROR_MESSAGE()  
    goto ERROR  
  end catch  
       
  
if @pl_eliminar = 0 or @pl_eliminar=null  
begin        
  begin try  
  select @id_rol_usu = ISNULL(max(fi_id_usuario_rol),0)+1 from [dbo].[mdb_seg_tbl_usuario_rol]  
  
  insert into [dbo].[mdb_seg_tbl_usuario_rol](fc_usuario,fi_id_rol,fi_id_usuario_rol)  
  values(  
  @pc_usuario,  
  @pi_id_rol,  
  @id_rol_usu  
  )  
  
  -- Asigna los permisos  
  insert into  [dbo].[mdb_seg_tbl_usuario_permisos] (fi_id_item_modulo,fc_usuario,fi_id_rol)  
     select R.fi_id_item_modulo , @pc_usuario ,UR.fi_id_rol 
  from [dbo].[mdb_seg_tbl_usuario_rol] UR with(nolock)   
  inner join [dbo].[mdb_seg_tbl_rol_item] R with(nolock) on R.fi_id_rol = UR.fi_id_rol     
  where UR.fi_id_usuario_rol = @id_rol_usu  
  
  -- Asigna herramientas  
  
  insert into  [dbo].[mdb_seg_tbl_usuario_herramientas] (fi_id_usuario_permisos,fi_id_herramienta,fl_permitir)  
  SELECT        
    P.fi_id_usuario_permisos,  
    H.fi_id_herramienta,  
    0  
  
    FROM  [dbo].[mdb_seg_tbl_usuario_permisos] P with(nolock)    
    inner join  [dbo].[mdb_seg_cat_item_de_modulo] I with(nolock) on I.fi_id_item_modulo = P.fi_id_item_modulo  
    inner join mdb_seg_tbl_item_herramientas H with(nolock) on H.fi_id_item_modulo = I.fi_id_item_modulo  
    inner join  [dbo].[mdb_seg_cat_modulo] M with(nolock ) on M.fi_id_modulo = I.fi_id_modulo    
    where @pc_usuario = P.fc_usuario  
    order by M.fc_nombre_modulo desc  
        
   
  end try  
  begin catch  
     select @error = 1,  
    @msg='No fue posible asignar el rol indicado. '+ERROR_MESSAGE()  
    goto ERROR  
  end catch  
  
end  
  
goto FIN  
  
  
ERROR:  
  raiserror(@msg,18,1)   
  
FIN:  
  
SET NOCOUNT OFF  
  
select 'status'= @error  
  
  
END  