USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_reg_res_ejecucion]    Script Date: 04/05/2017 07:49:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-04-24>
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[sps_MDB_seg_reg_res_ejecucion]
(   
   @pi_id_ejecucion int = null,
   @pi_id_condicion int = null,      
   @pd_fecha_insercion datetime = null,
   @pi_identity_row int =null
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	

insert into [dbo].[mdb_tbl_res_ejecucion]
		([fi_id_ejecucion],
		[fi_id_condicion],
		[fd_fecha_insercion],
		fi_identity_row )
		values
		(
		  @pi_id_ejecucion ,
		   @pi_id_condicion ,   
		   @pd_fecha_insercion ,
		   @pi_identity_row
		)


goto FIN

ERROR:

  raiserror(@msg,18,1)		

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
