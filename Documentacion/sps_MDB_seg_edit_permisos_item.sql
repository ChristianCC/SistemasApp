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

alter PROCEDURE [dbo].[sps_MDB_seg_edit_permisos_item]
(
  @pi_id_usuario_permisos int = null,  
  @pl_delete bit = null,
  @pl_write bit = null
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	



  begin try
  update  [dbo].[mdb_seg_tbl_usuario_permisos]
   set      
   fl_delete = @pl_delete,
   fl_write = @pl_write
   where fi_id_usuario_permisos = @pi_id_usuario_permisos
   end try
   begin catch
      select @error = 1,
	   @msg='- Error al asignar permisos del Rol. '+ ERROR_MESSAGE()
	   goto ERROR
   end catch



goto FIN

ERROR:

  raiserror(@msg,18,1)		

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
