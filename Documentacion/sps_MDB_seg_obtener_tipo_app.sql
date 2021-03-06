USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_obtener_tipo_app]    Script Date: 06/11/2017 10:55:51 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-03-10>
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[sps_MDB_seg_obtener_tipo_app]
(
  @pl_activo bit = null,
  @pi_id_tipo_app varchar(100) = null
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	
		
SELECT    
   [fi_id_tipo_app] ,
   [fc_descripcion] ,
   [fl_activo]   

  FROM  [dbo].[mdb_seg_cat_tipo_app]  with(nolock)  
  where (@pl_activo is null or @pl_activo = fl_activo )   
  and (@pi_id_tipo_app is null or @pi_id_tipo_app = fi_id_tipo_app )

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
