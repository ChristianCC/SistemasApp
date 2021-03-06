USE [BD_ROP]
GO
/****** Object:  StoredProcedure [dbo].[sps_MDB_seg_reg_transaccion]    Script Date: 13/11/2017 12:17:10 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Luis Hmberto Chavez>
-- Create date: <2017-11-06>
-- Description:	
-- =============================================

ALTER PROCEDURE [dbo].[sps_MDB_seg_reg_transaccion]
(
	@pi_id_sistema  int = null, 
	@pi_id_tipo_transaccion  int = null,
	@pc_neusuario  varchar(100) = null,
	@pc_url  text = null,
	@pi_id_tipo_app int = null,
	@pc_hostname  varchar(50) = null,
	@pc_ipclient  varchar(50) = null,
	@pc_mensaje  text = null,
	@pc_dominio  varchar(50) = null,
	@pd_fecha_inicio_proceso datetime = null,
	@pd_fecha_fin_proceso datetime = null,	
	@pi_id_app int = null, -- Id de aplicacion de llave maestra o algun otro
	@pi_id_usuario int = null, -- Id de usuario de llave maestra o algun otro,
	@pc_tipo_acceso varchar(10) = ''
)
AS
BEGIN	
 SET NOCOUNT ON
  

declare @error int = 0,
        @msg varchar(300) = ''	,
		@pd_fecha_sistema smalldatetime = getdate()

if( select top(1) fi_id_sistema FROM [BD_ROP].[dbo].[mdb_seg_cat_sistema]
where fi_id_sistema = @pi_id_sistema ) = null
begin
  select @error = 1,
	 @msg='El Id de sistema no es valido.'
	 goto ERROR
end

if( select top(1) fi_id_tipo_transaccion FROM [BD_ROP].[dbo].[mdb_seg_cat_tipo_transaccion]
where fi_id_tipo_transaccion = @pi_id_tipo_transaccion ) = null
begin
  select @error = 1,
	 @msg='El Id de tipo de transacción no es valido.'
	 goto ERROR
end

if( select top(1) fi_id_tipo_app FROM [BD_ROP].[dbo].[mdb_seg_cat_tipo_app]
where fi_id_tipo_app = @pi_id_tipo_app ) = null
begin
  select @error = 1,
	 @msg='El Id de tipo de app no es valido.'
	 goto ERROR
end

if @pi_id_app is null 
set @pi_id_app = 0


if @pi_id_usuario is null 
set @pi_id_usuario = 0

		

 begin try    

	 insert into [dbo].[mdb_seg_tbl_bit_transaccion]
	   (
			fi_id_sistema,
			fi_id_tipo_transaccion,
			fc_neusuario,
			fc_url,
			fi_id_tipo_app,
			fc_hostname,
			fc_ipclient,
			fc_mensaje,
			fc_dominio,
			fd_fecha_inicio_proceso,
			fd_fecha_fin_proceso,
			fd_fecha_sistema,
			fi_id_app,
			fi_id_usuario,
			fc_tipo_acceso
	   )
	   values
	   (
		   @pi_id_sistema  , 
		@pi_id_tipo_transaccion  ,
		@pc_neusuario  ,
		@pc_url  ,
		@pi_id_tipo_app ,
		@pc_hostname  ,
		@pc_ipclient  ,
		@pc_mensaje  ,
		@pc_dominio ,
		@pd_fecha_inicio_proceso ,
		@pd_fecha_fin_proceso,
		@pd_fecha_sistema ,
		@pi_id_app ,
		@pi_id_usuario ,
		@pc_tipo_acceso
	   )
   end try
   begin catch
      select @error = 1,
	   @msg='No fue posible registrar la transacción de la aplicación. '+ ERROR_MESSAGE()
	   goto ERROR
   end catch

goto FIN

ERROR:

  raiserror(@msg,18,1)		

FIN:

SET NOCOUNT OFF

select 'status'= @error


END
