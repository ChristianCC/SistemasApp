USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_cerrar_sesion]    Script Date: 04/09/2017 02:40:44 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- [sps_MDB_seg_cerrar_sesion] 'admin'
ALTER PROCEDURE [dbo].[sps_MDB_seg_cerrar_sesion](
	@pc_usuario varchar(50)=''
)
AS
SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = '',
		@id_acceso int =0,
		@id_sesion int = null,		
		@hoy datetime= GETDATE()
		
 
	
	update  [dbo].[mdb_seg_tbl_bit_acceso]
	set [fd_fecha_cierre] = @hoy
		where fc_usuario = @pc_usuario
		and fd_fecha_cierre is null

		delete [dbo].mdb_seg_tbl_token 
		where fc_usuario = @pc_usuario
		
goto FIN

ERROR:  
--select 'status'= @error
RAISERROR(@msg,18,@error)

FIN:
SET NOCOUNT OFF

select 'status'= @error
