using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using DAO;
using DAO.MdSistema;
using Entidades;
using Tools;
using E = Entidades.Serv_Admin;
using T = Entidades.Serv_Token;

namespace Negocio.MdSistema
{
    public class NegocioSistema
    {
        private string usuario;
        private string pass;

        public NegocioSistema(string usuario, string pass)
        {
            this.usuario = usuario;
            this.pass = pass;
        }

        public List<E.VMSistema> ObtenerSistemasUsuario(string usuario)
        {
            try
            {
                return new DAOSistema(this.usuario, this.pass).ObtenerSistemasUsuario(
                    usuario
                    );                
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<E.VMItemModulo> ObtenerItemsUsuario(string usuario)
        {
            try
            {
                List<E.VMItemModulo> items = new DAOSistema(this.usuario, this.pass).ObtenerItemsUsuario(
                   usuario
                    );                
                return items;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public string IniciarSesion(string usuario, string llave, string ip, string sistema,bool cerrarSesiones)
        {
            try
            {
                return new DAOSistema(this.usuario, this.pass).IniciarSesion(
                     usuario, llave, ip, sistema, cerrarSesiones
                    );
                
            }            
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public void CerrarSesion(string usuario)
        {
            try
            {
                new DAOSistema(this.usuario, this.pass).CerrarSesion(
                     usuario
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public List<E.VMPais> ObtenerListaPaises()
        {
            try
            {
                
                List<E.VMPais> paises = new DAOPais(this.usuario, this.pass).ObtenerListapaises();
                // Esto es solo para desacoplar las capas
                return paises;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<E.VMPermisoItem> ObtenerPermisosItemsUsuario(string usuario,int idSistema)
        {
            try
            {
                List<E.VMPermisoItem> items = new DAOPermisos(this.usuario, this.pass).ObtenerPermisosItems(
                   usuario, idSistema
                    );
                return items;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public E.VMPermisoItem ObtenerPermisosItemsUsuarioRol(string usuario, int idSistema,int idRol, int idItemModulo)
        {
            try
            {
                E.VMPermisoItem item = null;
                List<E.VMPermisoItem> items = new DAOPermisos(this.usuario, this.pass).ObtenerPermisosItems(
                   usuario, idSistema,idRol
                    );
                if (items != null)
                {
                  item =  (from x in items
                     where x.IdItemModulo == idItemModulo
                     select x
                     ).FirstOrDefault();
                }

                return item;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<E.VMToolItem> ObtenerPermisosToolsUsuario(int idUsuarioPermisos)
        {
            try
            {
                List<E.VMToolItem> items = new DAOPermisos(this.usuario, this.pass).ObtenerPermisosToolsItems(
                   idUsuarioPermisos
                    );
                return items;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public T.RespuestaSesion ValidarToken(string token)
        {
            try
            {                
                return  new DAOSistema(this.usuario, this.pass).ValidarToken(token);                
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public T.RespuestaSesion ValidarAcceso(string url, string usuario)
        {
            try
            {
                return new DAOSistema(this.usuario, this.pass).ValidarAcceso(url,usuario);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<E.VMRol> ObtenerRolesUsuario(string usuario, int idSistema)
        {
            try
            {
                List<E.VMRol> roles = new DAORol(this.usuario, this.pass).ObtenerRolesUsuario(
                   usuario,
                   idSistema
                    );                
                return roles;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<E.VMItemModulo> ObtenerItemsDeRol(int idRol)
        {
            try
            {
                List<E.VMItemModulo> items = new DAORol(this.usuario, this.pass).ObtenerItemsRol(idRol);
                return items;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        

    }
}
