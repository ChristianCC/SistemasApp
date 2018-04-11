using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ServiceModel;
using System.ServiceModel.Security;
using E = Entidades.Serv_Admin;
using S = Entidades;

namespace DAO.MdSistema
{
    public class DAOItemModulo
    {
        private string usuario;
        private string pass;

        public DAOItemModulo(string usuario, string pass)
        {
            this.usuario = usuario;
            this.pass = pass;
        }

        public List<E.VMItemModulo> ObtenerItemsSistema()
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                List<E.VMItemModulo> lista = serPi.ObtenerItemsModulo().ToList();
                serPi.Close();
                
                return lista;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void EditarItemModulo(int idPaginaModulo,string nombre,
            int idModulo, string urlIcono, string urlDestino, int idItemPadre, int orden, bool activo)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                serPi.EditarPaginaModulo( idPaginaModulo, nombre,
             idModulo,  urlIcono,  urlDestino,  idItemPadre,  orden,  activo);
                serPi.Close();

            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public E.VMItemModulo RegistrarItemsModulo(string nombre,
            int idModulo, string urlIcono, string urlDestino, int idItemPadre, int orden, bool activo)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                E.VMItemModulo lista = serPi.RegistrarPaginaModulo(nombre,
             idModulo, urlIcono, urlDestino, idItemPadre, orden, activo);
                serPi.Close();

                return lista;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

    }
}
