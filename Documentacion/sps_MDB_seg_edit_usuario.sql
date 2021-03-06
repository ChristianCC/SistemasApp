USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_edit_usuario]    Script Date: 28/08/2017 06:12:31 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-03-10>
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[sps_MDB_seg_edit_usuario]
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


goto FIN

ERROR:

  raiserror(@msg,18,1)		

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
