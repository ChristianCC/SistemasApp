using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using E = Entidades.Serv_Admin;
using Negocio.MdSistema;
using System.Data;
using Telerik.Web.UI;
using SistemasApp.Common;

namespace SistemasApp.MdlApps
{
    public partial class Apps : System.Web.UI.Page
    {
        Sistema sistema = new Sistema();

        #region variables
        private List<E.VMSistema> LIST_APLICACIONES
        {
            get
            {
                if (Session["LIST_APLICACIONES"] == null)
                {
                    try
                    {
                        Session["LIST_APLICACIONES"] =
                            new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerCatalogoSistemas();
                    }
                    catch (Exception ex)
                    {
                        Master.MostrarMensajeError(ex.Message);
                    }
                }
                return Session["LIST_APLICACIONES"] as List<E.VMSistema>;
            }
            set
            {
                Session["LIST_APLICACIONES"] = value;
            }
        }


        #endregion

        #region Metodos

        private void Inicializar()
        {
            LIST_APLICACIONES = null;
        }

        private void MostrarErrorReg(string error)
        {
            pnlErrorRegApp.Visible = true;
            lblErrorRegApp.Text = error;
        }

        private void LimpiarErrorReg()
        {
            pnlErrorRegApp.Visible = false;
            lblErrorRegApp.Text = string.Empty;
        }

        private void MostrarErrorRegModulo(string error)
        {
            pnlErrorRegModulo.Visible = true;
            lblErrorRegModulo.Text = error;
        }

        private void LimpiarErrorRegModulo()
        {
            pnlErrorRegModulo.Visible = false;
            lblErrorRegModulo.Text = string.Empty;
        }

        private void MostrarErrorRegPagina(string error)
        {
            pnlErrorRegPagina.Visible = true;
            lblErrorRegPagina.Text = error;
        }

        private void LimpiarErrorRegPagina()
        {
            pnlErrorRegPagina.Visible = false;
            lblErrorRegPagina.Text = string.Empty;
        }

        private void MostrarErrorModulo(string error)
        {
            pnlErrorWinModulos.Visible = true;
            lblErrorWinModulos.Text = error;
        }

        private void LimpiarErrorModulo()
        {
            pnlErrorWinModulos.Visible = false;
            lblErrorWinModulos.Text = string.Empty;
        }

        private void CargarArbolSistema(int idSistema)
        {
            NegocioAdmin negAdmin = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS);
            rtvModulos.Nodes.Clear();
            E.VMSistema sis = negAdmin.ObtenerInformacionSistemas(idSistema);
            List<E.VMModulo> modulos = negAdmin.ObtenerModulosSistema(idSistema,null);//todos
            
                        
            /*LIST_ITEMS = null;

            

            List<E.VMItemModulo> items = LIST_ITEMS;
            var sistem = (from x in items
                          group x by x.IdSistema into g
                          select new
                          {
                              IdSistema = g.Key,
                              item = g.ToList()
                          }
                                ).ToList();*/
            //Agrega sistemas
            
                RadTreeNode nodeSistema = new RadTreeNode(sis.NombreSistema,sis.IdSistema.ToString());                
                nodeSistema.Category = "SISTEMA";
             /*   var modulos = (from x in sistem[i].item
                               group x by x.IdModulo into g
                               select new
                               {
                                   IdModulo = g.Key,
                                   item = g.ToList()
                               }
                                ).ToList();*/
                //Agregar modulos de sistema
                for (int j = 0; j < modulos.Count; j++)
                {
                    /*List<E.VMItemModulo> itemsAsignados = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerItemsRolAsignados(
                        Convert.ToInt32(hidIdRolPermisos.Value));*/
                    RadTreeNode nodeModulo = new RadTreeNode(modulos[j].Nombre /*modulos[j].item[0].Modulo*/, modulos[j].IdModulo.ToString() /* modulos[j].IdModulo.ToString()*/);
                    nodeModulo.Category = "MODULO";
                    TemplateNode template = new TemplateNode();
                    template.eventoAgregar = linkRegistrarPaginaModulo_Click;
                    template.eventoDetalles = linkDetalleModuloItem_Click;
                    template.eventoEditar = linkEditarModuloItem_Click;
                    template.eventoEliminar = linkEliminarModuloItem_Click;
                    
                    nodeModulo.NodeTemplate = template;
                    if (modulos[j].Items != null)
                    {
                        List<E.VMItemModulo> nodosHijos = (from x in modulos[j].Items
                                                           where x.IdItemPadre == 0
                                                           select x).ToList();

                        AgregarNodosHijos(nodeModulo,
                            nodosHijos
                            , 0,  modulos[j].Items.ToList());
                        nodeSistema.Nodes.Add(nodeModulo);

                    }
                }

                rtvModulos.Nodes.Add(nodeSistema);
            

            rtvModulos.DataBind();
            rtvModulos.ExpandAllNodes();
        }

        private void AgregarNodosHijos(RadTreeNode nodoPadre, List<E.VMItemModulo> modulosNodo, int nivel, List<E.VMItemModulo> itemsDisponibles)
        {
            foreach (E.VMItemModulo item in modulosNodo)
            {
                RadTreeNode rtnActual = null;
                if (nivel == 0 && item.IdItemPadre == 0)
                {
                    rtnActual = new RadTreeNode(item.Descripcion, item.IdItemModulo.ToString());
                }
                else if (nivel > 0)
                {
                    rtnActual = new RadTreeNode(item.Descripcion, item.IdItemModulo.ToString());
                }
                if (rtnActual != null)
                {
                    rtnActual.Category = "ITEM";
                    TemplateNode template = new TemplateNode();
                    template.eventoAgregar = linkRegistrarPaginaModulo_Click;
                    template.eventoDetalles = linkDetalleModuloItem_Click;
                    template.eventoEditar = linkEditarModuloItem_Click;
                    template.eventoEliminar = linkEliminarModuloItem_Click;
                    rtnActual.NodeTemplate = template;
                    nodoPadre.Nodes.Add(rtnActual);
                    //indica si esta asigando
                    //if (itemsAsignados.Where(x => x.IdItemModulo == Convert.ToInt32(rtnActual.Value)).FirstOrDefault() != null)
                    //{
                    //    rtnActual.Checked = true;
                    //}
                }

                List<E.VMItemModulo> nodosHijos = (from x in itemsDisponibles
                                                   where x.IdItemPadre == item.IdItemModulo
                                                   select x).ToList();

                AgregarNodosHijos(rtnActual, nodosHijos, ++nivel, itemsDisponibles);
            }
        }

        private void MostrarRegistroPagina()
        {
            btnRegistrarRegPagina.Text = "Registrar";            
            tbNombrePagina.Text = string.Empty;
            tbUrlDestinoPagina.Text = string.Empty;
            tbUrlIconoPagina.Text = string.Empty;
            tbOrdenPagina.Text = string.Empty;
            ddlEstatus.ClearSelection();
            mpePagina.Show();
        }


        private void MostrarRegistroModulo()
        {
            btnRegistrarRegModulo.Text = "Registrar";
            tbNombreModulo.Text = string.Empty;
            tbUrlDestino.Text = string.Empty;
            tbUrlIcono.Text = string.Empty;
            tbDbConexion.Text = string.Empty;
            tbToolTip.Text = string.Empty;
            tbOrden.Text = string.Empty;
            ddlEstatus.ClearSelection();            
            mpeModulo.Show();
        }

        private void MostraRegistroApp()
        {
            tbLogo.Text = string.Empty;
            tbUrlHome.Text = string.Empty;
            tbNombreApp.Text = string.Empty;
            chkAppExterna.Checked = false;
            hidIdApp.Value = string.Empty;
            ddlEstatus.ClearSelection();            
            mpeApp.Show();
        }

        private void MostraEdicionApp(int idSistema)
        {
            try
            {
                E.VMSistema sis = new NegocioAdmin(sistema.NOMBRE_USUARIO, sistema.PASS).ObtenerInformacionSistemas(idSistema);
                tbLogo.Text = sis.Logo;
                tbUrlHome.Text = sis.UrlHome;
                tbNombreApp.Text = sis.NombreSistema;
                chkAppExterna.Checked = !sis.Embebido;
                ddlEstatus.ClearSelection();
                ddlEstatus.FindItemByValue(sis.Activo?"true":"false").Selected=true;
                hidIdApp.Value = idSistema.ToString();
                mpeApp.Show();
            }
            catch (Exception ex)
            {
               Master.MostrarMensajeError("Error: " + ex.Message);
            }
        }

        private void MostrarModulos(int idSistema)
        {
            //Muestra modulos e items de la aplicacion
            try
            {
                NegocioAdmin negAdmin = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS);

                E.VMSistema sis = negAdmin.ObtenerInformacionSistemas(idSistema);
                List<E.VMRol> roles = negAdmin.ObtenerRoles(0);
                lblNomModuloSel.InnerText = sis.NombreSistema;
                hidIdApp.Value = idSistema.ToString();
                CargarArbolSistema(idSistema);
                rtvModulos.DataBind();
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "openWinModulo", "openWinModulo()", true);
            }
            catch (Exception ex)
            {
                Master.MostrarMensajeError(ex.Message);
            }

        }

        private string ValidarRegistroApp()
        {
            string error = string.Empty;
            if (string.IsNullOrEmpty(tbNombreApp.Text))
            {
                error += "- Indica el nombre de la aplicación <br />";
            }
            if (string.IsNullOrEmpty(tbLogo.Text))
            {
                error += "- Indica las iniciales de la aplicación <br />";
            }
            if (ddlEstatus.SelectedItem ==null)
            {
                error += "- Indica el estatus de la aplicación <br />";
            }

            return error;
            
        }

        private string ValidarRegistroModulo()
        {
            string error = string.Empty;
            if (string.IsNullOrEmpty(hidIdApp.Value))
            {
                error += "- Selecciona una aplicación <br />";
            }
            if (string.IsNullOrEmpty(tbNombreModulo.Text))
            {
                error += "- Indica el nombre del modulo <br />";
            }
            if (string.IsNullOrEmpty(tbOrden.Text))
            {
                error += "- Indica en que orden se mostrará el modulo <br />";
            }
            if (ddlEstatus.SelectedItem == null)
            {
                error += "- Indica el estatus del modulo <br />";
            }

            return error;

        }

        private string ValidarRegistroPagina()
        {
            string error = string.Empty;
            if (string.IsNullOrEmpty(hidIdModulo.Value))
            {
                error += "- Selecciona un modulo <br />";
            }
            if (string.IsNullOrEmpty(hidIdItemParent.Value))
            {
                error += "- Selecciona una página <br />";
            }
            if (string.IsNullOrEmpty(tbNombrePagina.Text))
            {
                error += "- Indica el nombre de la página <br />";
            }
            if (string.IsNullOrEmpty(tbOrdenPagina.Text))
            {
                error += "- Indica en que orden se mostrará la página <br />";
            }
            if (ddlEstatus.SelectedItem == null)
            {
                error += "- Indica el estatus del item <br />";
            }

            return error;

        }

        private void RegistrarApp()
        {
            string msj = ValidarRegistroApp();
            if (string.IsNullOrEmpty(msj))
            {
                try
                {
                    new NegocioAdmin(sistema.NOMBRE_USUARIO, sistema.PASS).RegistrarSistemas(
                        tbNombreApp.Text,
                        tbLogo.Text,
                        tbUrlHome.Text,
                        !chkAppExterna.Checked,
                        ddlEstatus.SelectedItem.Value=="true"
                        );
                    mpeApp.Hide();
                    LIST_APLICACIONES = null;
                    rgApps.Rebind();
                }
                catch (Exception ex)
                {
                    MostrarErrorReg("Error: "+ ex.Message);
                }
            }
            else
            {
                MostrarErrorReg(msj);
            }
        }

        private void RegistrarPagina()
        {
            string msj = ValidarRegistroPagina();
            if (string.IsNullOrEmpty(msj))
            {
                try
                {
                    new NegocioAdmin(sistema.NOMBRE_USUARIO, sistema.PASS).RegistrarPaginaModulo(
                        tbNombrePagina.Text,
                        Convert.ToInt32(hidIdModulo.Value),
                        tbUrlIconoPagina.Text,
                        tbUrlDestinoPagina.Text,
                        Convert.ToInt32(hidIdItemParent.Value),
                        Convert.ToInt32(tbOrdenPagina.Text),                        
                        ddlEstatus.SelectedItem.Value == "true"
                        );
                    mpePagina.Hide();
                    rtvModulos.Nodes.Clear();
                    CargarArbolSistema(Convert.ToInt32(hidIdApp.Value));
                }
                catch (Exception ex)
                {
                    MostrarErrorRegPagina("Error: " + ex.Message);
                }
            }
            else
            {
                MostrarErrorRegPagina(msj);
            }
        }

        private void RegistrarModulo()
        {
            string msj = ValidarRegistroModulo();
            if (string.IsNullOrEmpty(msj))
            {
                try
                {
                    new NegocioAdmin(sistema.NOMBRE_USUARIO, sistema.PASS).RegistrarModuloSistema(
                        tbNombreModulo.Text,
                        Convert.ToInt32(hidIdApp.Value),
                        tbUrlIcono.Text,
                        tbUrlDestino.Text,
                        tbDbConexion.Text,
                        ddlEstatus.SelectedItem.Value == "true"
                        );
                    mpeModulo.Hide();
                    rtvModulos.Nodes.Clear();
                    CargarArbolSistema(Convert.ToInt32(hidIdApp.Value));
                    
                }
                catch (Exception ex)
                {
                    MostrarErrorRegModulo("Error: " + ex.Message);
                }
            }
            else
            {
                MostrarErrorRegModulo(msj);
            }
        }

        private void EditarApp()
        {
            string msj = ValidarRegistroApp();
            if (string.IsNullOrEmpty(msj))
            {
                try
                {
                    new NegocioAdmin(sistema.NOMBRE_USUARIO, sistema.PASS).EditarSistemas(
                        Convert.ToInt32(hidIdApp.Value),
                        tbNombreApp.Text,
                        tbLogo.Text,
                        tbUrlHome.Text,
                        !chkAppExterna.Checked,
                        ddlEstatus.SelectedItem.Value == "true"
                        );
                    mpeApp.Hide();
                    LIST_APLICACIONES = null;
                    rgApps.Rebind();
                }
                catch (Exception ex)
                {
                    MostrarErrorReg("Error: " + ex.Message);
                }
            }
            else
            {
                MostrarErrorReg(msj);
            }
        }


        #endregion

        protected override void OnInit(EventArgs e)
        {
            TemplateNode template = new TemplateNode();
            template.eventoAgregar = linkRegistrarPaginaModulo_Click;
            template.eventoDetalles = linkDetalleModuloItem_Click;
            template.eventoEditar = linkEditarModuloItem_Click;
            template.eventoEliminar = linkEliminarModuloItem_Click;

            rtvModulos.NodeTemplate = template;
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ddlEstatus.ZIndex = 100101;
            ddlEstatusModulo.ZIndex = 100101;
            if (!IsPostBack)
            {
                Inicializar();
            }
            else
            {
                LimpiarErrorReg();
                LimpiarErrorModulo();
                LimpiarErrorRegModulo();
                LimpiarErrorRegPagina();
            }
        }

        
        protected void rgApps_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                switch (e.CommandName)
                {
                    case "CONFIGURAR_MODULOS":
                        MostrarModulos(Convert.ToInt32(item.GetDataKeyValue("IdSistema").ToString()));
                        break;
                    case "EDITAR":
                        MostraEdicionApp(Convert.ToInt32(item.GetDataKeyValue("IdSistema").ToString()));
                        break;
                }
            }   
        }

        protected void rgApps_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            rgApps.DataSource = LIST_APLICACIONES;
        }

        protected void btnNuevaApp_Click(object sender, EventArgs e)
        {            
            MostraRegistroApp();
        }

        protected void lknGridAcciones_Click(object sender, EventArgs e)
        {

        }

        protected void btnCancelarRegApp_Click(object sender, EventArgs e)
        {
            mpeApp.Hide();
        }

        protected void btnRegistrarRegApp_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hidIdApp.Value))
            {
                RegistrarApp();
            }
            else
            {
                EditarApp();
            }
        }

        protected void lknNuevoModulo_Click(object sender, EventArgs e)
        {
            MostrarRegistroModulo();
        }

        protected void btnCancelarRegModulo_Click(object sender, EventArgs e)
        {
            mpeModulo.Hide();
        }

        protected void btnRegistrarRegModulo_Click(object sender, EventArgs e)
        {
            RegistrarModulo();
        }

        protected void rtvModulos_NodeClick(object sender, RadTreeNodeEventArgs e)
        {
            var c = e.Node.Value;
        }

        public void linkDetalleModuloItem_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton lnk = (LinkButton)sender;
                RadTreeNode n = (RadTreeNode)lnk.Parent;
                string id = lnk.CommandArgument;
                switch (n.Category)
                {
                    case "MODULO":
                        break;
                    case "ITEM":
                        break;
                }
            }
            catch (Exception ex)
            {
                MostrarErrorModulo(ex.Message);
            }
           
        }

        public void linkEditarModuloItem_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton lnk = (LinkButton)sender;
                RadTreeNode n = (RadTreeNode)lnk.Parent;
                string id = lnk.CommandArgument;
                switch (n.Category)
                {
                    case "MODULO":
                        break;
                    case "ITEM":
                        break;
                }
            }
            catch (Exception ex)
            {
                MostrarErrorModulo(ex.Message);
            }
            
        }

        public void linkEliminarModuloItem_Click(object sender, EventArgs e)
        {
            try
            {            
                LinkButton lnk = (LinkButton)sender;
                RadTreeNode n = (RadTreeNode)lnk.Parent;
                string id = lnk.CommandArgument;
                switch (n.Category)
                {
                    case "MODULO":
                        break;
                    case "ITEM":
                        break;
                }
            }
            catch (Exception ex)
            {
                MostrarErrorModulo(ex.Message);
            }
            
        }

        public void linkRegistrarPaginaModulo_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton lnk = (LinkButton)sender;
                RadTreeNode n = (RadTreeNode)lnk.Parent;
                string id = lnk.CommandArgument;
                switch (n.Category)
                {
                    case "MODULO":
                        hidIdItemParent.Value = "0";
                        hidIdModulo.Value = n.Value;
                        break;
                    case "ITEM":
                        hidIdItemParent.Value = n.Value;
                        do
                        {
                            n = n.ParentNode;
                        }
                        while (n.Category != "MODULO");
                        hidIdModulo.Value = n.Value;

                        break;
                }
                MostrarRegistroPagina();
            }
            catch (Exception ex)
            {
                MostrarErrorModulo(ex.Message);
            }
            
        }

        protected void btnCancelarRegPagina_Click(object sender, EventArgs e)
        {
            mpePagina.Hide();
        }

        protected void btnRegistrarRegPagina_Click(object sender, EventArgs e)
        {
            RegistrarPagina();
        }
    
    }

    public class TemplateNode : ITemplate
    {
        public EventHandler eventoDetalles;
        public EventHandler eventoEliminar;
        public EventHandler eventoEditar;
        public EventHandler eventoAgregar;


        public void InstantiateIn(Control container)
        {            

            if (container is Telerik.Web.UI.RadTreeNode)
            {
                Telerik.Web.UI.RadTreeNode nodo = (Telerik.Web.UI.RadTreeNode)container;
                Label lblNombre = new Label();
                lblNombre.Text = nodo.Text;
                nodo.Controls.Add(lblNombre);

                if (nodo.Category != "SISTEMA")
                {
                    LinkButton lnkEditar = new LinkButton();
                    LinkButton lnkEliminar = new LinkButton();
                    LinkButton lnkDetalle = new LinkButton();
                    LinkButton lnkAddItem = new LinkButton();
                                        
                    
                    lnkEditar.ToolTip = "Editar";
                    lnkEditar.Text = "<i class='fa fa-pencil' aria-hidden='true'></i>";                    

                    lnkEliminar.Text = "<i class='fa fa-times' aria-hidden='true'></i>";
                    lnkEliminar.ToolTip = "Eliminar";

                    lnkDetalle.Text = "<i class='fa fa-eye' aria-hidden='true'></i>";
                    lnkDetalle.ToolTip = "Detalles";

                    lnkAddItem.Text = "<i class='fa fa-plus-circle' aria-hidden='true'></i>";
                    lnkAddItem.ToolTip = "Agregar página";

                    lnkDetalle.Click += new EventHandler(eventoDetalles);
                    lnkDetalle.DataBinding += new EventHandler(lkn_DataBinding);

                    lnkEditar.Click += new EventHandler(eventoEditar);
                    lnkEditar.DataBinding += new EventHandler(lkn_DataBinding);

                    lnkEliminar.Click += new EventHandler(eventoEliminar);
                    lnkEliminar.DataBinding += new EventHandler(lkn_DataBinding);

                    lnkAddItem.Click += new EventHandler(eventoAgregar);
                    lnkAddItem.DataBinding += new EventHandler(lkn_DataBinding);

                    

                    nodo.Controls.Add(lnkAddItem);
                    nodo.Controls.Add(lnkDetalle);
                    nodo.Controls.Add(lnkEditar);
                    nodo.Controls.Add(lnkEliminar);
                }
            }
        }

        private void lkn_DataBinding(object sender, EventArgs e)
        {
            LinkButton target = (LinkButton)sender;
            RadTreeNode node = (RadTreeNode)target.BindingContainer;
            string nodeValor = (string)DataBinder.Eval(node, "Value");
            target.CommandArgument = nodeValor;
            target.CssClass = "btn-accion-grid";
        }



    }

}
