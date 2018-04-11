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

    public class DAOAdmin
    {
        private string usuario;
        private string pass;

        public DAOAdmin(string usuario, string pass)
        {
            this.usuario = usuario;
            this.pass = pass;
        }

        public List<E.VMUsuario> ObtenerCatalogoUsuarios()
        {
            try
            {                
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                List<E.VMUsuario> lista = serPi.ObtenerCatalogoUsuarios().ToList();
                serPi.Close();               
                return lista;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public E.VMUsuario RegistrarUsuario(string Nombre, string apellidoMaterno, string apellidoPaterno, string celular, string correo,
            string extension, int idEstatus, string password, string usuario_sistema)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                E.VMUsuario usuario = serPi.RegistrarNuevoUsuario(Nombre, apellidoMaterno, apellidoPaterno, celular, correo,
                                                                     extension,  idEstatus ,  password,  usuario_sistema);
                serPi.Close();
                return usuario;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void RegistrarRolUsuario(string usuario, int idRol )
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                serPi.AsignarRolUsuario(idRol,usuario);
                serPi.Close();                
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void EliminarRolUsuario(string usuario, int idRol)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                serPi.EliminarRolUsuario(idRol, usuario);
                serPi.Close();
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void RestPassUsuario(string usuario)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                serPi.ResetPassUsuario(usuario);
                serPi.Close();
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        /*mvg 06-12-2017*/
        /*Se agerga para edicion de usuarios*/
        public E.VMUsuario ObtenerInfoUsuario(string usuarioSistema)
        {
            try 
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;


                E.VMUsuario usr = serPi.ObtenerInfoUsuario(usuarioSistema);
                serPi.Close();
                return usr;
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void EditarUsuario(E.VMUsuario usuario)
        {
            try
            {
                S.Serv_Admin.ServiceGestionClient serPi = new S.Serv_Admin.ServiceGestionClient("BasicHttpBinding_IServiceGestion");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                serPi.EditarUsuario(usuario);
                serPi.Close();
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }

        public void EditaPassUsr(string usuario, string lastPass, string newPass)
        {
            try
            {
                S.Serv_Admin.ServiceAccesoClient serPi = new S.Serv_Admin.ServiceAccesoClient("BasicHttpBinding_IServiceAcceso");
                serPi.ClientCredentials.UserName.UserName = this.usuario;
                serPi.ClientCredentials.UserName.Password = this.pass;
                //serPi.ClientCredentials.ServiceCertificate.Authentication.CertificateValidationMode =
                //         X509CertificateValidationMode.None;
                serPi.ModificarPasswordUsuario(usuario, lastPass, newPass);
                serPi.Close();
            }
            catch (FaultException<E.ExceptionService> ex)
            {
                throw new Exception(ex.Detail.Mensaje);
            }
        }
    }
}
