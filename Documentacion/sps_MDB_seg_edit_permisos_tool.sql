USE [BD_ROP]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-04-24>
-- Description:	
-- =============================================

create PROCEDURE [dbo].[sps_MDB_seg_edit_permisos_tool]
(
  @pi_id_usuario_permisos int = null,  
  @pi_id_herramienta int = null,
  @pl_permitir bit = null
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	



  begin try
		update  [dbo].[mdb_seg_tbl_usuario_herramientas]
		set      
	   fl_permitir  = @pl_permitir
	   where fi_id_usuario_permisos = @pi_id_usuario_permisos
	   and fi_id_herramienta = @pi_id_herramienta
   end try
   begin catch
      select @error = 1,
	   @msg='- Error al asignar permisos de la herramienta. '+ ERROR_MESSAGE()
	   goto ERROR
   end catch



goto FIN

ERROR:

  raiserror(@msg,18,1)		

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
