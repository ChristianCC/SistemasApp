USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_edit_usuario]    Script Date: 24/04/2017 06:03:43 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-04-24>
-- Description:	
-- =============================================
create PROCEDURE [dbo].[sps_MDB_seg_eliminar_rolmodulo]
(   
   @pi_id_rol int = null ,
   @pi_id_item_modulo int =null      
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = '',
		@id_rol_item int=0			


   begin try
	  delete [dbo].[mdb_seg_tbl_rol_item]
		    where fi_id_rol = @pi_id_rol and fi_id_item_modulo = @pi_id_item_modulo		   
	end try
	begin catch
     select @error = 1,
	   @msg='No fue posible eliminar el registro. '+ERROR_MESSAGE()
	   goto ERROR
  end catch


goto FIN


ERROR:
  raiserror(@msg,18,1)	

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
