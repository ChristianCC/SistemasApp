USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_reg_token]    Script Date: 04/09/2017 02:27:42 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-03-10>
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[sps_MDB_seg_reg_token]
(
   @pc_token varchar(4092)='' ,
   @pd_fecha_caduca datetime = null,
   @pc_usuario varchar(100) = null  
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	,
		@fecha_caduca date = null,
		@hoy datetime = getdate()
		
		insert into [dbo].mdb_seg_tbl_token (fc_token,fd_fecha_caduca,fc_usuario,fl_token_sesion)
		values (@pc_token,@pd_fecha_caduca,@pc_usuario,1)

goto FIN

ERROR:

  raiserror(@msg,18,1)		

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
