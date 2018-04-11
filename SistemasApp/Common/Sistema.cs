using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Configuration;
using  E = Entidades.Serv_Admin;
using Tools;

namespace SistemasApp.Common
{
    public  class Sistema
    {
         ParamEncrip paramEncrip = new ParamEncrip();

        public  string NOMBRE_SISTEMA
        {
            get
            {
                return "Sistema para monitoreo de procesos";
            }
        }

        public  string USR_LOGIN
        {
            get
            {
                if (HttpContext.Current.Session["USR_LOGIN"] != null)
                {
                    string usuario = (string)HttpContext.Current.Session["USR_LOGIN"];
                    if (string.IsNullOrEmpty(usuario))
                    {
                        HttpContext.Current.Response.Redirect(MapeoSistema.RUTA_SESION);
                    }
                    return usuario;
                }
                else
                {
                    HttpContext.Current.Response.Redirect(MapeoSistema.RUTA_SESION);
                    return null;
                }
            }
            set
            {                
                HttpContext.Current.Session["USR_LOGIN"] = value;
            }
        }

        public  string PASS
        {
            get
            {
                return HttpContext.Current.Session["PASS"] != null ?
                    HttpContext.Current.Session["PASS"].ToString() : null;
            }
            set
            {

                HttpContext.Current.Session["PASS"] = Convert.ToBase64String(Encriptacion.Encriptar(value));
            }
        }

        public  string PROCESO_EN_EDICION
        {
            get
            {
                return HttpContext.Current.Session["PROCESO_EN_EDICION"] != null ?
                    HttpContext.Current.Session["PROCESO_EN_EDICION"].ToString() : null;
            }
            set
            {
                HttpContext.Current.Session["PROCESO_EN_EDICION"] = value;
            }
        }

        public  E.VMSistema SISTEMA_ACTUAL
        {
            get
            {
                return HttpContext.Current.Session["ID_SISTEMA_ACTUAL"] != null ?
                    (E.VMSistema)HttpContext.Current.Session["ID_SISTEMA_ACTUAL"] : null;
            }
            set
            {

                HttpContext.Current.Session["ID_SISTEMA_ACTUAL"] = value;
            }
        }

        public E.VMRol ROL_ACTUAL
        {
            get
            {
                return HttpContext.Current.Session["ROL_ACTUAL"] != null ?
                    (E.VMRol)HttpContext.Current.Session["ROL_ACTUAL"] : null;
            }
            set
            {

                HttpContext.Current.Session["ROL_ACTUAL"] = value;
            }
        }

        public  string NOMBRE_USUARIO
        {
            get
            {
                return HttpContext.Current.Session["NOMBRE_USUARIO"] != null ?
                    HttpContext.Current.Session["NOMBRE_USUARIO"].ToString() : "";
            }
            set
            {
                HttpContext.Current.Session["NOMBRE_USUARIO"] = value;
            }
        }

        public  string TOKEN
        {
            get
            {
                return HttpContext.Current.Session["TOKEN"] != null ?
                    HttpContext.Current.Session["TOKEN"].ToString() : "";
            }
            set
            {
                HttpContext.Current.Session["TOKEN"] = value;
            }
        }

        public string TOKEN_SESION
        {
            get
            {
                return HttpContext.Current.Session["TOKEN_SESION"] != null ?
                    HttpContext.Current.Session["TOKEN_SESION"].ToString() : "";
            }
            set
            {
                HttpContext.Current.Session["TOKEN_SESION"] = value;
            }
        }

        private  void AbrirNuevaSesion()
        {
            try
            {
                string parametros = "nurl=" +
                  Convert.ToBase64String(Tools.Encriptacion.Encriptar(MapeoSistema.HOME));
                HttpContext.Current.Response.Redirect(MapeoSistema.URL_PETICIONES + "?" + HttpUtility.UrlPathEncode(parametros), true);
            }
            catch (Exception ex)
            {

            }
        }

        public  void AnalizarPeticion()
        {
            Sistema sistema = new Sistema();
            if (HttpContext.Current.Request.HttpMethod == "GET")
            {
                string cadenaUrl = HttpContext.Current.Request.Url.OriginalString;
                try
                {
                    string[] ke = HttpContext.Current.Request.Params.AllKeys;
                    if (!string.IsNullOrEmpty(paramEncrip["tkn"]))
                    {

                        string token = paramEncrip["tkn"];
                        string info = Tools.Encriptacion.Desencriptar(Convert.FromBase64String(token));
                        /* 0- Nombre
                         * 1- correo
                         * 2- extension
                         * 3- token sesion
                         * 4- usuario
                         */
                        string[] data = info.Split(';');
                        sistema.TOKEN = data[4];
                        sistema.USR_LOGIN = data[3];
                        sistema.NOMBRE_USUARIO = data[0];
                        string url = HttpContext.Current.Request.Url.OriginalString;
                        url = url.Replace("tkn=" + paramEncrip["tkn"], "");

                        HttpContext.Current.Response.Redirect(url, false);







                        //HttpContext.Current.Response.Headers["AUTH_USER"] = data[3];
                        //HttpContext.Current.Response.Headers["AUTH_PASSWORD"] = data[4];
                    }
                    else
                    {
                        //Valida el token que esta obteniendo
                        if (string.IsNullOrEmpty(sistema.TOKEN/*paramEncrip["AUTH_PASSWORD"]*/))
                        {//Pide una nueva sesion
                            AbrirNuevaSesion();
                        }
                        else
                        {
                            Entidades.Serv_Token.RespuestaSesion resp = new Negocio.MdSistema.NegocioSistema(null, null).
                                ValidarToken(sistema.TOKEN/*paramEncrip["AUTH_PASSWORD"]*/);
                            if (!resp.Activa) //Sesion no activa o  token invalido, redirecciona 
                            {
                                AbrirNuevaSesion();
                            }
                        }
                    }

                }
                catch (Exception ex)
                {
                    AbrirNuevaSesion();
                }
            }
            else//Poste
            {
            }
        }
    }

    public static class MapeoSistema
    {
        public static string URL_PETICIONES
        {
            get
            {
                return ConfigurationManager.AppSettings["URL_PETICIONES"].ToString();
            }
        }

        public static string URL_INICIO
        {
            get
            {
                return ConfigurationManager.AppSettings["URL_INICIO"].ToString();
            }
        }


        public static string RUTA_SESION
        {
            get { return "~/"; }
        }

        public static string ERROR_403
        {
            get { return "~/403"; }
        }

        public static string END_SESION
        {
            get { return "~/EndSesion"; }
        }

        public static string HOME
        {
            get { return "~/Home"; }
        }

        public static string RUTA_PERMISOS_ACCESO
        {
            get
            {
                //return "~/Empresas";
                return "~/MdlAdmin/Permisos";
            }
        }

        //public static string RUTA_BACK
        //{
        //    get
        //    {
        //        if (HttpContext.Current.Session["RUTA_BACK"] == null)
        //        {
        //            HttpContext.Current.Session["RUTA_BACK"] = RUTA_INICIO;
        //        }
        //        return HttpContext.Current.Session["RUTA_BACK"] as string;
        //    }
        //    set
        //    {
        //        HttpContext.Current.Session["RUTA_BACK"] = value;
        //    }
        //}


    }

    public static class StackUrlSistema
    {
        private static Stack<string> RUTA_STACK_BACK
        {
            get
            {
                if (HttpContext.Current.Session["RUTA_STACK_BACK"] == null)
                {
                    HttpContext.Current.Session["RUTA_STACK_BACK"] = new Stack<string>();
                }
                return HttpContext.Current.Session["RUTA_STACK_BACK"] as Stack<string>;
            }
            set
            {
                HttpContext.Current.Session["RUTA_STACK_BACK"] = value;
            }
        }

        public static string GetBack()
        {
            string url;
            Stack<string> stack = RUTA_STACK_BACK;
            if (stack.Count > 0)
            {
                if (stack.Count > 1)
                {
                    stack.Pop();
                    url = stack.Pop();
                    RUTA_STACK_BACK = stack;
                }
                else
                {
                    url = stack.Peek();
                }
            }
            else
            {
                url = MapeoSistema.RUTA_SESION;
            }
            return url;
        }

        public static void AddRuta(string url)
        {
            //url = "~" + url;
            Stack<string> stack = RUTA_STACK_BACK;
            if (stack.Count > 0)
            {
                if (stack.Peek().ToUpper() != url.ToUpper())
                {
                    stack.Push(url);
                    RUTA_STACK_BACK = stack;
                }
            }
            else
            {
                stack.Push(url);
                RUTA_STACK_BACK = stack;
            }

        }

        public static void Clear()
        {
            RUTA_STACK_BACK = null;
        }

        public static int Count()
        {
            Stack<string> stack = RUTA_STACK_BACK;
            return stack.Count();
        }

    }

}