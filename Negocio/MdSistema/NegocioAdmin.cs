using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAO.MdSistema;
using Entidades;
using Tools;
using E = Entidades.Serv_Admin;

namespace Negocio.MdSistema
{
    public class NegocioAdmin
    {
        private string usuario;
        private string pass;

        public NegocioAdmin(string usuario, string pass)
        {
            this.usuario = usuario;
            this.pass = pass;
        }

        public List<E.VMUsuario> ObtenerCatalogoUsuarios()
        {
            try
            {
                List<E.VMUsuario> usuarios = new DAOAdmin(this.usuario, this.pass).ObtenerCatalogoUsuarios();
                return usuarios;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public E.VMUsuario RegistrarUsuario(string Nombre, string apellidoMaterno, string apellidoPaterno, string celular, string correo,
            string extension, int idEstatus, string password, string usuario_sistema)
        {
            try
            {
                E.VMUsuario usuario = new DAOAdmin(this.usuario, this.pass).RegistrarUsuario(Nombre, apellidoMaterno, apellidoPaterno, celular, correo,
                extension, idEstatus, 
                Convert.ToBase64String(Encriptacion.Encriptar(password)),
               Convert.ToBase64String(Encriptacion.Encriptar(usuario_sistema)));                
                return usuario;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void RestPassword(string usuario_sistema)
        {
            try
            {
                 new DAOAdmin(this.usuario, this.pass).RestPassUsuario(
                    Convert.ToBase64String(Encriptacion.Encriptar(usuario_sistema)) );                
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<E.VMRol> ObtenerRoles(int idSistema)
        {
            try
            {
                List<E.VMRol> roles = new DAORol(this.usuario, this.pass).ObtenerRoles(idSistema);
                
                return roles;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<E.VMRol> ObtenerRolesUsuario(string usu, int? idSistema)
        {
            try
            {
                List<E.VMRol> roles = new DAORol(this.usuario, this.pass).ObtenerRolesUsuario(usu,idSistema);                
                return roles;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public E.VMRol RegistrarRol(string nombre, string descripcion, int idPais)
        {
            try
            {
                E.VMRol rol = new DAORol(this.usuario, this.pass).RegistrarRol(nombre, descripcion, idPais);

                return rol;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<E.VMItemModulo> ObtenerItemsSistema()
        {
            try
            {
                List<E.VMItemModulo> items = new DAOItemModulo(this.usuario, this.pass).ObtenerItemsSistema();

                return items;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<E.VMItemModulo> ObtenerItemsRolAsignados(int idRol)
        {
            try
            {
                List<E.VMItemModulo> items = new DAORol(this.usuario, this.pass).ObtenerItemsRol(
                    idRol);                
                return items;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void AsignarRolItem(int idRol,int idItem)
        {
            try
            {
                new DAORol(this.usuario, this.pass).RegistrarRolItem(idRol,
                        idItem
                    );                
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void EliminarRolItem(int idRol, int idItem)
        {
            try
            {
                new DAORol(this.usuario, this.pass).EliminarItem(
                    idRol,
                     idItem 
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void AsignarRolUsuario(int idRol, string usuario)
        {
            try
            {
                new DAOAdmin(this.usuario, this.pass).RegistrarRolUsuario(                    
                    usuario,
                    idRol
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void EliminarRolUsuario(int idRol, string usuario)
        {
            try
            {
                new DAOAdmin(this.usuario, this.pass).EliminarRolUsuario(
                    usuario,
                    idRol
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void AsignarPermisosItems(int idUsuarioItem, bool write, bool delete)
        {
            try
            {
                new DAOPermisos(this.usuario, this.pass).AsignarPermisosItems(idUsuarioItem,write,delete);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void AsignarPermisosToolItems(int idUsuarioPermiso, int idTool, bool permitir)
        {
            try
            {
                new DAOPermisos(this.usuario, this.pass).AsignarPermisosToolItems(idUsuarioPermiso, idTool, permitir);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<E.VMSistema> ObtenerCatalogoSistemas()
        {
            try
            {
                List<E.VMSistema> sistemas = new DAOSistemaApp(this.usuario, this.pass).ObtenerSistemas();
                return sistemas;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public E.VMSistema RegistrarSistemas(string nombre, string logo, string urlhome, bool embebido, bool activo)
        {
            try
            {
                E.VMSistema sistema = new DAOSistemaApp(this.usuario, this.pass)
                    .RegistrarSistemaApp( nombre,  logo,  urlhome,  embebido,  activo);
                return sistema;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void EditarSistemas(int idSistema,string nombre, string logo, string urlhome, bool embebido, bool activo)
        {
            try
            {
                new DAOSistemaApp(this.usuario, this.pass)
                    .EditarSistemaApp(idSistema,nombre, logo, urlhome, embebido, activo);                
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public E.VMSistema ObtenerInformacionSistemas(int idSistema)
        {
            try
            {
                E.VMSistema sistemas = new DAOSistemaApp(this.usuario, this.pass).ObtenerInfoSistema(idSistema);
                return sistemas;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<E.VMModulo> ObtenerModulosSistema(int idSistema, bool? activos)
        {
            try
            {
                return new DAOSistemaApp(this.usuario, this.pass).ObtenerModulosSistema(idSistema,activos);                
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public E.VMModulo RegistrarModuloSistema(string nombre, int idSistema, string urlIcono, string urlDestino
            , string dbConexion, bool activo)
        {
            try
            {
                return new DAOModulo(this.usuario, this.pass).RegistrarModulo(nombre,idSistema,urlIcono,urlDestino,dbConexion,activo);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public E.VMItemModulo RegistrarPaginaModulo(string nombre,
            int idModulo, string urlIcono, string urlDestino, int idItemPadre, int orden, bool activo)
        {
            try
            {
                return new DAOItemModulo(this.usuario, this.pass).RegistrarItemsModulo( nombre,
                                 idModulo,  urlIcono,  urlDestino,  idItemPadre,  orden,  activo);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /*mvg 06-12-2017*/
        /*Se agerga para edicion de usuarios*/
        public E.VMUsuario ObtenerInfoUsuario(string usuarioSistema)
        {
            try 
            {
                return new DAOAdmin(this.usuario, this.pass).ObtenerInfoUsuario(usuarioSistema);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void EditarUsuario(E.VMUsuario usuario)
        {
            try
            {
                new DAOAdmin(this.usuario, this.pass).EditarUsuario(usuario);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void EditaPassUsuario(string usuario, string lastPass, string newPass)
        {
            try 
            {
                new DAOAdmin(this.usuario, this.pass).EditaPassUsr(usuario, lastPass, newPass);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }
    }
}
