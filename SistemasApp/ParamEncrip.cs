using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Tools;

namespace SistemasApp
{
    public class ParamEncrip
    {
        public static string EncriptarParametros(string parametros)
        {
            if (string.IsNullOrEmpty(parametros)) return parametros;

            string parEnc = string.Empty;

            //parEnc = HttpUtility.UrlEncode( Encriptacion.Encriptar(parametros));
            parEnc = Convert.ToBase64String(Encriptacion.Encriptar(parametros));
            return parEnc;
        }

        public string this[string nombreParametro]
        {
            get
            {
                return ValorParametro(string.IsNullOrEmpty(nombreParametro) ? nombreParametro : HttpUtility.UrlDecode(nombreParametro).Replace(' ','+'));
            }
        }

        private static string ValorParametro(string nombreParametro)
        {
            string valor = string.Empty;
            //Dictionary<string, string> parametros = new Dictionary<string, string>();
            // string param = ObtenerParametrosPagina();
            //if (!string.IsNullOrEmpty(param))
            //{
            //    parametros = RecuperarParametros(param);
            //}

            var parametros = HttpContext.Current.Request.Params;//recupera los parametros
            if (parametros.HasKeys())
            {
                if (parametros[nombreParametro] != null)
                {
                    valor = HttpUtility.UrlDecode(parametros[nombreParametro]).Replace(' ', '+');
                }

                //if (parametros.ContainsKey(nombreParametro))
                //{
                //    valor = parametros[nombreParametro];
                //}
                //else
                //{
                //    valor = null;
                //}
            }

            return valor;
        }

        private static Dictionary<string, string> RecuperarParametros(string parametros)
        {
            Dictionary<string, string> pars = new Dictionary<string, string>();

            string[] parametrosSeparados = parametros.Split(new string[] { "&" }, StringSplitOptions.RemoveEmptyEntries);

            foreach (string parametro in parametrosSeparados)
            {
                string[] pareja = parametro.Split(new string[] { "=" }, StringSplitOptions.RemoveEmptyEntries);

                string nombre = string.Empty, valor = string.Empty;

                if (pareja.Length > 0) nombre = pareja[0];
                if (pareja.Length > 1) valor = pareja[1];

                pars.Add(nombre, valor);
            }

            return pars;
        }

        public static string ObtenerParametrosPagina()
        {
            string cadenaUrl = string.Empty;
            int inicioParametros = 0;

            cadenaUrl = HttpContext.Current.Request.RawUrl;
            inicioParametros = cadenaUrl.IndexOf("?");

            if (inicioParametros++ > 0)
            {
                cadenaUrl = HttpUtility.UrlDecode(cadenaUrl.Substring(inicioParametros)).Replace(' ','+');
                //cadenaUrl = cadenaUrl.Substring(inicioParametros);
            }
            else
            {
                cadenaUrl = string.Empty;
            }

            return cadenaUrl;
        }
    }
}