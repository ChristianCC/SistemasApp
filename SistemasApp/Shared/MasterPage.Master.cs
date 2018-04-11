using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using SistemasApp.Common;

using System.Web.UI.HtmlControls;

using E = Entidades.Serv_Admin;
using Negocio.MdSistema;
using System.Data;
using Telerik.Web.UI;

namespace SistemasApp.Shared
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        Sistema sistema = new Sistema();
        #region Variables
        private List<E.VMRol> LIST_ROLES_USUARIO
        {
            get
            {
                if (Session["LIST_ROLES_USUARIO"] == null)
                {
                    try
                    {
                        Session["LIST_ROLES_USUARIO"] =
                            new NegocioSistema(sistema.USR_LOGIN, sistema.PASS).ObtenerRolesUsuario(
                             sistema.USR_LOGIN,this.sistema.SISTEMA_ACTUAL.IdSistema );
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                        //  MostrarMensajeError(ex.Message);
                        // No existe sesion o el usuario no esta configurado

                    }
                }
                return Session["LIST_ROLES_USUARIO"] as List<E.VMRol>;
            }
            set
            {
                Session["LIST_ROLES_USUARIO"] = value;
            }
        }

        private List<E.VMItemModulo> LIST_ITEMS_USUARIO
        {
            get
            {
                if (Session["LIST_ITEMS_USUARIO"] == null)
                {
                    try
                    { 
                        Session["LIST_ITEMS_USUARIO"] =
                           /* new NegocioSistema(sistema.USR_LOGIN, sistema.PASS).ObtenerItemsUsuario(
                             sistema.USR_LOGIN);*/
                            new NegocioSistema(sistema.USR_LOGIN, sistema.PASS).ObtenerItemsDeRol(
                           sistema.ROL_ACTUAL.IdRol);
                           
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                        //  MostrarMensajeError(ex.Message);
                        // No existe sesion o el usuario no esta configurado

                    }
                }
                return Session["LIST_ITEMS_USUARIO"] as List<E.VMItemModulo>;
            }
            set
            {
                Session["LIST_ITEMS_USUARIO"] = value;
            }
        }

        private List<E.VMSistema> LIST_SISTEMAS_USUARIO
        {
            get
            {
                if (Session["LIST_SISTEMAS_USUARIO"] == null)
                {
                    try
                    {
                        Session["LIST_SISTEMAS_USUARIO"] =
                            new NegocioSistema(sistema.USR_LOGIN, sistema.PASS).ObtenerSistemasUsuario(
                            sistema.USR_LOGIN);
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                        //  MostrarMensajeError(ex.Message);
                        // No existe sesion o el usuario no esta configurado

                    }
                }
                return Session["LIST_SISTEMAS_USUARIO"] as List<E.VMSistema>;
            }
            set
            {
                Session["LIST_SISTEMAS_USUARIO"] = value;
            }
        }

        #endregion

        private bool AgregarItemsDeModulo(HtmlGenericControl nodoPadre, List<E.VMItemModulo> modulosNodo, int nivel)
        {
            HtmlGenericControl menu = new System.Web.UI.HtmlControls.HtmlGenericControl("ul");
            menu.Attributes.Add("class", "treeview-menu");
            bool actual = false;
            foreach (E.VMItemModulo item in modulosNodo)
            {
                HtmlGenericControl modulo = null;
                HyperLink link = null;

                if ((nivel == 0 && item.IdItemPadre == 0) || (nivel > 0))
                {
                    modulo = new HtmlGenericControl("li");
                    link = new HyperLink();
                    link.Text = item.UrlIcono + item.Descripcion;
                    link.NavigateUrl = item.Url;
                    modulo.Controls.Add(link);
                    link.Attributes.Add("onclick", "blockPage()");
                    if (item.Url == ".." + Request.Url.PathAndQuery)
                    {
                        actual = true;
                    }
                }

                if (modulo != null)
                {
                    menu.Controls.Add(modulo);
                }

                List<E.VMItemModulo> nodosHijos = (from x in modulosNodo
                                                        where x.IdItemPadre == item.IdItemModulo
                                                        select x).ToList();

                AgregarItemsDeModulo(modulo, nodosHijos, nivel++);
            }
            if (menu.Controls.Count > 0)
            {
                nodoPadre.Controls.Add(menu);
            }
            return actual;
        }


        private void CrearMenuPrincipal()
        {
            List<E.VMSistema> items = LIST_SISTEMAS_USUARIO;
            radMenuPrincipal.Items.Clear();
            if (items.Count > 0)
            {
                RadMenuItem it = new RadMenuItem();
                E.VMSistema sisActual = new E.VMSistema();
                if (sistema.SISTEMA_ACTUAL == null)
                {
                    //sisActual = items[0];
                    sistema.SISTEMA_ACTUAL = items[0]; //sisActual;
                    //Busca el rol principal      
                    LIST_ROLES_USUARIO = null;
                    LIST_ITEMS_USUARIO = null;
                    List<E.VMRol> roles = LIST_ROLES_USUARIO;
                    //Por el momento selecciona el prime rol dle sistema... Depues mostrara paises
                    sistema.ROL_ACTUAL = roles[0];

                    if (sistema.SISTEMA_ACTUAL.Embebido)
                    {
                        Response.Redirect("~/MdlSistema/Aplicacion", false);//Redirecciona a otra pagina mestra

                    }                    

                }
                //else
                {
                    sisActual = sistema.SISTEMA_ACTUAL;
                    if (sistema.ROL_ACTUAL == null)
                    {
                        //Busca el rol principal    
                        LIST_ROLES_USUARIO = null;
                        LIST_ITEMS_USUARIO = null;
                        List<E.VMRol> roles = LIST_ROLES_USUARIO;
                        //Por el momento selecciona el prime rol dle sistema... Depues mostrara paises
                        sistema.ROL_ACTUAL = roles[0];
                    }

                }
                it.Text = sisActual.NombreSistema;
                it.Value = sisActual.Logo;
                it.Attributes.Add("idSistema", sisActual.IdSistema.ToString());
                it.Attributes.Add("urlHome", sisActual.UrlHome);

                for (int i = 0; i < items.Count; i++)
                {
                    RadMenuItem itemMenu = new RadMenuItem();
                    itemMenu.Text = items[i].NombreSistema;
                    itemMenu.Value = items[i].Logo;
                    itemMenu.Attributes.Add("idSistema", items[i].IdSistema.ToString());
                    it.Items.Add(itemMenu);

                }

                radMenuPrincipal.Items.Add(it);
                radMenuPrincipal.DataBind();
            }

        }

        private void CrearMenu()
        {
            if (sistema.SISTEMA_ACTUAL != null)
            {
                //leftSideBar.Controls[1].Controls.Clear();
                // LIST_ITEMS_USUARIO = null;
                List<E.VMItemModulo> items = LIST_ITEMS_USUARIO;
                
                int idSistema = sistema.SISTEMA_ACTUAL.IdSistema;

                //// Busca los roles de esete sistema, en teoria no es posible que no tenga ningun role asignado
                //List<E.VMRol> roles = LIST_ROLES_USUARIO;
                ////Por el momento selecciona el prime rol dle sistema... Depues mostrara paises
                //sistema.ROL_ACTUAL = roles[0];


                var sistemas = (from x in items
                                where x.IdSistema == idSistema
                                group x by x.IdSistema into g
                                select new
                                {
                                    IdSistema = g.Key,
                                    item = g.ToList()
                                }
                                    ).ToList();
                //Agrega sistemas
                HtmlGenericControl menu = new System.Web.UI.HtmlControls.HtmlGenericControl("ul");
                for (int i = 0; i < sistemas.Count; i++)
                {
                    menu.Attributes.Add("class", "sidebar-menu");
                    HtmlGenericControl sis = new HtmlGenericControl("li");
                    sis.Attributes.Add("class", "header");
                    sis.InnerHtml = sistemas[i].item[0].Sistema;


                    var modulos = (from x in sistemas[i].item
                                   group x by x.IdModulo into g
                                   select new
                                   {
                                       IdModulo = g.Key,
                                       item = g.ToList()
                                   }
                                    ).ToList();
                    //Agregar modulos de sistema
                    for (int j = 0; j < modulos.Count; j++)
                    {
                        HtmlGenericControl modulo = new HtmlGenericControl("li");
                        HyperLink link = new HyperLink();
                        link.Text = modulos[j].item[0].UrlIconoModulo + "<span>" + modulos[j].item[0].Modulo + "</span><span class='pull-right-container'><i class='fa fa-angle-left pull-right'></i></span>";
                        modulo.Attributes.Add("class", "treeview");
                        modulo.Controls.Add(link);

                        if (AgregarItemsDeModulo(modulo, modulos[j].item, 0))
                        {

                            modulo.Attributes["class"] = modulo.Attributes["class"] + " active ";

                        }
                        sis.Controls.Add(modulo);

                    }

                    menu.Controls.Add(sis);
                }

                leftSideBar.Controls.Add(menu);
            }
            else// permisos no configurados
            {
                
            }
        }

        private void CerrarSesion()
        {
            new NegocioSistema(sistema.USR_LOGIN, sistema.PASS).CerrarSesion(sistema.USR_LOGIN);
            Session.Clear();
            Response.Redirect(MapeoSistema.RUTA_SESION);
        }

        private void Mostrardatos()
        {
            lblUsuario.InnerText = sistema.NOMBRE_USUARIO;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            sistema.AnalizarPeticion();
            if (!IsPostBack)
            {
                StackUrlSistema.AddRuta(Request.Url.PathAndQuery);
                lknBack.Visible = (StackUrlSistema.Count() > 1);
                CrearMenuPrincipal();
                CrearMenu();
                Mostrardatos();
            }
            else
            {
                CrearMenu();// ??
            }
        }

        protected void lknBack_Click(object sender, EventArgs e)
        {
            Response.Redirect(StackUrlSistema.GetBack());
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            CerrarSesion();
        }

        protected void lknPagHome_Click(object sender, EventArgs e)
        {
            try
            {
                int idSistema = Convert.ToInt32(((LinkButton)sender).CommandArgument);
                List<E.VMSistema> items = LIST_SISTEMAS_USUARIO;
                sistema.SISTEMA_ACTUAL = items.Where(x => x.IdSistema == idSistema).FirstOrDefault();
                LIST_ROLES_USUARIO = null;
                LIST_ITEMS_USUARIO = null;
                //Busca el rol principal                    
                List<E.VMRol> roles = LIST_ROLES_USUARIO;
                //Por el momento selecciona el prime rol dle sistema... Depues mostrara paises
                sistema.ROL_ACTUAL = roles[0];

                StackUrlSistema.Clear();
                if(sistema.SISTEMA_ACTUAL.Embebido)
                {
                  Response.Redirect(sistema.SISTEMA_ACTUAL.UrlHome);
                }
                else
                {
                    string parametros = "tkn=" + sistema.TOKEN_SESION;
                    Response.Redirect(sistema.SISTEMA_ACTUAL.UrlHome + "?" + HttpUtility.UrlPathEncode(parametros));                    
                }

            }
            catch (Exception ex)
            {
            }
        }

        /*MVG 13/12/2017
         * Se agregan metodos para edicion de contraseña 
         */
        protected void btnEditarPerfil_Click(object sender, EventArgs e)
        {
            pnlErrorRegPagina.Visible = false;
            LimpiarErrorRegistro();
            mpEdicionUsuario.Show();
            
        }

        protected void btnCancelarEditaPerfil_Click(object sender, EventArgs e)
        {
            mpEdicionUsuario.Hide();
            LimpiarFolmularioPerfil();
        }

        protected void btnEditaPerfil_Click(object sender, EventArgs e)
        {
             try
            {
           

            new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).EditaPassUsuario
                (
                    Convert.ToBase64String(Tools.Encriptacion.Encriptar(sistema.USR_LOGIN)),
                    Convert.ToBase64String(Tools.Encriptacion.Encriptar(tbLastPass.Text)),
                    Convert.ToBase64String(Tools.Encriptacion.Encriptar(tbNewPass.Text))
                );

            mpEdicionUsuario.Hide();
            LimpiarFolmularioPerfil();

            AlertaJS("Contraseña actualizada correctamente",1);
            }
             catch (Exception ex)
             {
                 MostrarErrorRegistro(ex.Message);
                 AlertaJS("ex.Message", 0);

             }
        }

        private void MostrarErrorRegistro(string error)
        {
            pnlErrorReg.Visible = true;
            lblErrorReg.Text = error;
        }

        private void LimpiarErrorRegistro()
        {
            pnlErrorReg.Visible = false;
            lblErrorReg.Text = string.Empty;
        }

        protected void LimpiarFolmularioPerfil()
        {
            tbLastPass.Text = "";
            tbNewPass.Text = "";
            tbConfirmNewPass.Text = "";
        }

        protected void AlertaJS(string mensaje, int tipomensaje)
        {
            string script = @"<script type='text/javascript'>
                            Notificacion('" + mensaje + "'," + tipomensaje + ");</script>";

            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
        }
    }
}