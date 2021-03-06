USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_obtener_roles]    Script Date: 28/11/2017 05:54:43 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-04-240>
-- Description:	
-- =============================================

/*
[sps_MDB_seg_obtener_roles] 1,7
*/

ALTER PROCEDURE [dbo].[sps_MDB_seg_obtener_roles]
(
  @pi_id_estatus bit = null,
  @pi_id_sistema int = null
  
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	
		
--SELECT      
--   R.fc_descripcion_rol as fc_descripcion,
--   R.fc_nombre_rol as fc_nombre,
--   R.fi_id_pais,
--   R.fi_id_rol,
--   R.fl_estatus_rol as fl_activo,
--   P.fc_pais

--  FROM  [dbo].[mdb_seg_tbl_rol] R with(nolock)
--  inner join [dbo].[mdb_seg_cat_pais] P with(nolock) on P.fi_id_pais = R.fi_id_pais  
--  where @pi_id_estatus is null 
--   or @pi_id_estatus = R.fl_estatus_rol

 SELECT      
	   R.fc_descripcion_rol as fc_descripcion,
	   R.fc_nombre_rol as fc_nombre,
	   R.fi_id_pais,
	   R.fi_id_rol,
	   R.fl_estatus_rol as fl_activo,
	   P.fc_pais	   

	  from (
		SELECT  
		   R.fc_descripcion_rol
		   ,R.fc_nombre_rol 
		   ,R.fi_id_pais
		   ,R.fi_id_rol
		   ,R.fl_estatus_rol
		  ,C.fi_id_sistema
		  from [dbo].[mdb_seg_tbl_rol] R with(nolock)
	  left join [BD_ROP].[dbo].[mdb_seg_tbl_rol_item] A with(nolock) on A.fi_id_rol = R.fi_id_rol
	  left  join [dbo].[mdb_seg_cat_item_de_modulo] B with(nolock) on B.fi_id_item_modulo = A.fi_id_item_modulo
	  left join [dbo].[mdb_seg_cat_modulo] C with(nolock) on C.fi_id_modulo = B.fi_id_modulo
	  where  (@pi_id_sistema is null or @pi_id_sistema = C.fi_id_sistema )
	  and (@pi_id_estatus is null or @pi_id_estatus = R.fl_estatus_rol)
	  
	  ) as R  
	  --inner join [dbo].[mdb_seg_tbl_rol] R with(nolock) on R.fi_id_rol = A.fi_id_rol
	  inner join [dbo].[mdb_seg_cat_pais] P with(nolock) on P.fi_id_pais = R.fi_id_pais  

	  group by R.fc_descripcion_rol ,
	   R.fc_nombre_rol ,
	   R.fi_id_pais,
	   R.fi_id_rol,
	   R.fl_estatus_rol,
	   P.fc_pais--,

	   order by P.fc_pais asc

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
