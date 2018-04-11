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
    public class DAOModulo
    {
        private string usuario;
        private string pass;

        public DAOModulo(string usuario, string pass)
        {
            this.usuario = usuario;
            this.pass = pass;
        }

        public E.VMModulo ObtenerInfoModulo(int idModulo)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                E.VMModulo modulo = serPi.ObtenerInfoModuloSistemaApp(idModulo);
                serPi.Close();
                return modulo;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public E.VMModulo RegistrarModulo(string nombre, int idSistema, string urlIcono, string urlDestino
            , string dbConexion, bool activo)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                E.VMModulo modulo = serPi.RegistrarModuloSistemaApp(nombre,idSistema,urlIcono,urlDestino,dbConexion, activo);
                serPi.Close();
                return modulo;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void EditarModulo(int idModulo,string nombre, int idSistema, string urlIcono, string urlDestino
            , string dbConexion, bool activo)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                serPi.EditarModuloSistemaApp(idModulo, nombre, idSistema, urlIcono, urlDestino, dbConexion, activo);
                serPi.Close();                
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        
    }
}
