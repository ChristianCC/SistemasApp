USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_regedit_rolmodulo]    Script Date: 25/08/2017 04:50:50 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-04-24>
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[sps_MDB_seg_regedit_rolmodulo]
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

 if( select top(1) fi_id_rol_item from [dbo].[mdb_seg_tbl_rol_item] with(nolock)
   where fi_id_rol = @pi_id_rol and fi_id_item_modulo = @pi_id_item_modulo) is null
begin    		
  begin try
	 select @id_rol_item = ISNULL(max(fi_id_rol_item),0)+1 from [dbo].[mdb_seg_tbl_rol_item]

		insert into [dbo].[mdb_seg_tbl_rol_item]([fi_id_rol_item],
		[fi_id_rol],
		[fi_id_item_modulo],
		[fl_permiso_escritura])
		values(
		@id_rol_item,
		@pi_id_rol,
		@pi_id_item_modulo,
		0
		)
	
  end try
  begin catch
     select @error = 1,
	   @msg='No fue posible asignar el modulo al rol indicado. '+ERROR_MESSAGE()
	   goto ERROR
  end catch

end
else --edicion
begin
   begin try
	  update [dbo].[mdb_seg_tbl_rol_item]
		   set fl_permiso_escritura = 0
		   where fi_id_rol = @pi_id_rol and fi_id_item_modulo = @pi_id_item_modulo
		   
	end try
	begin catch
     select @error = 1,
	   @msg='No fue posible modificar el registro. '+ERROR_MESSAGE()
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
