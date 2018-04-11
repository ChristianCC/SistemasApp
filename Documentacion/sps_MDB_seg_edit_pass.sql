use BD_ROP

go

-- =============================================  
-- Author:  <Luis Hmberto Chavez>  
-- Create date: <2017-03-10>  
-- Description:   
-- =============================================  
alter PROCEDURE [dbo].[sps_MDB_seg_edit_pass]  
(  
   @pc_usuario varchar(100)='' ,  
   @pc_llave_usuario varchar(255)='',
   @pc_llave_usuario_anterior varchar(255)=''      
)  
AS  
BEGIN   
 SET NOCOUNT ON  
  
declare @error int = 0,  
        @msg varchar(300) = ''   
  
  -- comprueba
  if(len(@pc_llave_usuario_anterior)>0)
  begin
     if(select top(1) fc_usuario from [dbo].[mdb_seg_tbl_usuario] 
     where fc_usuario = @pc_usuario  
     and fc_llave_usuario = @pc_llave_usuario_anterior) is null
     begin
        select @error = 1,  
		@msg='La contraseña actual no es correcta.'
		goto ERROR
     end
  end
    
  begin try  
  -- solo asigna
	update  [dbo].[mdb_seg_tbl_usuario]  
    set        
    fc_llave_usuario = @pc_llave_usuario  ,
    fd_fecha_vencimiento = dateadd(day,90, getdate())
    where fc_usuario = @pc_usuario  
      
   end try  
   begin catch  
      select @error = 1,  
    @msg=ERROR_MESSAGE()  
    goto ERROR  
   end catch  
  
  
goto FIN  
  
ERROR:  
  
  raiserror(@msg,18,1)    
  
FIN:  
  
SET NOCOUNT OFF  
  
select 'status'= @error  
  
  
END  