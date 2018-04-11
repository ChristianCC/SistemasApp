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
/*
 sps_MDB_seg_valida_acceso '../MdlAdmin/Usuarios/1','test'
 */
create PROCEDURE [dbo].[sps_MDB_seg_valida_acceso]
(   
   @pc_url varchar(255)='',
   @pc_usuario varchar(100)=''    
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = '',
		@pi_id_rol int =0	

		select top(1) @pi_id_rol=fi_id_rol from [mdb_seg_tbl_usuario_rol]
			where fc_usuario = @pc_usuario


		if(@pc_url not in (
				SELECT  			
					I.fc_url			
   
					FROM  [dbo].[mdb_seg_cat_item_de_modulo] I with(nolock)  
					inner join   [dbo].[mdb_seg_cat_modulo]  M with(nolock) on M.fi_id_modulo = I.fi_id_modulo
					inner join   [dbo].[mdb_seg_cat_sistema]  S with(nolock) on S.fi_id_sistema= M.fi_id_sistema
					left join [dbo].[mdb_seg_tbl_rol_item] R with(nolock) on R.fi_id_item_modulo = I.fi_id_item_modulo

					where @pi_id_rol = R.fi_id_rol
					and I.fl_estatus_item = 1 ) )
			begin 
			   
			    select @error = 403,
					 @msg='Acceso Denegado'
				  goto ERROR
			end

goto FIN

ERROR:

  raiserror(@msg,18,1)		

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
