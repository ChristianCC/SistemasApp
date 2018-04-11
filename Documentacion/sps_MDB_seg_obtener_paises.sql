USE [BD_ROP]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-04-240>
-- Description:	
-- =============================================
create PROCEDURE [dbo].[sps_MDB_seg_obtener_paises]
(
  @pl_activo bit = null
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	
		
SELECT      
   P.fi_id_pais,
   P.fc_pais,
   P.fl_activo

  FROM  [dbo].[mdb_seg_cat_pais] P with(nolock)  
  where @pl_activo is null 
   or @pl_activo = P.fl_activo

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
