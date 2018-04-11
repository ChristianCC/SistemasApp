using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

using E = Entidades.Serv_Admin;
using Negocio.MdSistema;
using System.Data;
using Telerik.Web.UI;
using SistemasApp.Common;




namespace SistemasApp.MdlAdmin
{
    public partial class Usuarios : System.Web.UI.Page
    {
        Sistema sistema = new Sistema();
        #region variables

        private int ID_PAGINA
        {
            get
            {
                return Convert.ToInt32(ConfigurationManager.AppSettings["MdlAdmin_Usuarios"]);
            }
        }
        
        private List<E.VMUsuario> DT_VIEW_USUARIOS
        {
            get
            {
                if (Session["DT_VIEW_USUARIOS"] == null)
                {
                    try
                    {
                        Session["DT_VIEW_USUARIOS"] =
                            new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerCatalogoUsuarios();
                    }
                    catch (Exception ex)
                    {
                        Master.MostrarMensajeError(ex.Message);
                    }
                }
                return Session["DT_VIEW_USUARIOS"] as List<E.VMUsuario>;
            }
            set
            {
                Session["DT_VIEW_USUARIOS"] = value;
            }
        }

        private List<E.VMRol> LIST_ROLES_SIS
        {
            get
            {
                if (Session["LIST_ROLES_SIS"] == null)
                {
                    try
                    {
                        List<E.VMRol> lista = new List<E.VMRol>();
                        if (ddlSistemas.SelectedItem != null)
                        {

                            lista = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerRoles(
                             Convert.ToInt32(ddlSistemas.SelectedItem.Value)
                            );
                        }
                        Session["LIST_ROLES_SIS"] = lista;
                    }
                    catch (Exception ex)
                    {
                        Master.MostrarMensajeError(ex.Message);
                    }
                }
                return Session["LIST_ROLES_SIS"] as List<E.VMRol>;
            }
            set
            {
                Session["LIST_ROLES_SIS"] = value;
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

        #region Plantillas
        class RolesUsuarioTemplate : ITemplate
        {
            public void InstantiateIn(Control container)
            {
                Table tblNode = new Table();

                tblNode.Rows.Add(ConfigurarRenglonPais());

                tblNode.Rows.Add(ConfigurarRenglonRol());

                container.Controls.Add(tblNode);
            }

            private TableRow ConfigurarRenglonRol()
            {
                TableRow trRol = new TableRow();
                TableCell tcExterna = new TableCell();
                Table interna = new Table();

                Label lbRol = new Label();
                Label lbDesc = new Label();
                //     Label lbUNeg = new Label();

                TableCell tc1 = new TableCell();
                TableCell tc2 = new TableCell();
                TableCell tc3 = new TableCell();

                TableRow tr1 = new TableRow();
                TableRow tr2 = new TableRow();
                TableRow tr3 = new TableRow();

                FontUnit tamFuente = new FontUnit(7.0, UnitType.Point);
                Unit ancho = new Unit(200, UnitType.Pixel);

                trRol.ID = "trRol";
                trRol.CssClass = "trRol";
                trRol.DataBinding += new EventHandler(trRol_DataBinding);

                tcExterna.ColumnSpan = 2;

                lbRol.ID = "lbRol";
                lbDesc.ID = "lbDesc";
                //   lbUNeg.ID = "lbUNeg";

                lbRol.Font.Size = tamFuente;
                lbDesc.Font.Size = tamFuente;
                //   lbUNeg.Font.Size = tamFuente;

                lbRol.Width = ancho;
                lbDesc.Width = ancho;
                //    lbUNeg.Width = ancho;
                trRol.Width = ancho;

                tc1.Controls.Add(lbRol);
                tc2.Controls.Add(lbDesc);
                //   tc3.Controls.Add(lbUNeg);

                tr1.Cells.Add(tc1);
                tr2.Cells.Add(tc2);
                tr3.Cells.Add(tc3);

                interna.Rows.Add(tr1);
                interna.Rows.Add(tr2);
                interna.Rows.Add(tr3);

                tcExterna.Controls.Add(interna);

                trRol.Cells.Add(tcExterna);

                return trRol;
            }

            private TableRow ConfigurarRenglonPais()
            {
                TableRow trPais = new TableRow();
                trPais.ID = "trPais";
                trPais.CssClass = "trPais";
                trPais.DataBinding += new EventHandler(trPais_DataBinding);

                Image imPais = new Image();
                imPais.ID = "imgPais";
                imPais.Width = new Unit(30.0, UnitType.Pixel);
                imPais.Height = new Unit(30.0, UnitType.Pixel);

                Label lbPais = new Label();
                lbPais.ID = "lbPais";
                lbPais.Font.Bold = true;
                lbPais.Font.Size = new FontUnit(12.0, UnitType.Point);

                TableCell tc1 = new TableCell();
                TableCell tc2 = new TableCell();

                tc1.Controls.Add(imPais);
                tc2.Controls.Add(lbPais);

                trPais.Cells.Add(tc1);
                trPais.Cells.Add(tc2);
                return trPais;
            }

            void trRol_DataBinding(object sender, EventArgs e)
            {
                TableRow target = (TableRow)sender;
                RadTreeNode node = (RadTreeNode)target.BindingContainer;

                if (node.Level > 0)
                {
                    Label lbRol = target.FindControl("lbRol") as Label;
                    Label lbDesc = target.FindControl("lbDesc") as Label;
                    // Label lbUNeg = target.FindControl("lbUNeg") as Label;
                    lbRol.Text = node.Text;
                    lbDesc.Text = node.Attributes["Descripcion"];
                    //lbUNeg.Text = node.Attributes["fcNombreUnidadNegocio"];
                }

                target.Visible = (node.Level > 0);
            }

            void trPais_DataBinding(object sender, EventArgs e)
            {
                TableRow target = (TableRow)sender;
                RadTreeNode node = (RadTreeNode)target.BindingContainer;

                if (node.Level == 0)
                {
                    Image imPais = target.FindControl("imgPais") as Image;
                    Label lbPais = target.FindControl("lbPais") as Label;

                    imPais.ImageUrl = "~/Assets/imgs/banderas/" + node.Value + ".png";
                    lbPais.Text = node.Text;
                }

                target.Visible = (node.Level == 0);

            }
        }
        #endregion

        #region metodos
        private void Inicializar()
        {
            LimpiarMemoria();
            // Craga lista de sistemas
            ddlSistemas.DataSource = LIST_SISTEMAS;
            ddlSistemasPermisos.DataSource = LIST_SISTEMAS;
            if (LIST_SISTEMAS != null)
            {
                ddlSistemas.DataValueField = "IdSistema";
                ddlSistemas.DataTextField = "NombreSistema";
                ddlSistemas.DataBind();

                ddlSistemasPermisos.DataValueField = "IdSistema";
                ddlSistemasPermisos.DataTextField = "NombreSistema";
                ddlSistemasPermisos.DataBind();
            }
            ConfigurarPermisos();            
        }

        /// <summary>
        /// Indica que opciones son visibles para este usuario
        /// </summary>
        protected void ConfigurarPermisos()
        {
            // Obtiene lospermisos para el usuario y rol actuales
            NegocioSistema negocioSis = new NegocioSistema(sistema.USR_LOGIN, sistema.PASS);
                
            E.VMPermisoItem permisos = negocioSis
                .ObtenerPermisosItemsUsuarioRol(sistema.USR_LOGIN,sistema.SISTEMA_ACTUAL.IdSistema,sistema.ROL_ACTUAL.IdRol,this.ID_PAGINA);
            if (permisos != null)
            { //Aplica permisos de editar o crear
                if (!permisos.Write)
                {                    
                }

               List<E.VMToolItem> permisosTools =  negocioSis.ObtenerPermisosToolsUsuario(permisos.IdUsuarioPermisos);
               if (permisosTools != null)
               {
                   //Busca que herramientas debe mostrar
                   foreach(E.VMToolItem tool in permisosTools )
                   {
                       if (!tool.Permitir)
                       {
                           switch (tool.IdTool)
                           {
                               case 1:
                                   btnNuevoUsuario.Visible = false;                    
                                   break;
                               case 3:
                                   //eliminar
                                   break;
                               case 4:
                                   RadMenuContextual.Items.FindItemByValue("EDITAR").Visible = false;
                                   break;
                               case 5:
                                   RadMenuContextual.Items.FindItemByValue("RESET").Visible = false;                                   
                                   break;
                               case 6:
                                   RadMenuContextual.Items.FindItemByValue("ROLES").Visible = false;                                   
                                   break;
                               case 7:
                                   RadMenuContextual.Items.FindItemByValue("PERMISOS").Visible = false; 
                                   break;
                           }
                       }
                   }
               }

            }
              

            
        }

        protected override void OnInit(EventArgs e)
        {
            rtvRolesDisponibles.NodeTemplate = new RolesUsuarioTemplate();
            rtvRolesAsignados.NodeTemplate = new RolesUsuarioTemplate();
            base.OnInit(e);
        }

        private void LimpiarMemoria()
        {
            DT_VIEW_USUARIOS = null;
            LIST_ROLES_SIS = null;            
        }

        private void LimpiarFormularioRegistro()
        {
            tbUsuario.Text = string.Empty;
            tbPass.Text = string.Empty;
            tbNombre.Text = string.Empty;
            tbApellidoM.Text = string.Empty;
            tbApellidoP.Text = string.Empty;
            tbCorreo.Text = string.Empty;
            tbCelualar.Text = string.Empty;
            tbExtension.Text = string.Empty;
        }

        private void LimpiarErrorRegistro()
        {
            pnlErrorReg.Visible = false;
            lblErrorReg.Text = string.Empty;
        }

        private void MostrarErrorRegistro(string error)
        {
            pnlErrorReg.Visible = true;
            lblErrorReg.Text = error;
        }

        private void MostrarErrorPermisos(string error)
        {
            pnlErrorWinPermisos.Visible = true;
            lblErrorWinPermisos.Text = error;
        }

        private void LimpiarErrorRoles()
        {
            pnlErrorWinRoles.Visible = false;
            lblErrorWinRoles.Text = string.Empty;
        }

        private void LimpiarErrorPermisos()
        {
            pnlErrorWinPermisos.Visible = false;
            lblErrorWinPermisos.Text = string.Empty;
        }

        private void MostrarErrorRoles(string error)
        {
            pnlErrorWinRoles.Visible = true;
            lblErrorWinRoles.Text = error;
        }

        private void ActualizarTablaUsuarios()
        {
            DT_VIEW_USUARIOS = null;
            rgUsuarios.Rebind();
        }

        private void RegistrarUsuario()
        {
            try
            {
                E.VMUsuario us = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).RegistrarUsuario(
                      tbNombre.Text,
                      tbApellidoM.Text,
                      tbApellidoP.Text,
                      tbCelualar.Text,
                      tbCorreo.Text,
                      tbExtension.Text,
                      1,
                      tbPass.Text,
                      tbUsuario.Text
                      );
                mpeUsuario.Hide();
                LimpiarFormularioRegistro();
                ActualizarTablaUsuarios();
            }
            catch (Exception ex)
            {
                MostrarErrorRegistro(ex.Message);
            }
        }

        private void MostrarPermisosAsignados(string usuarioSistema,bool open= false)
        {
            try
            {
                lblNomUsuarioSelPermisosItem.Text = usuarioSistema;                
                rgPermisos.DataSource = new NegocioSistema(sistema.USR_LOGIN, sistema.PASS).
                    ObtenerPermisosItemsUsuario(usuarioSistema/*Convert.ToBase64String(Tools.Encriptacion.Encriptar(usuarioSistema))*/,
                    Convert.ToInt32(ddlSistemasPermisos.SelectedItem.Value));
                rgPermisos.Rebind();
            }
            catch (Exception ex)
            {
                MostrarErrorPermisos("No es posible mostar los permisos asignados:" + ex.Message);
            }
            finally
            {
                if (open)
                { 
                  mpeUsuarioPermisos.Show();
                }
            }
            
        }

        private void ResetPass(string usuarioSistema)
        {
            try
            {
                new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).RestPassword(usuarioSistema);
                Master.MostrarMensaje("El registro es actualizo correctamente");
             
            }
            catch (Exception ex)
            {
                Master.MostrarMensajeError("No es posible modificar el registro:" + ex.Message);
            }            
        }

        private void VerHerramientasItem( int idUsuarioPermiso,CheckBoxList herramientas)
        {
            try
            {
                herramientas.Items.Clear();
                List<E.VMToolItem> tools = new NegocioSistema(sistema.USR_LOGIN, sistema.PASS).ObtenerPermisosToolsUsuario(idUsuarioPermiso);
                foreach(E.VMToolItem e in tools)
                {
                    ListItem i = new ListItem(e.Nombre, e.IdUsuarioPermisos+"-"+e.IdTool);
                    i.Selected = e.Permitir;                                        
                    herramientas.Items.Add(i);
                }
            }
            catch (Exception ex)
            {
                MostrarErrorPermisos("No es posible mostar las herramientas asignadas:" + ex.Message);
            }            
        }

        private void MostrarRolesAsignados(string usuarioSistema)
        {
            try
            {
                LIST_ROLES_SIS = null;                
                rtvRolesDisponibles.Nodes.Clear();
                rtvRolesAsignados.Nodes.Clear();
                //Roles disponibles
                List<E.VMRol> roles = LIST_ROLES_SIS;
                //Roles asignados
                List<E.VMRol> rolesAsignados = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerRolesUsuario(usuarioSistema,
                     Convert.ToInt32(ddlSistemas.SelectedItem.Value));

                var rolesDisponibles = (from x in roles
                                        group x by x.IdPais into rolPais
                                        select new
                                        {
                                            idPais = rolPais.Key,
                                            roles = rolPais.ToList()
                                        }).ToList();


                for (int i = 0; i < rolesDisponibles.Count(); i++)
                {
                    RadTreeNode nodoPais = new RadTreeNode(rolesDisponibles[i].roles[0].Pais, rolesDisponibles[i].idPais.ToString());
                    nodoPais.AllowDrag = false;
                    nodoPais.AllowDrop = false;

                    foreach (E.VMRol rol in rolesDisponibles[i].roles)
                    {
                        if (rolesAsignados.Where(x => x.IdRol == rol.IdRol).FirstOrDefault() == null)
                        {
                            RadTreeNode nodoItem = new RadTreeNode(rol.Nombre, rol.IdRol.ToString());
                            nodoItem.Attributes.Add("Descripcion", rol.Descripcion);
                            nodoItem.AllowDrag = true;
                            nodoItem.AllowDrop = true;
                            nodoPais.Nodes.Add(nodoItem);
                        }
                    }
                    if (nodoPais.Nodes.Count > 0)
                    {
                        rtvRolesDisponibles.Nodes.Add(nodoPais);
                    }
                }

                //Muestra roles asigandos               
                var rolesUsuario = (from x in rolesAsignados
                                    group x by x.IdPais into rolPais
                                    select new
                                    {
                                        idPais = rolPais.Key,
                                        roles = rolPais.ToList()
                                    }).ToList();


                for (int i = 0; i < rolesUsuario.Count(); i++)
                {
                    RadTreeNode nodoPais = new RadTreeNode(rolesUsuario[i].roles[0].Pais, rolesUsuario[i].idPais.ToString());
                    nodoPais.AllowDrag = false;
                    nodoPais.AllowDrop = false;

                    foreach (E.VMRol rol in rolesUsuario[i].roles)
                    {
                        RadTreeNode nodoItem = new RadTreeNode(rol.Nombre, rol.IdRol.ToString());
                        nodoItem.Attributes.Add("Descripcion", rol.Descripcion);
                        nodoItem.AllowDrag = true;
                        nodoItem.AllowDrop = true;
                        nodoPais.Nodes.Add(nodoItem);
                    }

                    rtvRolesAsignados.Nodes.Add(nodoPais);

                }


                rtvRolesDisponibles.ExpandAllNodes();
                rtvRolesDisponibles.DataBind();

                rtvRolesAsignados.ExpandAllNodes();
                rtvRolesAsignados.DataBind();


                lblNomUsuarioSel.InnerText = usuarioSistema;
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "openWinRoles", "openWinRoles()", true);
            }
            catch (Exception ex)
            {
                MostrarErrorRoles(ex.Message);
            }
        }

        private void GestionarRolDeUsuario(RadTreeNode rol, bool esAlta)
        {
            try
            {
                int idRol = Convert.ToInt32(rol.Value);
                int idPais = Convert.ToInt32(rol.ParentNode.Value);
                if (esAlta)
                {
                    new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).AsignarRolUsuario(
                         idRol, 
                         lblNomUsuarioSel.InnerText 
                        );
                }
                else
                {
                    new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).EliminarRolUsuario(
                        idRol, 
                        lblNomUsuarioSel.InnerText
                        );
                }
                MostrarRolesAsignados(lblNomUsuarioSel.InnerText);
            }
            catch (Exception ex)
            {
                MostrarErrorRoles(ex.Message);
            }
        }



        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {   
            ddlSistemasPermisos.ZIndex = 100101;
            if (IsPostBack)
            {
                LimpiarErrorRegistro();
                LimpiarErrorRoles();                
                LimpiarErrorPermisos();
                
                
            }
            else
            {
                Inicializar();
                

            }
        }

        protected void rgUsuarios_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            rgUsuarios.DataSource = DT_VIEW_USUARIOS;
        }

        protected void btnNuevoUsuario_Click(object sender, EventArgs e)
        {
            btnRegistrar.Text = "Registrar";
            tbUsuario.Visible = true;
            lbUsuario.Visible = true;
            lbPass.Visible = true;
            tbPass.Visible = true;
            tbEstatus.SelectedValue = "1";

            lbFechaVencimiento.Visible = false;
            tbFechaDeVencimiento.Visible = false;
            RadAjaxPanel1.Visible = false;

            mpeUsuario.Show();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpiarFormularioRegistro();
            mpeUsuario.Hide();
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                if (btnRegistrar.Text == "Actualizar")
                {
                    string idUsuario = rgUsuarios.MasterTableView.GetSelectedItems()[0].GetDataKeyValue("Usuario_sistema").ToString();
                    EditarUsuario(idUsuario);
                }
                else if (btnRegistrar.Text == "Registrar")
                {
                    RegistrarUsuario();
                }
            } 
            catch (Exception ex)
            {
                Master.MostrarMensajeError(ex.Message);
            }
        }

        protected void RadMenuContextual_ItemClick(object sender, RadMenuEventArgs e)
        {
            try
            {
                if (e.Item.Value.Equals("ROLES"))
                {
                    string idUsuario = rgUsuarios.MasterTableView.GetSelectedItems()[0].GetDataKeyValue("Usuario_sistema").ToString();
                    MostrarRolesAsignados(idUsuario);
                }
                else if (e.Item.Value.Equals("PERMISOS"))
                {
                    string idUsuario = rgUsuarios.MasterTableView.GetSelectedItems()[0].GetDataKeyValue("Usuario_sistema").ToString();
                    MostrarPermisosAsignados(idUsuario,true);
                }
                else if (e.Item.Value.Equals("RESET"))
                {
                    string idUsuario = rgUsuarios.MasterTableView.GetSelectedItems()[0].GetDataKeyValue("Usuario_sistema").ToString();
                    ResetPass(idUsuario);
                }
                else if (e.Item.Value.Equals("EDITAR"))
                {
                    string idUsuario = rgUsuarios.MasterTableView.GetSelectedItems()[0].GetDataKeyValue("Usuario_sistema").ToString();
                    GetInfoUsuario(idUsuario);
                }
            }
            catch (Exception ex)
            {
                Master.MostrarMensajeError(ex.Message);
            }
        }

        protected void rtvRolesDisponibles_NodeDrop(object sender, RadTreeNodeDragDropEventArgs e)
        {
            //if (e.DestDragNode.ParentNode.Value == e.SourceDragNode.ParentNode.Value)
            //{
            //    foreach (RadTreeNode nodo in e.DestDragNode.ParentNode.Nodes)
            //    {
            //        GestionarRolDeUsuario(nodo, false);
            //    }
            //}
            //else //busca
            if (e.DestDragNode!=null)
            {
                RadTreeNodeCollection nodos = e.DestDragNode.ParentNode.TreeView .Nodes;
                for (int i = 0; i < nodos.Count; i++)
                {
                    if (nodos[i].Value == e.SourceDragNode.ParentNode.Value)
                    {
                        foreach (RadTreeNode nodo in nodos[i].Nodes)
                        {
                            GestionarRolDeUsuario(nodo, false);
                        }
                    }
                }

            }

            GestionarRolDeUsuario(e.DraggedNodes[0], true);
        }

        protected void rtvRolesAsignados_NodeDrop(object sender, RadTreeNodeDragDropEventArgs e)
        {
            GestionarRolDeUsuario(e.DraggedNodes[0], false);
        }

        protected void chkDeleteWrite_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            if (chk.Parent.Parent is GridDataItem)
            {
                try
                {
                    GridDataItem obj = chk.Parent.Parent as GridDataItem;
                    CheckBox chkDelete = (CheckBox)obj.Cells[4].FindControl("chkDelete");
                    CheckBox chkWrite = (CheckBox)obj.Cells[3].FindControl("chkWrite");

                    string id = chk.Attributes["data-id"];
                    new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).AsignarPermisosItems(
                        Convert.ToInt32(id),
                        chkWrite.Checked,
                        chkDelete.Checked
                        );
                }
                catch (Exception ex)
                {
                    MostrarErrorPermisos("No fue posible asignar los permisos:" + ex.Message);
                }
            }
        }
                        
        protected void rgPermisos_ItemCommand(object source, GridCommandEventArgs e)
        {
            
            if (e.Item is GridDataItem)
            {
                if (e is GridExpandCommandEventArgs)
                {
                    GridDataItem item = (GridDataItem)e.Item;                    
                    if (!item.Expanded)
                    {
                        var obj = item.ChildItem.FindControl("checkHerramientas");
                        if (obj != null)
                        {
                            CheckBoxList herramientas = (CheckBoxList)obj;
                            VerHerramientasItem(Convert.ToInt32(item.GetDataKeyValue("IdUsuarioPermisos").ToString()), herramientas);
                        }
                    }
                    
                }
                else
                {
                    switch (e.CommandName)
                    {
                        case "HERRAMIENTAS":
                            GridDataItem item = (GridDataItem)e.Item;
                            item.Expanded = !item.Expanded;
                            if (item.Expanded)
                            {
                                var obj = item.ChildItem.FindControl("checkHerramientas");
                                if (obj != null)
                                {
                                    CheckBoxList herramientas = (CheckBoxList)obj;
                                    VerHerramientasItem(Convert.ToInt32(item.GetDataKeyValue("IdUsuarioPermisos").ToString()), herramientas);
                                }
                            }
                            break;
                    }
                }
            }            
            
            
        }

        protected void btnCancelarPermisos_Click(object sender, EventArgs e)
        {
            mpeUsuarioPermisos.Hide();
        }

        protected void lknPermitirTodo_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioAdmin negAdmin = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS);
                List<E.VMPermisoItem> permisos = new NegocioSistema(sistema.USR_LOGIN, sistema.PASS).
                    ObtenerPermisosItemsUsuario(lblNomUsuarioSelPermisosItem.Text,/*Convert.ToBase64String(Tools.Encriptacion.Encriptar(lblNomUsuarioSelPermiso.InnerText))*/
                    Convert.ToInt32(ddlSistemasPermisos.SelectedItem.Value));
                for (int i = 0; i < permisos.Count; i++)
                {
                    permisos[i].Delete = true;
                    permisos[i].Write = true;
                    negAdmin.AsignarPermisosItems(
                    permisos[i].IdUsuarioPermisos,
                    permisos[i].Write,
                    permisos[i].Delete
                    );
                }
                rgPermisos.DataSource = permisos;
                rgPermisos.DataBind();

            }
            catch (Exception ex)
            {
                MostrarErrorPermisos("No fue posible asignar los permisos:" + ex.Message);
            }
            
        }

        protected void lknDenegarTodo_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioAdmin negAdmin = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS);
                List<E.VMPermisoItem> permisos = new NegocioSistema(sistema.USR_LOGIN, sistema.PASS).
                    ObtenerPermisosItemsUsuario(lblNomUsuarioSelPermisosItem.Text/*Convert.ToBase64String(Tools.Encriptacion.Encriptar(lblNomUsuarioSelPermiso.InnerText))*/,
                     Convert.ToInt32(ddlSistemasPermisos.SelectedItem.Value));
                for(int i=0; i<permisos.Count;i++)
                {
                    permisos[i].Delete = false;
                    permisos[i].Write = false;
                    negAdmin.AsignarPermisosItems(
                    permisos[i].IdUsuarioPermisos,
                    permisos[i].Write,
                    permisos[i].Delete
                    );
                }
                rgPermisos.DataSource = permisos;
                rgPermisos.DataBind();

            }
            catch (Exception ex)
            {
                MostrarErrorPermisos("No fue posible asignar los permisos:" + ex.Message);
            }
        }

        protected void checkHerramientas_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                CheckBoxList lista =((CheckBoxList)sender);
                foreach (ListItem item in lista.Items)
                {

                    string[] data = item.Value.Split('-');
                    if (data.Length == 2)
                    {
                        new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).AsignarPermisosToolItems(
                            Convert.ToInt32(data[0]),
                            Convert.ToInt32(data[1]),
                            item.Selected
                            );
                    }

                }
            }
            catch(Exception ex)
            {
                MostrarErrorPermisos(ex.Message);
            }
        
        }


        protected void ddlSistemas_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
        {            
            MostrarRolesAsignados(lblNomUsuarioSel.InnerText);            
        }
       

        /*mvg 06-12-2017*/
        /*Se agerga para edicion de usuarios*/
        private void GetInfoUsuario(string usuarioSistema)
        {
            try
            {
                btnRegistrar.Text = "Actualizar";
                E.VMUsuario us = new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).ObtenerInfoUsuario(usuarioSistema);

                tbUsuario.Visible = false;
                lbUsuario.Visible = false;
                lbPass.Visible = false;
                tbPass.Visible = false;

                lbFechaVencimiento.Visible = true;
                tbFechaDeVencimiento.Visible = true;
                RadAjaxPanel1.Visible = true;


                tbApellidoM.Text    = us.Apellido_materno;
                tbApellidoP.Text    = us.Apellido_paterno;
                tbCelualar.Text     = us.Celular;
                tbCorreo.Text       = us.Correo;
                tbExtension.Text    = us.Extension;
                tbNombre.Text       = us.Nombre;
                DateTime _fecha = Convert.ToDateTime(us.FechaDeVencimiento);
                tbFechaDeVencimiento.Text = _fecha.ToShortDateString();
                tbEstatus.SelectedValue = us.IdEstatus.ToString();

                RadCalendar1.SelectedDate = _fecha;
                RadCalendar1.Focus();
                RadCalendar1.FocusedDate = _fecha;
                
                mpeUsuario.Show();
            }
            catch (Exception ex)
            {
                Master.MostrarMensajeError("No es posible modificar el registro:" + ex.Message);
            }
        }

        protected void RadCalendar1_SelectionChanged(object sender, Telerik.Web.UI.Calendar.SelectedDatesEventArgs e)
        {
            tbFechaDeVencimiento.Text = RadCalendar1.SelectedDate.ToShortDateString();
        }

        private void EditarUsuario(string usuario_sistema)
        {
            try
            {
                E.VMUsuario usuario = new E.VMUsuario();
                usuario.Nombre = tbNombre.Text;
                usuario.Apellido_paterno = tbApellidoP.Text;
                usuario.Apellido_materno = tbApellidoM.Text;
                usuario.Correo = tbCorreo.Text;
                usuario.Celular = tbCelualar.Text;
                usuario.Extension = tbExtension.Text;
                usuario.FechaDeVencimiento =Convert.ToDateTime(tbFechaDeVencimiento.Text);
                usuario.Usuario_sistema = usuario_sistema;
                usuario.IdEstatus = Convert.ToInt16(tbEstatus.SelectedItem.Value);

                new NegocioAdmin(sistema.USR_LOGIN, sistema.PASS).EditarUsuario(usuario);

                LimpiarFormularioRegistro();
                ActualizarTablaUsuarios();
                mpeUsuario.Hide();
            }
            catch (Exception ex)
            {
                MostrarErrorRegistro(ex.Message);
            }
        }

        protected void ddlSistemasPermisos_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            MostrarPermisosAsignados(lblNomUsuarioSelPermisosItem.Text);    
        }

    }
}