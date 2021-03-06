USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_obtener_usuarios]    Script Date: 28/08/2017 05:45:03 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-03-10>
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[sps_MDB_seg_obtener_usuarios]
(
  @pi_id_estatus int = null,
  @pc_usuario varchar(100) = null
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	
		
SELECT      
   U.fc_usuario,
   U.fc_nombre,
   U.fc_apellido_p,
   U.fc_apellido_m,
   U.fc_correo,
   U.fc_celular,
   U.fc_extension_usuario,
   U.fd_fecha_registro,
   U.fd_fecha_vencimiento,
   U.fi_id_estatus,
   E.fc_desc_estatus

  FROM  [dbo].[mdb_seg_tbl_usuario] U with(nolock)
  inner join   [dbo].[mdb_seg_cat_estatus_usr]  E with(nolock) on E.fi_id_estatus = U.fi_id_estatus
  where (@pi_id_estatus is null 
   or @pi_id_estatus = U.fi_id_estatus )
   and( @pc_usuario is null or @pc_usuario = U.fc_usuario)

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
