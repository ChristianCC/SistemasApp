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
create PROCEDURE [dbo].[sps_MDB_seg_regedit_usuario]
(
   @pc_usuario varchar(100)='' ,
   @pc_llave_usuario varchar(255)='',
   @pc_nombre varchar(50),
   @pc_apellido_p varchar(50),
   @pc_apellido_m varchar(50),
   @pc_correo varchar(100),
   @pc_celular varchar(30),
   @pc_extension_usuario varchar(50),   
   @pd_fecha_vencimiento datetime = null,
   @pi_id_estatus bit = 1
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	

		
if(select U.fc_usuario from [dbo].[mdb_seg_tbl_usuario] U with(nolock) 
   where @pc_usuario = U.fc_usuario ) is null
begin -- Nuevo Registro 
 begin try 
 insert into [dbo].[mdb_seg_tbl_usuario]
   (
   U.fc_usuario,
   U.fc_llave_usuario,
   U.fc_nombre,
   U.fc_apellido_p,
   U.fc_apellido_m,
   U.fc_correo,
   U.fc_celular,
   U.fc_extension_usuario,
   U.fd_fecha_registro,
   U.fd_fecha_vencimiento,
   U.fi_id_estatus,
   U.fi_no_sesiones
   )
   values
   (
	   @pc_usuario ,
	   @pc_llave_usuario,
	   @pc_nombre ,
	   @pc_apellido_p ,
	   @pc_apellido_m,
	   @pc_correo ,
	   @pc_celular,
	   @pc_extension_usuario,   
	   getdate(),
	   dateadd(day,90, getdate()),	   
	   @pi_id_estatus,
	   0
   )
   end try
   begin catch
      select @error = 1,
	   @msg=''
	   goto ERROR
   end catch
   select 
   U.fc_usuario,   
   U.fc_nombre,
   U.fc_apellido_p,
   U.fc_apellido_m,
   U.fc_correo,
   U.fc_celular,
   U.fc_extension_usuario,
   U.fd_fecha_registro,
   U.fd_fecha_vencimiento,
   U.fi_id_estatus,
   U.fi_no_sesiones from [dbo].[mdb_seg_tbl_usuario] U
   where fc_usuario = @pc_usuario
end
else -- Actualiza
begin
  begin try
  update  [dbo].[mdb_seg_tbl_usuario]
   set      
   fc_nombre = @pc_nombre,
   fc_apellido_p = @pc_apellido_p,
   fc_apellido_m = @pc_apellido_m,
   fc_correo = @pc_correo,
   fc_celular = @pc_celular,
   fc_extension_usuario = @pc_extension_usuario,   
   fd_fecha_vencimiento = @pd_fecha_vencimiento ,
   fi_id_estatus = @pi_id_estatus
   where fc_usuario = @pc_usuario
   end try
   begin catch
      select @error = 1,
	   @msg=''
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
