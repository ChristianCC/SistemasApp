USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_regedit_tipo_app]    Script Date: 06/11/2017 10:57:06 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-03-10>
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[sps_MDB_seg_regedit_tipo_app]
(
   @pi_id_tipo_app  int = null,
   @pc_descripcion varchar(50)='' ,	
   @pl_activo bit = 1 
)
AS
BEGIN	
 SET NOCOUNT ON

 

declare @error int = 0,
        @msg varchar(300) = ''	

		
if  @pi_id_tipo_app is null or @pi_id_tipo_app = 0
begin -- Nuevo Registro 
 begin try 
   select @pi_id_tipo_app = ISNULL(max(fi_id_tipo_app),0)+1 from [dbo].[mdb_seg_cat_tipo_app]

 insert into [dbo].[mdb_seg_cat_tipo_app]
   (
   [fi_id_tipo_app],
   [fc_descripcion],
	fl_activo
   )
   values
   (
	   @pi_id_tipo_app,
	   @pc_descripcion,
	   @pl_activo
   )
   end try
   begin catch
      select @error = 1,
	   @msg='No fue posible registrar el tipo de aplicación. '+ ERROR_MESSAGE()
	   goto ERROR
   end catch
   select 'fi_id_tipo_app'= @pi_id_tipo_app 
end
else -- Actualiza
begin  
   begin try 
   update [dbo].[mdb_seg_cat_tipo_app]
   set    
    fc_descripcion = @pc_descripcion,
	fl_activo = @pl_activo
      
   where fi_id_tipo_app= @pi_id_tipo_app
   end try
   begin catch
      select @error = 1,
	   @msg='No fue posible actualizar la información. '+ ERROR_MESSAGE() 
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
