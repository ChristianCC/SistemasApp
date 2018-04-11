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
    public class DAORol
    {
        private string usuario;
        private string pass;

        public DAORol(string usuario, string pass)
        {
            this.usuario = usuario;
            this.pass = pass;
        }

        public List<E.VMRol> ObtenerRoles(int idSistema)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                List<E.VMRol> lista = serPi.ObtenerRoles(idSistema).ToList();
                serPi.Close();                
                return lista;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public List<E.VMRol> ObtenerRolesUsuario(string usuario,int? idSistema)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                List<E.VMRol> lista = serPi.ObtenerRolesUsuario(usuario,idSistema).ToList();
                serPi.Close();                
                return lista;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public E.VMRol RegistrarRol(string nombre, string descripcion, int idPais )
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                E.VMRol obj = serPi.RegistrarNuevoRol(nombre,descripcion,idPais);
                serPi.Close();
                return obj;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void RegistrarRolItem(int idRol, int idItem)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                serPi.AsignarItemRol(idRol,idItem);
                serPi.Close();                
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void EliminarItem(int idRol, int idItem)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                serPi.EliminarItemRol(idRol, idItem);
                serPi.Close();
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public List<E.VMItemModulo> ObtenerItemsRol(int idRol)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                List<E.VMItemModulo> lista = serPi.ObtenerItemsRol(idRol).ToList();
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
