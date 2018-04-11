use BD_rop
go

-- sps_MDB_seg_iniciar_sesion '142511','142511'  
/*  
* 2 - Usuario o contraseña no validos  
* 3 - Sesion abierta  
*  
*/  
  
  
alter PROCEDURE [dbo].[sps_MDB_seg_iniciar_sesion](  
 @pc_usuario varchar(50)='',  
 @pcLlave varchar(255)='',  
 @pc_ip_usuario varchar(35)='',        
    @pc_sistema_acceso varchar(30)='',  
 @pl_cerrar_sesiones bit = 0  
)  
AS  
SET NOCOUNT ON  
  
declare @error int = 0,  
        @msg varchar(300) = '',  
  @id_acceso int =0,  
  @id_sesion int = null,  
  @fecha_inicio datetime = null,  
  @hoy datetime= GETDATE(),  
  @aux varchar(1024)=null  
    
   
if(SELECT TOP (1) A.fc_usuario FROM [dbo].[mdb_seg_tbl_usuario] A WITH(NOLOCK)   
 WHERE A.[fi_id_estatus] = 1 -- Activo  
 and A.fc_llave_usuario  = @pcLlave  
 and A.fc_usuario =@pc_usuario) is not null  
 begin  
 -- cierra Sesiones anteriores  
 if(@pl_cerrar_sesiones =1)  
 begin  
    update [dbo].[mdb_seg_tbl_bit_acceso]   
    set fd_fecha_cierre = @hoy  
    where   
     fc_usuario = @pc_usuario  
     and fd_fecha_acceso is not null  
     and fd_fecha_cierre is null  
        -- Elimina tokens  
  delete [dbo].mdb_seg_tbl_token   
  where fc_usuario = @pc_usuario  
  
 end  
  
  
   -- Verifica que la contraserña aun este activa
  if(select top(1)  A.fd_fecha_vencimiento  
    from [dbo].[mdb_seg_tbl_usuario] A      
    WHERE A.[fi_id_estatus] = 1 -- Activo  
	 and A.fc_llave_usuario  = @pcLlave  
	 and A.fc_usuario =@pc_usuario ) <= getdate()
  begin       
  
   SELECT @msg = 'Tu contraseña ha expirado. Por favor registra una nueva.'  
        , @error = 5
      GOTO ERROR        
  end      
  
  -- Verifiac si no existe una sesion  
  if(select top(1)  A.fd_fecha_acceso  
    from [dbo].[mdb_seg_tbl_bit_acceso] A  
    where   
    fc_usuario = @pc_usuario  
    and fd_fecha_acceso is not null  
    and fd_fecha_cierre is null )  is not null  
  begin  
     select top(1) @aux = A.fc_sistema_acceso from [dbo].[mdb_seg_tbl_bit_acceso] A  
      where   
      fc_usuario = @pc_usuario  
      and fd_fecha_acceso is not null  
      and fd_fecha_cierre is null  
  
   SELECT @msg = 'Tienes una sesión abierta en '+ ISNULL(@aux,'otro lugar')+' o la última sesión no se cerro correctamente.'  
        , @error = 3  
      GOTO ERROR        
  end      
  
  -- Verifica si tiene rol asignado  
  if not exists ( select top(1) R.fi_id_rol from  [dbo].[mdb_seg_tbl_usuario_rol] R  
  where fc_usuario = @pc_usuario)  
  begin  
     SELECT @msg = 'Aún no tienes permisos asignados.'  
   , @error = 4  
   GOTO ERROR  
  end  
    
    
    -- Agrega una nueva sesion  
       select @id_acceso = ISNULL( max (fi_id_bitacora_acc),0)+1 from [dbo].[mdb_seg_tbl_bit_acceso]  
  
       insert into [dbo].[mdb_seg_tbl_bit_acceso]  
    (  
      [fi_id_bitacora_acc]  
   ,[fc_usuario]  
   ,[fc_ip_usuario]  
   ,[fd_fecha_acceso]  
   ,[fd_fecha_cierre]  
   ,[fc_sistema_acceso]    )  
    values  
    (  
     @id_acceso,  
      @pc_usuario,  
   @pc_ip_usuario,  
   @hoy,  
   null,  
   @pc_sistema_acceso  
    )  
     -- Devuelve info del usuario  
  select  
      [fc_usuario]  
     ,'' as fc_llave_usuario  
     ,[fc_extension_usuario]  
     ,[fi_no_sesiones]  
     ,[fi_id_estatus]  
     ,[fd_fecha_vencimiento]  
     ,[fc_celular]  
     ,[fc_nombre]  
     ,[fc_apellido_p]  
     ,[fc_apellido_m]  
     ,[fd_fecha_registro]  
     ,[fc_correo]  
    FROM [BD_ROP].[dbo].[mdb_seg_tbl_usuario]  
    where fc_usuario = @pc_usuario  
    
 end   
 else  
 begin  
  SELECT @msg = 'El usuario o la contraseña son invalidos'  
   , @error = 2  
     GOTO ERROR  
 end  
   
goto FIN  
  
ERROR:    
--select 'status'= @error  
RAISERROR(@msg,18,@error)  
  
FIN:  
SET NOCOUNT OFF  
  
select 'status'= @error  