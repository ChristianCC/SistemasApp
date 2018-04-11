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
 sps_MDB_seg_expirar_tokens 'YGClZR/PBjjkXPhv0RwRt/ysDPSjEGLt5Gs1GRU/XU6sWQXX0yrelmxom2w4GXV4mXkLdTqQxJGPHfnGNFBX6A=='
 */
create PROCEDURE [dbo].[sps_MDB_seg_expirar_tokens]
(
   @pc_usuario varchar(100)=''     
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''				

		delete [dbo].mdb_seg_tbl_token 
		where fc_usuario = @pc_usuario

goto FIN

ERROR:

  raiserror(@msg,18,1)		

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
