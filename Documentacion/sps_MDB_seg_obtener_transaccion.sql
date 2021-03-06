USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_obtener_transaccion]    Script Date: 06/11/2017 12:58:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-11-06>
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[sps_MDB_seg_obtener_transaccion]
(
  @pi_id_sistema int = null,
  @pd_fecha_sistema date = null,
  @pi_id_app int = null -- Id de aplicacion de llave maestra o algun otro
)
AS
BEGIN	
 SET NOCOUNT ON

declare @error int = 0,
        @msg varchar(300) = ''	
		
SELECT 
			T.[fi_id_sistema],
			S.fc_nombre_sistema,
			T.[fi_id_tipo_transaccion],
			I.fc_descripcion as descTransaccion,
			[fc_neusuario],
			[fc_url],
			T.[fi_id_tipo_app],
			A.fc_descripcion as descTipoApp,
			[fc_hostname],
			[fc_ipclient],
			[fc_mensaje],
			[fc_dominio],
			[fd_fecha_inicio_proceso],
			[fd_fecha_fin_proceso],
			[fd_fecha_sistema],
			[fi_id_app],
			[fi_id_usuario]
				  
  FROM   [dbo].[mdb_seg_tbl_bit_transaccion] T with(nolock)  
  inner join [dbo].[mdb_seg_cat_sistema] S  with(nolock) on S.fi_id_sistema = t.fi_id_sistema
  inner join [dbo].[mdb_seg_cat_tipo_transaccion] I  with(nolock) on I.fi_id_tipo_transaccion = t.fi_id_tipo_transaccion
  inner join [dbo].[mdb_seg_cat_tipo_app] A  with(nolock) on A.fi_id_tipo_app = T.fi_id_tipo_app

  where ( @pi_id_sistema is null or T.fi_id_sistema = @pi_id_sistema)
   and ( convert(date,T.fd_fecha_sistema)  = @pd_fecha_sistema)
   and ( @pi_id_app is null or T.fi_id_app = @pi_id_app)

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
