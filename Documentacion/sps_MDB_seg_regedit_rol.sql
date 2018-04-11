Use BD_Rop
go

-- =============================================  
-- Author:  <Luis Hmberto Chavez>  
-- Create date: <2017-04-24>  
-- Description:   
-- =============================================  
alter PROCEDURE [dbo].[sps_MDB_seg_regedit_rol]  
(  
   @pc_descripcion_rol varchar(100)='',  
   @pc_nombre_rol varchar(100) ='',  
   @pi_id_pais int = null,  
   @pi_id_rol int = null,        
   @pl_activo bit = 1  
)  
AS  
BEGIN   
 SET NOCOUNT ON  
  
declare @error int = 0,  
        @msg varchar(300) = ''   
  
  
if  @pi_id_rol is null or @pi_id_rol = 0  
begin -- Nuevo Registro   
 begin try  
     
   --if exists ( select top(1) fi_id_rol from [dbo].[mdb_seg_tbl_rol] with(nolock)  
   --  where fc_nombre_rol = @pc_nombre_rol)   
   --  begin  
   --  select @error = 1,  
   --   @msg='El Rol '+@pc_nombre_rol+' ya existe'  
   --   goto ERROR  
   -- end  
  
   select @pi_id_rol = ISNULL(max(fi_id_rol),0)+1 from [dbo].[mdb_seg_tbl_rol]  
  
      insert into  [mdb_seg_tbl_rol]  
   (  
    fc_descripcion_rol,  
    fc_nombre_rol,  
    fi_id_pais,  
    fi_id_rol,        
    fl_estatus_rol  
   )  
   values(  
    @pc_descripcion_rol,  
    @pc_nombre_rol,  
    @pi_id_pais ,  
    @pi_id_rol ,       
    1)  
   end try  
    begin catch  
    select @error = 1,  
     @msg='- Error al registrar nuevo Rol. '+ ERROR_MESSAGE()  
     goto ERROR  
    end catch  
  
   select   
      R.fc_descripcion_rol,  
     R.fc_nombre_rol,  
     R.fi_id_pais,  
     R.fi_id_rol,  
     R.fl_estatus_rol,  
     P.fc_pais  
  
    FROM  [dbo].[mdb_seg_tbl_rol] R with(nolock)  
    inner join [dbo].[mdb_seg_cat_pais] P with(nolock) on P.fi_id_pais = R.fi_id_pais    
    where @pi_id_rol = R.fi_id_rol  
end  
else  
begin  
  
  begin try  
  update  [dbo].[mdb_seg_tbl_rol]  
   set        
   fc_nombre_rol = @pc_nombre_rol,  
   fc_descripcion_rol = @pc_descripcion_rol,  
   fi_id_pais = @pi_id_pais,  
   fl_estatus_rol = @pl_activo   
   where fi_id_rol = @pi_id_rol  
   end try  
   begin catch  
      select @error = 1,  
    @msg='- Error al registrar actualizar información del Rol. '+ ERROR_MESSAGE()  
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
