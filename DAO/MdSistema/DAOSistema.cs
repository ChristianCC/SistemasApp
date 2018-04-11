using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ServiceModel;
using System.ServiceModel.Security;
using E = Entidades.Serv_Admin;
using T = Entidades.Serv_Token;
using S = Entidades;


namespace DAO.MdSistema
{
    public class DAOSistema
    {
        private string usuario;
        private string pass;

        public DAOSistema(string usuario, string pass)
        {
            this.usuario = usuario;
            this.pass = pass;
        }

        public List<E.VMSistema> ObtenerSistemasUsuario(string usuario)
        {
            try
            {
                S.Serv_Admin.ServiceAccesoClient serPi = new S.Serv_Admin.ServiceAccesoClient("BasicHttpBinding_IServiceAcceso");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                List<E.VMSistema> lista = serPi.ObtenerSistemasUsuario(usuario).ToList();
                serPi.Close();                
                return lista;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);                
            }
        }

        public List<E.VMItemModulo> ObtenerItemsUsuario(string usuario)
        {
            try
            {
                S.Serv_Admin.ServiceAccesoClient serPi = new S.Serv_Admin.ServiceAccesoClient("BasicHttpBinding_IServiceAcceso");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                List<E.VMItemModulo> lista = serPi.ObtenerItemsUsuario(usuario).ToList();
                serPi.Close();
                return lista;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public string IniciarSesion(string usuario, string llave, string ip, string sistema,bool cerrarSesiones )
        {
            try
            {
                S.Serv_Admin.ServiceAccesoClient serPi = new S.Serv_Admin.ServiceAccesoClient("BasicHttpBinding_IServiceAcceso");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;                
                string token = serPi.IniciarSesion(usuario, llave, ip, sistema, cerrarSesiones);
                serPi.Close();
                return token;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                Exception exInt = new Exception(ex.Detail.Mensaje,ex);
                exInt.Data.Add("code", ex.Detail.ErrorCode);
                throw exInt;
            }
        }

        public void CerrarSesion(string usuario)
        {
            try
            {
                S.Serv_Admin.ServiceAccesoClient serPi = new S.Serv_Admin.ServiceAccesoClient("BasicHttpBinding_IServiceAcceso");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                serPi.CerrarSesion(usuario);
                serPi.Close();
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public T.RespuestaSesion ValidarToken(string token)
        {
            try
            {
                T.ServiceTokenClient serPi = new T.ServiceTokenClient("BasicHttpBinding_IServiceToken");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                T.RespuestaSesion resp = serPi.ValidarToken(token);
                serPi.Close();
                return resp;
            }
            catch (FaultException<T.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
            
        }

        public T.RespuestaSesion ValidarAcceso(string url,string usuario)
        {
            try
            {
                T.ServiceTokenClient serPi = new T.ServiceTokenClient("BasicHttpBinding_IServiceToken");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                T.RespuestaSesion resp = serPi.ValidarAcceso(url,usuario);
                serPi.Close();
                return resp;
            }
            catch (FaultException<T.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }

        }

        
    }
}
