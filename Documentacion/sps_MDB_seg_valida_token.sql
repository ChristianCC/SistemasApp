USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_valida_token]    Script Date: 31/08/2017 04:08:21 p.m. ******/
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
 sps_MDB_seg_valida_token 'YGClZR/PBjjkXPhv0RwRt/ysDPSjEGLt5Gs1GRU/XU6sWQXX0yrelmxom2w4GXV4mXkLdTqQxJGPHfnGNFBX6A=='
 */
ALTER PROCEDURE [dbo].[sps_MDB_seg_valida_token]
(
   @pc_token varchar(4092)=''     
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	,
		@fecha_caduca datetime = null,
		@hoy datetime = getdate()

		select top(1) @fecha_caduca = A.fd_fecha_caduca  from [dbo].mdb_seg_tbl_token A with(nolock) 
		where A.fc_token = @pc_token


		if(@fecha_caduca is null)
		begin -- token no encontrado
		  select @error = 1,
			 @msg='El token no es valido'
		  goto ERROR
		end
		else if @hoy > @fecha_caduca
		begin
		
		--   delete [dbo].mdb_seg_tbl_token -- Elimna el token
		--   where fc_token = @pc_token

		   select @error = 2,
			 @msg='El token ha caducado'
		  goto ERROR
		end

goto FIN

ERROR:

  raiserror(@msg,18,1)		

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
