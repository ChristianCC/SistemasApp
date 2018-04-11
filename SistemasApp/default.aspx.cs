using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using SistemasApp.Common;
using Tools;
using Negocio.MdSistema;
using E = Entidades.Serv_Admin;

namespace SistemasApp
{
    public partial class _default : System.Web.UI.Page
    {
        ParamEncrip paramEncrip = new ParamEncrip();
        Sistema sistema = new Sistema();
        private void IniciarSesion(string usuario, string llave, string ip, string sistema)
        {
            try
            {
                string respuesta = new NegocioSistema(null, null).IniciarSesion(
                   Convert.ToBase64String(Encriptacion.Encriptar(usuario)),
                   Convert.ToBase64String(Encriptacion.Encriptar(llave)),
                    ip,
                    sistema,
                    chkCerrarSesiones.Checked
                    );
                string data =  Encriptacion.Desencriptar(Convert.FromBase64String(respuesta));
                string [] info = data.Split(';');

                //Sistema.USUARIO = tbUsuario.Text;
               // Sistema.PASS = tbPass.Text;
               // Sistema.NOMBRE_USUARIO = us.Nombre;
               // Sistema.NOMBRE_USUARIO = info[0];        
                new Sistema().TOKEN_SESION = respuesta;
                if (string.IsNullOrEmpty(paramEncrip["nurl"]))//no definiio redireccion
                {
                    Response.Redirect(MapeoSistema.HOME + "?tkn=" + HttpUtility.UrlPathEncode(respuesta), false);
                }
                else
                {

                    string nurl = paramEncrip["nurl"];
                    byte[] nurlDecod = Convert.FromBase64String(nurl);
                    string nurlDes = Encriptacion.Desencriptar(nurlDecod);
                    //Valida que la url sea valida para este usuario
                    Entidades.Serv_Token.RespuestaSesion r = new NegocioSistema(null, null).ValidarAcceso(Convert.ToBase64String(Encriptacion.Encriptar(usuario))
                        , nurlDes);
                    if (r.Code == "403")//Acceso denegado
                    {
                        Response.Redirect(MapeoSistema.ERROR_403,false);
                    }
                    else
                    {
                        Response.Redirect(nurlDes + "?tkn=" + HttpUtility.UrlPathEncode(respuesta), false);
                    }

                }

            }
            catch (Exception ex)
            {
                if (ex.Data["code"] != null)
                {
                    
                    switch (ex.Data["code"].ToString())
                    {
                        case "1": //error no especificado                        
                        case "2":
                        case "3": //Cerrar todas las sesiones                                                                     
                            MostrarMensajeError("Error: " + ex.Message);
                            break;
                        case "5":
                            MuestraFormularioContraseña(ex.Data["code"].ToString(), ex.Message, usuario);
                            break;
                    }
                }
                else
                {
                    MostrarMensajeError("Error: " + ex.Message);
                }

            }
        }

        private void LimpiarMensajeError()
        {
            pnlMensajeError.Visible = false;
            lblMensajeError.Text = string.Empty;
        }

        private void MostrarMensajeError(string mensaje)
        {
            pnlMensajeError.Visible = true;
            lblMensajeError.Text = mensaje;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            divActualizaPassVencida.Visible = false;
            pnlMensajeErrorPass.Visible = false;

            LimpiarMensajeError();
            StackUrlSistema.Clear();
            Session.Clear();
        }

        protected void btnIniciarSesion_Click(object sender, EventArgs e)
        {
            IniciarSesion(tbUsuario.Text,
                tbPass.Text,
                Request.UserHostAddress,
                    Request.Browser.Browser);
        }

        #region MetodosContraseñaVencida
        /*
         * mvg 18-12-2017
         * SE AGREGAN MOTODOS PARA ACTUALIZAR CONTRAEÑA VENCIDA
         */
        protected void MuestraFormularioContraseña(string codigoError,string error, string usuario)
        {
            divDatosSesion.Visible = false;
            lbUsr.Text = usuario;

            pnlMensajeErrorPass.Visible = true;
            lblMensajeErrorPass.Text = error;
            divActualizaPassVencida.Visible = true;

            
        }

        protected void LimpiarFolmularioPassVencida()
        {
            txtLastPass.Text = "";
            txtNewPass.Text = "";
            txtConfirmPass.Text = "";

            tbPass.Text = "";
            tbUsuario.Text = "";

            divActualizaPassVencida.Visible = false;
            divDatosSesion.Visible = true;
            
        }

        protected void btnActualizaPassVencida_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(txtLastPass.Text) & !string.IsNullOrEmpty(txtNewPass.Text) & !string.IsNullOrEmpty(txtConfirmPass.Text))
                {
                    if (txtNewPass.Text == txtConfirmPass.Text)
                    {
                        new NegocioAdmin(null, null).EditaPassUsuario
                                                    (
                                                        Convert.ToBase64String(Tools.Encriptacion.Encriptar(lbUsr.Text)),
                                                        Convert.ToBase64String(Tools.Encriptacion.Encriptar(txtLastPass.Text)),
                                                        Convert.ToBase64String(Tools.Encriptacion.Encriptar(txtNewPass.Text))
                                                    );
                        LimpiarFolmularioPassVencida();

                        AlertaJS("Contraseña actualizada correctamente", 1);
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensajeErrorPass.Text = ex.Message;
                AlertaJS(ex.Message, 0);
                lblMensajeErrorPass.Text = "Tu contraseña ha expirado. Por favor registra una nueva.";
                pnlMensajeErrorPass.Visible = true;
                divActualizaPassVencida.Visible = true;
             }
        }

        protected void AlertaJS(string mensaje, int tipomensaje)
        {

            string script = @"<script type='text/javascript'>
                            Notificacion('" + mensaje + "'," + tipomensaje + ");</script>";

            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
        }
        #endregion
    }
}