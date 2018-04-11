<%@ Page Title="" Language="C#" ValidateRequest="false" MasterPageFile="~/MdlApps/Shared/AppsMaster.master" AutoEventWireup="true" CodeBehind="Apps.aspx.cs" Inherits="SistemasApp.MdlApps.Apps" %>
<%@ MasterType VirtualPath="~/MdlApps/Shared/AppsMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
    <style>
        .btn-accion-grid
        {
            margin:5px;
            border:1px solid transparent;
            padding:0 5px;
            border-radius:0.5em;
        }
        .btn-accion-grid:hover
        {
            border:1px solid #000;
            
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpTituloPagina" runat="server">
    Aplicaciones
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpDescripcion" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cpContenidoPrincipal" runat="server">
    <div class="row">
       <div class="col-xs-12">
           <asp:UpdatePanel ID="upRgApps" runat="server">
                <ContentTemplate>
                    <div class="tool-header-grid-titulo" >
                        <div >         
                            <asp:LinkButton runat="server" ID="btnNuevaApp"  CssClass="btn"  OnClick="btnNuevaApp_Click" >
                                <i class="fa  fa-plus-square fa-lg"></i>&nbsp; Nueva Aplicación
                            </asp:LinkButton>                            
                        </div>
                        <div >
                            <label >Aplicaciones registrados</label>
                            <asp:HiddenField ID="hidIdApp" runat="server"  />                            
                        </div>
                    </div> 
                    <tlk:RadGrid ID="rgApps" runat="server"
                        OnNeedDataSource="rgApps_NeedDataSource"    
                        OnItemCommand="rgApps_ItemCommand"                                                            
                        EnableEmbeddedSkins="true" Skin="WebBlue"
                        Width="100%">
                        <MasterTableView                        
                            AutoGenerateColumns="false"
                            DataKeyNames="IdSistema"
                            AllowPaging="true"
                            PageSize="20"
                            Width="100%"                    
                            NoMasterRecordsText="No existen Aplicaciones registrados.">
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                            <AlternatingItemStyle HorizontalAlign="Center" VerticalAlign="Top" />                        
                            <Columns>                            
                                <tlk:GridBoundColumn DataField="NombreSistema" HeaderText="Aplicación">
                                    <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" Width="150px" />
                                    <ItemStyle  Width="150px"  CssClass="hidden-overflow"  />                                
                                </tlk:GridBoundColumn>                            
                                <tlk:GridBoundColumn DataField="UrlHome" HeaderText="Página home">
                                    <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center"  Width="150px" />
                                    <ItemStyle  Width="150px" CssClass="hidden-overflow" />
                                </tlk:GridBoundColumn>                                                                
                                <tlk:GridTemplateColumn HeaderText="Sistema externo" >
                                    <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center"   Width="150px" />  
                                    <ItemStyle  Width="150px" CssClass="hidden-overflow" />
                                    <ItemTemplate >                                    
                                       <asp:Label ID="tbEmbebido" runat="server" Text='<%# (bool)DataBinder.Eval(Container.DataItem, "Embebido")==true?"No":"Si" %>'></asp:Label> 
                                    </ItemTemplate>                              
                                </tlk:GridTemplateColumn>  
                                <tlk:GridTemplateColumn HeaderText="Estatus" >
                                    <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center"   Width="150px" />  
                                    <ItemStyle  Width="150px" CssClass="hidden-overflow" />
                                    <ItemTemplate >                                    
                                       <asp:Label ID="tbActivo" runat="server" Text='<%# (bool)DataBinder.Eval(Container.DataItem, "Activo")==true?"Activo":"Inactivo" %>'></asp:Label> 
                                    </ItemTemplate>                              
                                </tlk:GridTemplateColumn>                                                                 
                                <tlk:GridTemplateColumn HeaderText="Configuración" >
                                    <HeaderStyle Width="100px" />
                                    <ItemStyle  Width="150px" CssClass="hidden-overflow" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lknGridEditar" runat="server" OnClick="lknGridAcciones_Click"  CommandName="EDITAR" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "IdSistema")%>' ToolTip="Editar información del sistema" >
                                            <i class="fa fa-pencil" aria-hidden="true"></i>&nbsp;&nbsp;                                            
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lknGridAccesos" runat="server" OnClick="lknGridAcciones_Click"  CommandName="CONFIGURAR_MODULOS" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "IdSistema")%>' ToolTip="Configurar modulos de la aplicación"  >
                                            <i class="glyphicon glyphicon-th-large" aria-hidden="true"></i>&nbsp;&nbsp;
                                        </asp:LinkButton>                                        
                                    </ItemTemplate>
                                </tlk:GridTemplateColumn>
                                <%--<tlk:GridButtonColumn Text='<i class="fa fa-pencil" aria-hidden="true"></i>' HeaderText="Editar" CommandName="EDITAR" > 
                                    <HeaderStyle Width="100px" />
                                    <ItemStyle ForeColor="#597790"  Width="100px" CssClass="hidden-overflow"  />
                                </tlk:GridButtonColumn>--%>
                                <tlk:GridButtonColumn Text='<i class="fa fa-times" aria-hidden="true"></i>' HeaderText="Eliminar" CommandName="ELIMINAR"
                                    ConfirmDialogType="RadWindow" ConfirmTitle="Alerta"
                                    ConfirmText="¿Segur@ quieres dar de baja esta Aplicación?" > 
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
            </asp:UpdatePanel>
       </div>
   </div>

    <!-- ------------------ Ventana Modulos -------------------------------- -->
    
    <asp:UpdatePanel ID="upWinModulos" runat="server" style="display:none;">
         <ContentTemplate>    
            <asp:Panel ID="pnlModulos" runat="server" title="Modulos del sistema" >       
                <asp:Panel ID="pnlErrorWinModulos" runat="server" >
                        <div class="callout callout-danger lead">                                
                            <asp:Label ID="lblErrorWinModulos" runat="server" style="font-size: small;" ></asp:Label>
                        </div>
                </asp:Panel>                            
                <div class="tool-header-grid-titulo" >
                    <div >      
                        <asp:LinkButton runat="server" ID="lknNuevoModulo"  CssClass="btn"  OnClick="lknNuevoModulo_Click" >
                                <i class="fa  fa-plus-square fa-lg"></i>&nbsp; Nuevo Modulo
                        </asp:LinkButton>                                                                    
                    </div>
                    <div >                
                        <label >Mapa de Modulos del sistema <span id="lblNomModuloSel" runat="server"></span> </label> 
                        
                    </div>
                </div>
                <div class="col-lg-12" style="border:1px #6f87a0 solid;max-height: 450px;overflow: auto;">                    
                    <tlk:RadTreeView ID="rtvModulos" runat="server"
                                            CheckBoxes="false"                                        
                                            CheckChildNodes="false"
                                            TriStateCheckBoxes="false"                             
                        Skin="WebBlue"                                      
                                            >                                                  
                        
                        
                    </tlk:RadTreeView>
                </div>                
                <div class="col-lg-12">
                    <br />
                <hr />
                    <input type="button" value="Ok" class="btn btn-primary" style="float:right;" onclick="closeOpenWinModulo()" />
                </div>
            </asp:Panel>
         </ContentTemplate>     
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="rtvModulos" />
        </Triggers>          
    </asp:UpdatePanel>

    <!-- ------------------------------------ Modal registro App ---------------------------------------------------- -->

    <cc1:ModalPopupExtender ID="mpeApp" runat="server"
            TargetControlID="hfApp"
            PopupControlID="pnlApp"
            BackgroundCssClass="FondoModal"
            BehaviorID="mpeApp">
        </cc1:ModalPopupExtender>
        <asp:HiddenField ID="hfApp" runat="server" />
        <asp:Panel ID="pnlApp" runat="server" CssClass="PanelModal" Style="display: none;" Width="100%" Height="100%">
            <asp:UpdatePanel ID="upFrameApp" runat="server" class="col-lg-offset-3 col-lg-6" style="height: 100%;">
                <ContentTemplate>                   
                    <div class="box box-solid box-border-sys">
                      <div class="box-header with-border box-sys">
                        <h3 class="box-title">Registro de nueva Aplicación</h3>
                        <div class="box-tools pull-right">                                                    
                        </div><!-- /.box-tools -->
                      </div><!-- /.box-header -->
                      <div class="box-body">
                        <asp:Panel ID="pnlErrorRegApp" runat="server" >
                            <div class="callout callout-danger lead">                                
                                <asp:Label ID="lblErrorRegApp" runat="server" ></asp:Label>
                            </div>
                        </asp:Panel>                          
                        <div class="form-horizontal">                                                                                    
                            <div class="form-group"> 
                                <label class="col-lg-4 contApp-label">Nombre</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="tbNombreApp" runat="server" CssClass="form-contApp" ></asp:TextBox>
                                </div>                                
                            </div>  
							<div class="form-group"> 
                                <label class="col-lg-4 contApp-label">Iniciales</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="tbLogo" runat="server" CssClass="form-contApp" ></asp:TextBox>
                                </div>                                
                            </div>                                                  
                            <div class="form-group"> 
                                <label class="col-lg-4 contApp-label">Url Home</label>
                                <div class="col-lg-8">
								    <asp:TextBox ID="tbUrlHome" runat="server" CssClass="form-contApp" ></asp:TextBox>                                    
                                </div>                                
                            </div>                                                         							
                            <div class="form-group"> 
                                <label class="col-lg-4 contApp-label">Estatus</label>
                                <div class="col-lg-8">
                                    <tlk:RadComboBox ID="ddlEstatus" runat="server"  EnableEmbeddedSkins="true" Skin="WebBlue" >
                                        <Items>
                                            <tlk:RadComboBoxItem Text="Activo" Value="true" />
                                            <tlk:RadComboBoxItem Text="Inactivo" Value="false" />
                                        </Items>
									</tlk:RadComboBox>
                                </div>                                
                            </div> 
                            <div class="form-group">                                                                 
                                <div class="col-lg-offset-4 col-lg-8 list-check-square-war">
                                    <asp:CheckBox ID="chkAppExterna" runat="server" Text="Aplicación externa" />								    
                                </div>                                
                            </div>                                                                                  
                        </div>                        
                      </div><!-- /.box-body -->
                      <div class="box-footer">
                        <table style="width:100%;">
                            <tr>
                                <td style="text-align:right;vertical-align:middle;">
                                    <asp:Button ID="btnCancelarRegApp" runat="server" Text="Cancelar" CssClass="btn btn-pinterest" OnClick="btnCancelarRegApp_Click" />
                                    <asp:Button ID="btnRegistrarRegApp" runat="server" Text="Registrar" CssClass="btn btn-primary" OnClick ="btnRegistrarRegApp_Click" />
                                </td>
                            </tr>
                        </table>
                      </div><!-- box-footer -->
                    </div><!-- /.box -->
                </ContentTemplate>                
            </asp:UpdatePanel>
        </asp:Panel>

    <!-- ------------------------------------ Modal registro Modulo ---------------------------------------------------- -->

    <cc1:ModalPopupExtender ID="mpeModulo" runat="server"
            TargetControlID="hfModulo"
            PopupControlID="pnlModulo"
            BackgroundCssClass="FondoModal"
            BehaviorID="mpeModulo">
        </cc1:ModalPopupExtender>
        <asp:HiddenField ID="hfModulo" runat="server" />
        <asp:Panel ID="pnlModulo" runat="server" CssClass="PanelModal" Style="display: none;" Width="100%" Height="100%">
            <asp:UpdatePanel ID="upFrameModulo" runat="server" class="col-lg-offset-3 col-lg-6" style="height: 100%;">
                <ContentTemplate>                   
                    <div class="box box-solid box-border-sys">
                      <div class="box-header with-border box-sys">
                        <h3 class="box-title">Registro de nuevo Modulo</h3>
                        <div class="box-tools pull-right">                                                    
                        </div><!-- /.box-tools -->
                      </div><!-- /.box-header -->
                      <div class="box-body">
                        <asp:Panel ID="pnlErrorRegModulo" runat="server" >
                            <div class="callout callout-danger lead">                                
                                <asp:Label ID="lblErrorRegModulo" runat="server" ></asp:Label>
                            </div>
                        </asp:Panel>                          
                        <div class="form-horizontal">                                                                                    
                            <div class="form-group"> 
                                <label class="col-lg-4 contModulo-label">Nombre</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="tbNombreModulo" runat="server" CssClass="form-contModulo" ></asp:TextBox>
                                </div>                                
                            </div>  
							<div class="form-group"> 
                                <label class="col-lg-4 contModulo-label">Url Icono</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="tbUrlIcono" runat="server" CssClass="form-contModulo" ></asp:TextBox>
                                </div>                                
                            </div>                                                  
                            <div class="form-group"> 
                                <label class="col-lg-4 contModulo-label">Url Destino</label>
                                <div class="col-lg-8">
								    <asp:TextBox ID="tbUrlDestino" runat="server" CssClass="form-contModulo" ></asp:TextBox>                                    
                                </div>                                
                            </div>                                                         							
							<div class="form-group"> 
                                <label class="col-lg-4 contModulo-label">Cadena de conexión a DB</label>
                                <div class="col-lg-8">
								    <asp:TextBox ID="tbDbConexion" runat="server" CssClass="form-contModulo" ></asp:TextBox>                                    
                                </div>                                
                            </div>
							<div class="form-group"> 
                                <label class="col-lg-4 contModulo-label">Tool Tip</label>
                                <div class="col-lg-8">
								    <asp:TextBox ID="tbToolTip" runat="server" CssClass="form-contModulo" ></asp:TextBox>                                    
                                </div>                                
                            </div>
							<div class="form-group"> 
                                <label class="col-lg-4 contModulo-label">Orden</label>
                                <div class="col-lg-8">
								    <asp:TextBox ID="tbOrden" runat="server" CssClass="form-contModulo" min="0" TextMode="Number" ></asp:TextBox>                                    
                                </div>                                
                            </div>
                            <div class="form-group"> 
                                <label class="col-lg-4 contModulo-label">Estatus</label>
                                <div class="col-lg-8">
                                    <tlk:RadComboBox ID="ddlEstatusModulo" runat="server"  EnableEmbeddedSkins="true" Skin="WebBlue" >
                                        <Items>
                                            <tlk:RadComboBoxItem Text="Activo" Value="true" />
                                            <tlk:RadComboBoxItem Text="Inactivo" Value="false" />
                                        </Items>
									</tlk:RadComboBox>
                                </div>                                
                            </div>                             
                        </div>                        
                      </div><!-- /.box-body -->
                      <div class="box-footer">
                        <table style="width:100%;">
                            <tr>
                                <td style="text-align:right;vertical-align:middle;">
                                    <asp:Button ID="btnCancelarRegModulo" runat="server" Text="Cancelar" CssClass="btn btn-pinterest" OnClick="btnCancelarRegModulo_Click" />
                                    <asp:Button ID="btnRegistrarRegModulo" runat="server" Text="Registrar" CssClass="btn btn-primary" OnClick ="btnRegistrarRegModulo_Click" />
                                </td>
                            </tr>
                        </table>
                      </div><!-- box-footer -->
                    </div><!-- /.box -->
                </ContentTemplate>                
            </asp:UpdatePanel>
        </asp:Panel>


    <!-- ------------------------------------ Modal registro Pagina ---------------------------------------------------- -->

    <cc1:ModalPopupExtender ID="mpePagina" runat="server"
            TargetControlID="hfPagina"
            PopupControlID="pnlPagina"
            BackgroundCssClass="FondoModal"
            BehaviorID="mpePagina">
        </cc1:ModalPopupExtender>
        <asp:HiddenField ID="hfPagina" runat="server" />
        <asp:Panel ID="pnlPagina" runat="server" CssClass="PanelModal" Style="display: none;" Width="100%" Height="100%">
            <asp:UpdatePanel ID="upFramePagina" runat="server" class="col-lg-offset-3 col-lg-6" style="height: 100%;">
                <ContentTemplate>                   
                    <div class="box box-solid box-border-sys">
                      <div class="box-header with-border box-sys">
                        <h3 class="box-title">Registro de nueva Pagina</h3>
                        <div class="box-tools pull-right">                                                    
                        </div><!-- /.box-tools -->
                      </div><!-- /.box-header -->
                      <div class="box-body">
                        <asp:Panel ID="pnlErrorRegPagina" runat="server" >
                            <div class="callout callout-danger lead">                                
                                <asp:Label ID="lblErrorRegPagina" runat="server" ></asp:Label>
                                <asp:HiddenField ID="hidIdModulo" runat="server"  />                                       
                                <asp:HiddenField ID="hidIdItemParent" runat="server"  />                                       
                            </div>
                        </asp:Panel>                          
                        <div class="form-horizontal">                                                                                    
                            <div class="form-group"> 
                                <label class="col-lg-4 contPagina-label">Nombre</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="tbNombrePagina" runat="server" CssClass="form-contPagina" ></asp:TextBox>
                                </div>                                
                            </div>  
							<div class="form-group"> 
                                <label class="col-lg-4 contPagina-label">Url Icono</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="tbUrlIconoPagina" runat="server" CssClass="form-contPagina" ></asp:TextBox>
                                </div>                                
                            </div>                                                  
                            <div class="form-group"> 
                                <label class="col-lg-4 contPagina-label">Url Destino</label>
                                <div class="col-lg-8">
								    <asp:TextBox ID="tbUrlDestinoPagina" runat="server" CssClass="form-contPagina" ></asp:TextBox>                                    
                                </div>                                
                            </div>                                                         																					
							<div class="form-group"> 
                                <label class="col-lg-4 contPagina-label">Orden</label>
                                <div class="col-lg-8">
								    <asp:TextBox ID="tbOrdenPagina" runat="server" CssClass="form-contPagina" min="0" TextMode="Number" ></asp:TextBox>                                    
                                </div>                                
                            </div>
                            <div class="form-group"> 
                                <label class="col-lg-4 contPagina-label">Estatus</label>
                                <div class="col-lg-8">
                                    <tlk:RadComboBox ID="ddlEstatusPagina" runat="server"  EnableEmbeddedSkins="true" Skin="WebBlue" >
                                        <Items>
                                            <tlk:RadComboBoxItem Text="Activo" Value="true" />
                                            <tlk:RadComboBoxItem Text="Inactivo" Value="false" />
                                        </Items>
									</tlk:RadComboBox>
                                </div>                                
                            </div>                             
                        </div>                        
                      </div><!-- /.box-body -->
                      <div class="box-footer">
                        <table style="width:100%;">
                            <tr>
                                <td style="text-align:right;vertical-align:middle;">
                                    <asp:Button ID="btnCancelarRegPagina" runat="server" Text="Cancelar" CssClass="btn btn-pinterest" OnClick="btnCancelarRegPagina_Click" />
                                    <asp:Button ID="btnRegistrarRegPagina" runat="server" Text="Registrar" CssClass="btn btn-primary" OnClick ="btnRegistrarRegPagina_Click" />
                                </td>
                            </tr>
                        </table>
                      </div><!-- box-footer -->
                    </div><!-- /.box -->
                </ContentTemplate>                
            </asp:UpdatePanel>
        </asp:Panel>



</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cpFooterScript" runat="server">
    <script>
        var winModulo = null;

        function closeOpenWinModulo() {
            try {
                if (winModulo != null || winModulo != undefined) {
                    winModulo.dialog("destroy");
                }
            }
            catch (e) { }
        }

        function openWinModulo() {
            closeOpenWinModulo();
            winModulo = $("#<%= upWinModulos.ClientID%>").dialog({
                dialogClass: "col-md-6",
                width: "1e",
                autoOpen: false,
                close: function (event, ui) {
                    winModulo.dialog("destroy");
                }
            });

            winModulo.dialog("open");
        }

    </script>
</asp:Content>
