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
    public class DAOPermisos
    {
        private string usuario;
        private string pass;

        public DAOPermisos(string usuario, string pass)
        {
            this.usuario = usuario;
            this.pass = pass;
        }

        public List<E.VMPermisoItem> ObtenerPermisosItems(string usuario, int idSistema, int? idRol = null)
        {
            try
            {
                S.Serv_Admin.ServiceAccesoClient serPi = new S.Serv_Admin.ServiceAccesoClient("BasicHttpBinding_IServiceAcceso");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                List<E.VMPermisoItem> lista = new List<E.VMPermisoItem>();
                E.VMPermisoItem[] items = serPi.ObtenerPermisosItemsUsuario(usuario, idSistema,idRol);
                serPi.Close();
                if (items != null)
                {
                    lista = items.ToList();
                }
                return lista;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void AsignarPermisosItems(int idUsuarioItem,bool write, bool delete)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;                
                serPi.AsignarPermisos(idUsuarioItem,write,delete);
                serPi.Close();
                
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }


        public List<E.VMToolItem> ObtenerPermisosToolsItems(int idUsuarioPermisos)
        {
            try
            {
                S.Serv_Admin.ServiceAccesoClient serPi = new S.Serv_Admin.ServiceAccesoClient("BasicHttpBinding_IServiceAcceso");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                List<E.VMToolItem> lista = new List<E.VMToolItem>();
                E.VMToolItem[] items = serPi.ObtenerPermisosToolsUsuario(idUsuarioPermisos);
                serPi.Close();
                if (items != null)
                {
                    lista = items.ToList();
                }
                return lista;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void AsignarPermisosToolItems(int idUsuarioItem, int idTool, bool permitir)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;                
                serPi.AsignarPermisosTool(idUsuarioItem, idTool,permitir);
                serPi.Close();

            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }
    }
}
