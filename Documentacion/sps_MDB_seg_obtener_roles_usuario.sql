USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_obtener_roles_usuario]    Script Date: 28/11/2017 05:43:00 p.m. ******/
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
[BD_ROP]..sps_MDB_seg_obtener_roles_usuario '617611',9
*/

ALTER PROCEDURE [dbo].[sps_MDB_seg_obtener_roles_usuario]
(
  @pc_usuario varchar(100) = '',
  @pi_id_sistema int = null
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	


begin
	SELECT      
	   R.fc_descripcion_rol as fc_descripcion,
	   R.fc_nombre_rol as fc_nombre,
	   R.fi_id_pais,
	   R.fi_id_rol,
	   R.fl_estatus_rol as fl_activo,
	   P.fc_pais	   

	  FROM [dbo].[mdb_seg_tbl_usuario_rol] A with(nolock)
	  inner join (
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
	  ) as R  on R.fi_id_rol = A.fi_id_rol  
	  --inner join [dbo].[mdb_seg_tbl_rol] R with(nolock) on R.fi_id_rol = A.fi_id_rol
	  inner join [dbo].[mdb_seg_cat_pais] P with(nolock) on P.fi_id_pais = R.fi_id_pais  

  
  
	  where @pc_usuario = A.fc_usuario
	  and (@pi_id_sistema = R.fi_id_sistema or @pi_id_sistema is null)

	  group by R.fc_descripcion_rol ,
	   R.fc_nombre_rol ,
	   R.fi_id_pais,
	   R.fi_id_rol,
	   R.fl_estatus_rol,
	   P.fc_pais--,
	   --R.fi_id_sistema

	   order by fc_pais asc


end

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
