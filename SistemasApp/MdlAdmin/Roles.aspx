<%@ Page Title="" Language="C#" MasterPageFile="~/MdlAdmin/Shared/AdminMaster.master" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="SistemasApp.MdlAdmin.Roles" %>
<%@ MasterType VirtualPath="~/MdlAdmin/Shared/AdminMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpTituloPagina" runat="server">
    Roles de usuario
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpDescripcion" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cpContenidoPrincipal" runat="server">
    <div class="row">
       <div class="col-xs-12">
           <asp:UpdatePanel ID="upRgRoles" runat="server">
                <ContentTemplate>
                    <div class="tool-header-grid-titulo" >
                        <div >         
                            <asp:LinkButton runat="server" ID="btnNuevoRol"  CssClass="btn"  OnClick="btnNuevoRol_Click" >
                                <i class="fa  fa-plus-square fa-lg"></i>&nbsp; Nuevo Rol                                     
                            </asp:LinkButton>                            
                        </div>
                        <div >
                            <label >Roles registrados en el sistema </label>
                            <tlk:RadComboBox ID="ddlSistemas" runat="server" EnableEmbeddedSkins="true" Skin="WebBlue"
                                OnSelectedIndexChanged="ddlSistemas_SelectedIndexChanged" AutoPostBack="true" >

                            </tlk:RadComboBox>
                            <asp:HiddenField ID="hidIdRolPermisos" runat="server"  />
                        </div>
                    </div> 
                    <tlk:RadGrid ID="rgRoles" runat="server"
                        OnNeedDataSource="rgRoles_NeedDataSource"    
                        OnItemCommand="rgRoles_ItemCommand"                                                            
                        EnableEmbeddedSkins="true" Skin="WebBlue"
                        Width="100%">
                        <MasterTableView                        
                            AutoGenerateColumns="false"
                            DataKeyNames="Nombre,Descripcion,IdPais,Pais,Activo,IdRol"
                            AllowPaging="true"
                            PageSize="20"
                            Width="100%"                    
                            NoMasterRecordsText="No existen Roles registrados.">
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                            <AlternatingItemStyle HorizontalAlign="Center" VerticalAlign="Top" />                        
                            <Columns>                            
                                <tlk:GridBoundColumn DataField="Nombre" HeaderText="Nombre">
                                    <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" Width="150px" />
                                    <ItemStyle  Width="150px"  CssClass="hidden-overflow"  />                                
                                </tlk:GridBoundColumn>                            
                                <tlk:GridBoundColumn DataField="Descripcion" HeaderText="Descripción">
                                    <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center"  Width="150px" />
                                    <ItemStyle  Width="150px" CssClass="hidden-overflow" />
                                </tlk:GridBoundColumn>                                                                
                                <tlk:GridTemplateColumn HeaderText="Estatus" >
                                    <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center"   Width="150px" />  
                                    <ItemStyle  Width="150px" CssClass="hidden-overflow" />
                                    <ItemTemplate >                                    
                                       <asp:Label ID="tblEdo" runat="server" Text='<%# (bool)DataBinder.Eval(Container.DataItem, "Activo")==true?"Activo":"Inactivo" %>'></asp:Label> 
                                    </ItemTemplate>                              
                                </tlk:GridTemplateColumn>                                                                  
                                <tlk:GridTemplateColumn HeaderText="Configuración" >
                                    <HeaderStyle Width="100px" />
                                    <ItemStyle  Width="150px" CssClass="hidden-overflow" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lknGridEditar" runat="server" OnClick="lknGridEditar_Click"  CommandName="EDITAR_ROL" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "IdRol")%>' ToolTip="Editar rol de acceso" >
                                            <i class="fa fa-pencil" aria-hidden="true"></i>&nbsp;&nbsp;                                            
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lknGridAccesos" runat="server" OnClick="lknGridAccesos_Click"  CommandName="CONFIGURAR_ACCESOS" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "IdRol")%>' ToolTip="Configurar accesos al sistema"  >
                                            <i class="fa fa-sitemap" aria-hidden="true"></i>&nbsp;&nbsp;
                                        </asp:LinkButton>                                        
                                    </ItemTemplate>
                                </tlk:GridTemplateColumn>
                                <%--<tlk:GridButtonColumn Text='<i class="fa fa-pencil" aria-hidden="true"></i>' HeaderText="Editar" CommandName="EDITAR" > 
                                    <HeaderStyle Width="100px" />
                                    <ItemStyle ForeColor="#597790"  Width="100px" CssClass="hidden-overflow"  />
                                </tlk:GridButtonColumn>--%>
                                <tlk:GridButtonColumn Text='<i class="fa fa-times" aria-hidden="true"></i>' HeaderText="Eliminar" CommandName="ELIMINAR"
                                    ConfirmDialogType="RadWindow" ConfirmTitle="Alerta"
                                    ConfirmText="¿Segur@ quieres dar de baja este rol?" > 
                                    <HeaderStyle Width="100px" />
                                    <ItemStyle ForeColor="#dd4b39"  Width="100px" CssClass="hidden-overflow"  />
                                </tlk:GridButtonColumn>    
                            </Columns>                  
                        </MasterTableView>
                        <ClientSettings>
                            <Scrolling AllowScroll="true" ScrollHeight="100%" UseStaticHeaders="true" />                        
                        </ClientSettings>
                    </tlk:RadGrid>                
                </ContentTemplate>    
               <Triggers>
                   <asp:AsyncPostBackTrigger ControlID="rtvModulos" />
               </Triggers>           
            </asp:UpdatePanel>
       </div>
   </div>

    <!-- ------------------ Ventana items sistema -------------------------------- -->
    
    <asp:UpdatePanel ID="upWinNodos" runat="server" style="display:none;">
         <ContentTemplate>    
            <asp:Panel ID="pnlNodos" runat="server" title="Destinos del sistema" >       
                <asp:Panel ID="pnlErrorWinNodos" runat="server" >
                        <div class="callout callout-danger lead">                                
                            <asp:Label ID="lblErrorWinNodos" runat="server" style="font-size: small;" ></asp:Label>
                        </div>
                </asp:Panel>                            
                <div class="tool-header-grid-titulo" >
                    <div >                                              
                    </div>
                    <div >                
                        <label >Mapa de accesos al sistema para le rol <span id="lblNomRolSel" runat="server"></span> </label>                                        
                    </div>
                </div>
                <div class="col-lg-12" style="border:1px #6f87a0 solid;max-height: 450px;overflow: auto;">
                    <tlk:RadTreeView ID="rtvModulos" runat="server"
                                            CheckBoxes="true"                                        
                                            CheckChildNodes="true"
                                            TriStateCheckBoxes="true"                         
                        Skin="WebBlue"                                  
                        OnNodeCheck="rtvModulos_NodeCheck"                                            
                                            >                                        
                    </tlk:RadTreeView>
                </div>                
                <div class="col-lg-12">
                    <br />
                <hr />
                    <input type="button" value="Ok" class="btn btn-primary" style="float:right;" onclick="closeOpenWinMapeo()" />
                </div>
            </asp:Panel>
         </ContentTemplate>               
    </asp:UpdatePanel>

    <!-- ------------------ Modal registro rol -------------------------------- -->
    <cc1:ModalPopupExtender ID="mpeRol" runat="server"
            TargetControlID="hfRol"
            PopupControlID="pnlRol"
            BackgroundCssClass="FondoModal"
            BehaviorID="mpeRol">
        </cc1:ModalPopupExtender>
        <asp:HiddenField ID="hfRol" runat="server" />
        <asp:Panel ID="pnlRol" runat="server" CssClass="PanelModal" Style="display: none;" Width="100%" Height="100%">
            <asp:UpdatePanel ID="upFrameRol" runat="server" class="col-lg-offset-3 col-lg-6" style="height: 100%;">
                <ContentTemplate>                   
                    <div class="box box-solid box-border-sys">
                      <div class="box-header with-border box-sys">
                        <h3 class="box-title">Registro de nuevo Rol</h3>
                        <div class="box-tools pull-right">                                                    
                        </div><!-- /.box-tools -->
                      </div><!-- /.box-header -->
                      <div class="box-body">
                        <asp:Panel ID="pnlErrorRegRol" runat="server" >
                            <div class="callout callout-danger lead">                                
                                <asp:Label ID="lblErrorRegRol" runat="server" ></asp:Label>
                            </div>
                        </asp:Panel>                          
                        <div class="form-horizontal">                                                                                    
                            <div class="form-group"> 
                                <label class="col-lg-4 control-label">Nombre</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="tbNombre" runat="server" CssClass="form-control" ></asp:TextBox>
                                </div>                                
                            </div>                                                   
                            <div class="form-group"> 
                                <label class="col-lg-4 control-label">Descripción</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="tbDescripcion" runat="server" CssClass="form-control noresize" Width="100%" Rows="3" TextMode="MultiLine"  ></asp:TextBox>
                                </div>                                
                            </div>                                                         
                            <div class="form-group"> 
                                <label class="col-lg-4 control-label">País</label>
                                <div class="col-lg-8">
                                    <tlk:RadComboBox ID="ddlPais" runat="server"  EnableEmbeddedSkins="true" Skin="WebBlue" ></tlk:RadComboBox>
                                </div>                                
                            </div>                                                                                  
                        </div>                        
                      </div><!-- /.box-body -->
                      <div class="box-footer">
                        <table style="width:100%;">
                            <tr>
                                <td style="text-align:right;vertical-align:middle;">
                                    <asp:Button ID="btnCancelarRegRol" runat="server" Text="Cancelar" CssClass="btn btn-pinterest" OnClick="btnCancelarRegRol_Click" />
                                    <asp:Button ID="btnRegistrarRegRol" runat="server" Text="Registrar" CssClass="btn btn-primary" OnClick ="btnRegistrarRegRol_Click" />
                                </td>
                            </tr>
                        </table>
                      </div><!-- box-footer -->
                    </div><!-- /.box -->
                </ContentTemplate>                
            </asp:UpdatePanel>
        </asp:Panel>

    

</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="cpFooterScript" runat="server">
    <script>
        var winMapeo = null;

        function closeOpenWinMapeo() {
            try {
                if (winMapeo != null || winMapeo != undefined) {
                    winMapeo.dialog("destroy");
                }
            }
            catch (e) { }
        }

        function openWinMapeo() {
            closeOpenWinMapeo();
            winMapeo = $("#<%= upWinNodos.ClientID%>").dialog({
                dialogClass: "col-md-6",
                width: "1e",
                autoOpen: false,
                close: function (event, ui) {
                    winMapeo.dialog("destroy");
                }
            });

            winMapeo.dialog("open");
        }

    </script>
</asp:Content>

