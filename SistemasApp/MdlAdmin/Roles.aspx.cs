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

namespace SistemasApp.MdlAdmin
{
    public partial class Roles : System.Web.UI.Page
    {
        Sistema sistema = new Sistema();
        #region variables
        private List<E.VMRol> LIST_ROLES
        {
            get
            {
                if (Session["LIST_ROLES"] == null)
                {
                    try
                    {
                        List<E.VMRol> lista = new List<E.VMRol>();
                     if(ddlSistemas.SelectedItem != null)
                     {
                        
                            lista = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerRoles(
                             Convert.ToInt32(ddlSistemas.SelectedItem.Value)
                            );
                     }
                     Session["LIST_ROLES"] = lista;
                    }
                    catch (Exception ex)
                    {
                        Master.MostrarMensajeError(ex.Message);
                    }
                }
                return Session["LIST_ROLES"] as List<E.VMRol>;
            }
            set
            {
                Session["LIST_ROLES"] = value;
            }
        }

        private List<E.VMPais> LIST_PAISES
        {
            get
            {
                if (Session["LIST_PAISES"] == null)
                {
                    try
                    {
                        Session["LIST_PAISES"] =
                            new NegocioSistema(sistema.USR_LOGIN, sistema.PASS).ObtenerListaPaises();
                    }
                    catch (Exception ex)
                    {
                        Master.MostrarMensajeError(ex.Message);
                    }
                }
                return Session["LIST_PAISES"] as List<E.VMPais>;
            }
            set
            {
                Session["LIST_PAISES"] = value;
            }
        }

        private List<E.VMItemModulo> LIST_ITEMS
        {
            get
            {
                if (Session["LIST_ITEMS"] == null)
                {
                    try
                    {
                        Session["LIST_ITEMS"] =
                            new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerItemsSistema();
                    }
                    catch (Exception ex)
                    {
                        Master.MostrarMensajeError(ex.Message);
                    }
                }
                return Session["LIST_ITEMS"] as List<E.VMItemModulo>;
            }
            set
            {
                Session["LIST_ITEMS"] = value;
            }
        }

        private List<E.VMSistema> LIST_SISTEMAS
        {
            get
            {                
                try
                {
                    return 
                        new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerCatalogoSistemas();
                }
                catch (Exception ex)
                {
                    Master.MostrarMensajeError(ex.Message);
                    return null;
                }
                
            }           
        }

        #endregion

        #region metodos
        private void LimpiarMemoria()
        {
            LIST_ROLES = null;
            LIST_PAISES = null;
            LIST_ITEMS = null;
        }

        private void EditarRol(int idRol)
        {
        }

        private void EliminarRol(int idRol)
        {
        }

        private void AgregarNodosHijos(RadTreeNode nodoPadre, List<E.VMItemModulo> modulosNodo, int nivel, List<E.VMItemModulo> itemsDisponibles, List<E.VMItemModulo> itemsAsignados)
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
                    nodoPadre.Nodes.Add(rtnActual);
                    //indica si esta asigando
                    if (itemsAsignados.Where(x => x.IdItemModulo == Convert.ToInt32(rtnActual.Value)).FirstOrDefault() != null)
                    {
                        rtnActual.Checked = true;
                    }
                }

                //List<E.VMItemModulo> nodosHijos = (from x in modulosNodo
                //                                        where x.IdItemPadre == item.IdItemModulo
                //                                        select x).ToList();

                List<E.VMItemModulo> nodosHijos = (from x in itemsDisponibles
                                                   where x.IdItemPadre == item.IdItemModulo
                                                   select x).ToList();

                AgregarNodosHijos(rtnActual, nodosHijos, ++nivel, itemsDisponibles, itemsAsignados);
            }
        }

        //private void CargarArbolSistemas()
        //{
        //    rtvModulos.Nodes.Clear();
        //    LIST_ITEMS = null;
        //    List<E.VMItemModulo> items = LIST_ITEMS;
        //    var sistem = (from x in items
        //                    group x by x.IdSistema into g
        //                    select new
        //                    {
        //                        IdSistema = g.Key,
        //                        item = g.ToList()
        //                    }
        //                        ).ToList();
        //    //Agrega sistemas
        //    for (int i = 0; i < sistem.Count; i++)
        //    {
        //        RadTreeNode nodeSistema = new RadTreeNode(sistem[i].item[0].Sistema, sistem[i].IdSistema.ToString());
        //        nodeSistema.Category = "SISTEMA";
        //        var modulos = (from x in sistem[i].item
        //                       group x by x.IdModulo into g
        //                       select new
        //                       {
        //                           IdModulo = g.Key,
        //                           item = g.ToList()
        //                       }
        //                        ).ToList();
        //        //Agregar modulos de sistema
        //        for (int j = 0; j < modulos.Count; j++)
        //        {
        //            List<E.VMItemModulo> itemsAsignados = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerItemsRolAsignados(
        //                Convert.ToInt32(hidIdRolPermisos.Value) );
        //            RadTreeNode nodeModulo = new RadTreeNode(modulos[j].item[0].Modulo, modulos[j].IdModulo.ToString());
        //            nodeModulo.Category = "MODULO";
        //            AgregarNodosHijos(nodeModulo, modulos[j].item, 0, itemsAsignados);
        //            nodeSistema.Nodes.Add(nodeModulo);

        //        }

        //        rtvModulos.Nodes.Add(nodeSistema);
        //    }

        //    rtvModulos.DataBind();
        //    rtvModulos.ExpandAllNodes();
        //}

        private void CargarArbolSistema(int idSistema)
        {
            NegocioAdmin negAdmin = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS);
            rtvModulos.Nodes.Clear();
            E.VMSistema sis = negAdmin.ObtenerInformacionSistemas(idSistema);
            List<E.VMModulo> modulos = negAdmin.ObtenerModulosSistema(idSistema,true);//solo activos


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

            RadTreeNode nodeSistema = new RadTreeNode(sis.NombreSistema, sis.IdSistema.ToString());
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
                List<E.VMItemModulo> itemsAsignados = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerItemsRolAsignados(
                        Convert.ToInt32(hidIdRolPermisos.Value));
                RadTreeNode nodeModulo = new RadTreeNode(modulos[j].Nombre /*modulos[j].item[0].Modulo*/, modulos[j].IdModulo.ToString() /* modulos[j].IdModulo.ToString()*/);
                nodeModulo.Category = "MODULO";
                ////AgregarNodosHijos(nodeModulo, modulos[j].item, 0, itemsAsignados);
                //nodeSistema.Nodes.Add(nodeModulo);


                //nodeModulo.NodeTemplate = template;
                if (modulos[j].Items != null)
                {
                    List<E.VMItemModulo> nodosHijos = (from x in modulos[j].Items
                                                       where x.IdItemPadre == 0
                                                       select x).ToList();

                    AgregarNodosHijos(nodeModulo,
                        nodosHijos
                        , 0, modulos[j].Items.ToList(),itemsAsignados);
                    nodeSistema.Nodes.Add(nodeModulo);

                }
            }

            rtvModulos.Nodes.Add(nodeSistema);


            rtvModulos.DataBind();
            rtvModulos.ExpandAllNodes();
        }

        private void MostrarErrorReg(string error)
        {
            pnlErrorRegRol.Visible = true;
            lblErrorRegRol.Text = error;
        }

        private void LimpiarErrorReg()
        {
            pnlErrorRegRol.Visible = false;
            lblErrorRegRol.Text = string.Empty;
        }

        private void MostrarErrorRegItem(string error)
        {
            pnlErrorWinNodos.Visible = true;
            lblErrorWinNodos.Text = error;
        }

        private void LimpiarErrorRegItem()
        {
            pnlErrorWinNodos.Visible = false;
            lblErrorWinNodos.Text = string.Empty;
        }

        private void RegistrarRol()
        {
            string error = string.Empty;
            if (string.IsNullOrEmpty(tbNombre.Text))
            {
                error += "- Ingresa un nombre para este Rol <br />";
            }
            if (string.IsNullOrEmpty(tbDescripcion.Text))
            {
                error += "- Ingresa la descripción para este rol. <br />";
            }
            if (string.IsNullOrEmpty(error))
            {
                try
                {
                    new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).RegistrarRol(
                        tbNombre.Text, tbDescripcion.Text,
                        Convert.ToInt32(ddlPais.SelectedItem.Value));
                    mpeRol.Hide();
                    LIST_ROLES = null;
                    rgRoles.Rebind();
                }
                catch (Exception ex)
                {
                    MostrarErrorReg(ex.Message);
                }
            }
            else
            {
                MostrarErrorReg(error);
            }


        }

        private string AsignarItemRol(string idRol, string idItem, RadTreeNode nodo)
        {
            string error = string.Empty;
            try
            {
                if (nodo.Category == "ITEM")
                {
                    int IdRol = Convert.ToInt32(idRol);
                    int IdItem = Convert.ToInt32(idItem);
                    if (!nodo.Checked)
                    {
                        new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).AsignarRolItem(
                             IdRol ,
                             IdItem);
                    }
                    else
                    {
                        new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).EliminarRolItem(IdRol, IdItem);
                    }
                }
                if (nodo.Nodes.Count > 0)
                {
                    foreach (RadTreeNode nod in nodo.Nodes)
                    {
                        error += AsignarItemRol(idRol, nod.Value, nod);
                    }
                }
                return string.Empty;

            }
            catch (Exception ex)
            {
                return ex.Message + " <br />";
            }
        }

        private void LimpiarFormRegRol()
        {
            tbNombre.Text = string.Empty;
            tbDescripcion.Text = string.Empty;
            ddlPais.DataSource = LIST_PAISES;
            ddlPais.DataValueField = "IdPais";
            ddlPais.DataTextField = "Nombre";
            ddlPais.DataBind();
            ddlPais.ZIndex = 100101;
        }

        private void MostrarPermisosRol()
        {
            try
            {
                List<E.VMRol> roles = LIST_ROLES;
                lblNomRolSel.InnerText = (from x in roles
                                          where x.IdRol == Convert.ToInt32(hidIdRolPermisos.Value)
                                          select
                                           x.Nombre).FirstOrDefault();

                CargarArbolSistema(Convert.ToInt32(ddlSistemas.SelectedItem.Value));
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "openWinMapeo", "openWinMapeo()", true);
            }
            catch (Exception ex)
            {
                Master.MostrarMensajeError(ex.Message);
            }
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                LimpiarErrorReg();
                LimpiarErrorRegItem();                
            }
            else
            {
                LimpiarMemoria();
                // Craga lista de sistemas
                ddlSistemas.DataSource = LIST_SISTEMAS;
                if (LIST_SISTEMAS != null)
                {
                    ddlSistemas.DataValueField = "IdSistema";
                    ddlSistemas.DataTextField = "NombreSistema";
                    ddlSistemas.DataBind();
                }
            }
        }

        protected void rgRoles_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            rgRoles.DataSource = LIST_ROLES;
        }

        protected void rgRoles_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                switch (e.CommandName)
                {
                    case "ELIMINAR":
                        EliminarRol(Convert.ToInt32(item.GetDataKeyValue("IdRol").ToString()));
                        break;
                    case "EDITAR":
                        EditarRol(Convert.ToInt32(item.GetDataKeyValue("IdRol").ToString()));
                        break;
                }
            }
        }

        protected void btnCancelarRegRol_Click(object sender, EventArgs e)
        {
            mpeRol.Hide();
        }

        protected void btnRegistrarRegRol_Click(object sender, EventArgs e)
        {
            RegistrarRol();
        }

        protected void btnNuevoRol_Click(object sender, EventArgs e)
        {
            LimpiarFormRegRol();
            mpeRol.Show();
        }

        protected void lknGridEditar_Click(object sender, EventArgs e)
        {
        }

        protected void lknGridAccesos_Click(object sender, EventArgs e)
        {
            hidIdRolPermisos.Value = ((LinkButton)sender).CommandArgument;
            MostrarPermisosRol();
        }

        protected void rtvModulos_NodeCheck(object sender, RadTreeNodeEventArgs e)
        {
            string error = AsignarItemRol(hidIdRolPermisos.Value,
                e.Node.Value, e.Node);
            if (!string.IsNullOrEmpty(error))
            {
                MostrarErrorRegItem(error);
            }
            else
            {
                CargarArbolSistema(Convert.ToInt32(ddlSistemas.SelectedItem.Value));
            }
        }

        protected void ddlSistemas_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LIST_ROLES = null;
            rgRoles.Rebind();
        }

        
    }
}