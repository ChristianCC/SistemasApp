using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools;
using T = Entidades.Serv_Token;
using Negocio.MdSistema;
using SistemasApp.Common;

namespace SistemasApp
{
    public partial class Authorization : System.Web.UI.Page
    {
        ParamEncrip paramEncrip = new ParamEncrip();


        private void VerificarToken()
        {
            string parametros = ParamEncrip.ObtenerParametrosPagina();
            
            try
            {
                if (paramEncrip["tkn"] != null)
                {
                    //Busca token en BD
                    T.RespuestaSesion r = new NegocioSistema(null, null).ValidarToken(paramEncrip["tkn"]);                   
                   //if ( paramEncrip["nurl"] != null)
                   //{
                   //    //Encripta url y la envia
                   //    parametros += ("nurl=" + paramEncrip["nurl"]);
                   //}

                   if (r.Code != "0")//Sesion no activa
                   {
                       Response.Redirect(MapeoSistema.END_SESION + "?" + HttpUtility.UrlPathEncode(parametros), false);
                   }
                   else
                   {
                      
                   }                   
                }
                else
                {
                    Response.Redirect(MapeoSistema.RUTA_SESION + ((!string.IsNullOrEmpty(parametros))?"?" +  HttpUtility.UrlPathEncode(parametros):""), false);
                }

            }
            catch (Exception ex)
            {

                Response.Redirect(MapeoSistema.END_SESION + "?" + HttpUtility.UrlPathEncode(parametros));                
            }

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Verifica la información obtenida
                VerificarToken();
            }
            else
            {
                Response.Write("Petición Denegada");
                Response.End();
            }
        }
    }
}