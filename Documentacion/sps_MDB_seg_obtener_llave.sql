USE [BD_ROP]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sps_MDB_seg_obtener_llave '142511'
create PROCEDURE [dbo].[sps_MDB_seg_obtener_llave](
	@pc_usuario varchar(50)=''
)
AS
SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''
		
 
	 select top(1) 	  
		fc_llave_usuario
	   from [dbo].[mdb_seg_tbl_usuario]
	   where 
	   fc_usuario = @pc_usuario
	
goto FIN

ERROR:  
--select 'status'= @error
RAISERROR(@msg,18,@error)

FIN:
SET NOCOUNT OFF

select 'status'= @error
