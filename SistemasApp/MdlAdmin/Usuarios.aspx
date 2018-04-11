<%@ Page Title="" Language="C#" MasterPageFile="~/MdlAdmin/Shared/AdminMaster.master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="SistemasApp.MdlAdmin.Usuarios" %>
<%@ MasterType VirtualPath="~/MdlAdmin/Shared/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
    
    <script type="text/ecmascript">
        var hand;
        
    </script>
    <style>
        .trRol
        {
            cursor:pointer;
        }
        .trPais
        {
            cursor:no-drop;
        }
        .rdpFecOcurrIni{z-index:20000  !important;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpTituloPagina" runat="server">
    Usuarios
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpDescripcion" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cpContenidoPrincipal" runat="server">
    <asp:UpdatePanel ID="upRgUsuarios" runat="server" style="height:500px; " >
        <ContentTemplate>
            <div class="tool-header-grid-titulo" >
                <div >                
                    <asp:LinkButton runat="server" ID="btnNuevoUsuario" CssClass="btn"  OnClick="btnNuevoUsuario_Click" >                        
                         <i class="fa  fa-plus-square fa-lg"></i>&nbsp; Nuevo Usuario                        
                    </asp:LinkButton>
                </div>
                <div >
                    <label >Relación de Usuarios registrados</label>
                    <asp:HiddenField ID="HiddenField1" runat="server"  />
                </div>
            </div>
            <tlk:RadGrid ID="rgUsuarios" runat="server"
                OnNeedDataSource="rgUsuarios_NeedDataSource"
                EnableEmbeddedSkins="true" Skin="WebBlue"
                AllowSorting="true"
                Height="98%"
                Width="100%">
                <MasterTableView
                    AllowFilteringByColumn="true"                                        
                    AutoGenerateColumns="false"
                    DataKeyNames="Usuario_sistema,Nombre,Apellido_paterno,Apellido_materno,Correo,Celular,Extension,FechaDeRegistro,FechaDeVencimiento,Estatus"
                    AllowPaging="true"
                    PageSize="50"
                    Width="100%"                    
                    NoMasterRecordsText="No se encontraron Usuarios para el filtro indicado.">
                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                    <AlternatingItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                    <Columns>
                        <tlk:GridBoundColumn DataField="Usuario_sistema" HeaderText="Usuario" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" AutoPostBackOnFilter="true" >
                            <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            <ItemStyle />
                        </tlk:GridBoundColumn>
                        <tlk:GridTemplateColumn HeaderText="Nombre" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%"  AutoPostBackOnFilter="true" >                            
                            <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            <ItemTemplate >
                                <%# Eval("Nombre")+" "+Eval("Apellido_paterno")+" "+Eval("Apellido_materno") %>
                            </ItemTemplate>
                        </tlk:GridTemplateColumn>
                        <tlk:GridBoundColumn DataField="Correo" HeaderText="Correo" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" AutoPostBackOnFilter="true" >
                            <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            <ItemStyle />
                        </tlk:GridBoundColumn>
                        <tlk:GridBoundColumn DataField="Celular" HeaderText="Celular" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%"  AutoPostBackOnFilter="true">
                            <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            <ItemStyle />
                        </tlk:GridBoundColumn>
                        <tlk:GridBoundColumn DataField="Extension" HeaderText="Extensión Teléfonica" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" AutoPostBackOnFilter="true" >
                            <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            <ItemStyle />
                        </tlk:GridBoundColumn>
                        <tlk:GridTemplateColumn HeaderText="Fecha de Registro" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" AutoPostBackOnFilter="true" >
                            <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <%# ((DateTime)Eval("FechaDeRegistro")).ToString("dd/MM/yyyy") %>
                            </ItemTemplate>
                        </tlk:GridTemplateColumn>
                        <tlk:GridTemplateColumn HeaderText="Fecha de Vencimiento" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" AutoPostBackOnFilter="true" >
                            <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <%# ((DateTime)Eval("FechaDeVencimiento")).ToString("dd/MM/yyyy") %>
                            </ItemTemplate>
                        </tlk:GridTemplateColumn>
                        <tlk:GridBoundColumn DataField="Estatus" HeaderText="Estatus" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="100%" AutoPostBackOnFilter="true" >
                            <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            <ItemStyle />
                        </tlk:GridBoundColumn>
                    </Columns>                    
                </MasterTableView>
                <ClientSettings>
                    <Scrolling AllowScroll="true" ScrollHeight="100%" UseStaticHeaders="true" />
                    <ClientEvents OnRowContextMenu="hand.click" />
                    <Selecting AllowRowSelect="true" />
                </ClientSettings>
            </tlk:RadGrid>
            <tlk:RadContextMenu ID="RadMenuContextual" runat="server" Skin="WebBlue" OnItemClick="RadMenuContextual_ItemClick"
                EnableRoundedCorners="true" EnableShadows="true">                
                <%--<ItemTemplate>                                                          
                    <i style="color:#000;" class="fa fa-ban" aria-hidden="true"><%# DataBinder.Eval(Container,"Text") %>  </i>                    
                </ItemTemplate>                --%>
                <Items>                    
                    <tlk:RadMenuItem Text="Editar" ImageUrl="~/Assets/imgs/excel.png" CssClass="item-submenu" Value="EDITAR"  PostBack="true" />                    
                    <tlk:RadMenuItem Text="Roles" ImageUrl="~/Assets/imgs/excel.png" CssClass="item-submenu" Value="ROLES" PostBack="true" />                    
                    <tlk:RadMenuItem Text="Permisos" ImageUrl="~/Assets/imgs/excel.png" CssClass="item-submenu" Value="PERMISOS" PostBack="true" />                    
                    <%--<tlk:RadMenuItem Text="Estatus" ImageUrl="~/Assets/imgs/excel.png" CssClass="item-submenu" PostBack="false">
                        <Items>
                            <tlk:RadMenuItem Text="Activo" ImageUrl="~/Assets/imgs/excel.png" CssClass="item-submenu" Value="EXPORTAR_GRID_EXCEL" PostBack="false" />
                        </Items>
                    </tlk:RadMenuItem>--%>
                    <tlk:RadMenuItem IsSeparator="true" />
                    <tlk:RadMenuItem Text="Resetear contraseña" ImageUrl="~/Assets/imgs/excel.png" CssClass="item-submenu" Value="RESET" PostBack="true" />
                </Items>
            </tlk:RadContextMenu>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnRegistrar" />            
        </Triggers>
    </asp:UpdatePanel>

    <!-- ------------------ Ventana Roles sistema -------------------------------- -->
    
    <asp:UpdatePanel ID="upWinRoles" runat="server" style="display:none;">
         <ContentTemplate>    
            <asp:Panel ID="pnlRoles" runat="server" title="Destinos del sistema" >       
                <asp:Panel ID="pnlErrorWinRoles" runat="server" >
                        <div class="callout callout-danger lead">                                
                            <asp:Label ID="lblErrorWinRoles" runat="server" style="font-size: small;" ></asp:Label>
                        </div>
                </asp:Panel>                            
                <div class="tool-header-grid-titulo" >
                    <div >            
                        <label style="color: #FFF;" >Sistema </label>
                        <tlk:RadComboBox ID="ddlSistemas" runat="server" EnableEmbeddedSkins="true" Skin="WebBlue"    
                            OnClientSelectedIndexChanging="closeOpenWinRoles"                                                    
                           OnSelectedIndexChanged="ddlSistemas_SelectedIndexChanged"  AutoPostBack="true" >

                         </tlk:RadComboBox>                                                          
                    </div>
                    <div >                
                        <label >Mapa de roles asignados a <span id="lblNomUsuarioSel" runat="server"></span> </label>                                        
                    </div>
                </div>
                <div class="col-lg-12" style="border:1px #6f87a0 solid;">
                    <asp:UpdatePanel ID="upRoles" runat="server" style="max-height: 500px;overflow-y: auto;">
                        <ContentTemplate>
                            <table>                                
                                <tr style="vertical-align: top;">
                                    <td style="width:50%">
                                        <asp:Panel ID="pnlRolDisp" runat="server" 
                                                   CssClass="ContenedorIzqOp"
                                                   Width="100%"                                            
                                            style="min-height:300px;overflow:auto;"
                                                   >
                                            <center>
                                                <asp:Label ID="lblEndDisp" runat="server" Text="ROLES DISPONIBLES" CssClass="txtTitMenu"></asp:Label>
                                            </center>
                                            <br />
                                            <img src="../Assets/imgs/div-menu.jpg">
                                            <br />
                                            <tlk:RadTreeView ID="rtvRolesDisponibles" runat="server"
                                                             EnableDragAndDrop="true"
                                                             EnableDragAndDropBetweenNodes="false"                                                                                                             
                                                             Width="100%" Height="100%"      
                                                            style="min-height:300px;"                                          
                                                             OnNodeDrop="rtvRolesDisponibles_NodeDrop"
                                                Skin="WebBlue"
                                                             >                                                
                                            </tlk:RadTreeView>
                                        </asp:Panel>
                                    </td>
                                    <td style="width:30px">                        
                                    </td>
                                    <td style="width:50%">
                                        <asp:Panel ID="pnlRolUsr" runat="server" 
                                                   CssClass="ContenedorIzqOp"
                                                   Width="100%"
                                            style="min-height:300px;overflow:auto;"
                                                   >
                                            <center>
                                                <asp:Label ID="lblEncAsig" runat="server" Text="ROLES ASIGNADOS" CssClass="txtTitMenu"></asp:Label>
                                            </center>
                                            <br />
                                            <img src="../Assets/imgs/div-menu.jpg">
                                            <br />
                                            <tlk:RadTreeView ID="rtvRolesAsignados" runat="server"
                                                             EnableDragAndDrop="true"
                                                             EnableDragAndDropBetweenNodes="false"                                                             
                                                             Width="100%"  Height="100%"
                                                             style="min-height:300px;"
                                                             OnNodeDrop="rtvRolesAsignados_NodeDrop"
                                                Skin="WebBlue"
                                                             ></tlk:RadTreeView>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                
                        </ContentTemplate>                       
                    </asp:UpdatePanel>                    
                </div>                
                <div class="col-lg-12">
                    <br />
                <hr />
                    <input type="button" value="Ok" class="btn btn-primary" style="float:right;" onclick="closeOpenWinRoles()" />
                </div>
            </asp:Panel>
         </ContentTemplate>               
    </asp:UpdatePanel>

    <!-- ------------------ Modal Permisos sistema -------------------------------- -->

    <cc1:ModalPopupExtender ID="mpeUsuarioPermisos" runat="server"
            TargetControlID="hfUsuarioPermisos"
            PopupControlID="pnlUsuarioPermisos"
            BackgroundCssClass="FondoModal"
            BehaviorID="mpeUsuarioPermisos">
        </cc1:ModalPopupExtender>
        <asp:HiddenField ID="hfUsuarioPermisos" runat="server" />
    <asp:Panel ID="pnlUsuarioPermisos" runat="server" CssClass="PanelModal" Style="display: none;" Width="100%" Height="100%"  >
        <asp:UpdatePanel ID="upWinPermisos" runat="server" class="col-lg-offset-2 col-lg-8" style="height: 100%;" >
             <ContentTemplate>  
                 <div class="box box-solid box-border-sys">
                      <div class="box-header with-border box-sys">
                        <h3 class="box-title">Mapa de permisos asignados </h3>
                        <div class="box-tools pull-right">                                                    
                        </div><!-- /.box-tools -->
                      </div><!-- /.box-header -->
                      <div class="box-body">  
                          <asp:Panel ID="pnlErrorWinPermisos" runat="server" >
                            <div class="callout callout-danger lead">                                
                                <asp:Label ID="lblErrorWinPermisos" runat="server" style="font-size: small;" ></asp:Label>
                            </div>
                          </asp:Panel> 
                            <asp:Panel ID="pnlPermisos" runat="server" title="Permisos del sistema" >       
                                                                   
                                <div class="col-lg-12" style="border:1px #6f87a0 solid; padding:0%;">
                                         <div class="tool-header-grid-titulo" >
                                            <div >                  
                                                <asp:LinkButton id="lknPermitirTodo" runat="server" CssClass="btn" OnClick="lknPermitirTodo_Click">
                                                    <i class="fa fa-check-square-o"></i>&nbsp; Permitir Todo
                                                </asp:LinkButton> 
                                                <asp:LinkButton id="lknDenegarTodo" runat="server" CssClass="btn" OnClick="lknDenegarTodo_Click">
                                                    <i class="fa fa-square-o" ></i>&nbsp; Denegar Todo
                                                </asp:LinkButton> 
                                                <label style="color: #FFF;" >Sistema </label>
                                                <tlk:RadComboBox ID="ddlSistemasPermisos" runat="server" EnableEmbeddedSkins="true" Skin="WebBlue"    
                                                    OnClientSelectedIndexChanging="closeOpenWinRoles"                                                    
                                                   OnSelectedIndexChanged="ddlSistemasPermisos_SelectedIndexChanged"  AutoPostBack="true" >

                                                 </tlk:RadComboBox>
                                            </div>
                                            <div >
                                                <label >Relación de Permisos asignados a <asp:Label id="lblNomUsuarioSelPermisosItem" runat="server"></asp:Label> </label>
                                                <asp:HiddenField ID="hidIdRolPermisos" runat="server"  />
                                            </div>
                                        </div> 				                
						                <tlk:RadGrid ID="rgPermisos" runat="server"
                                            
							
							                OnItemCommand="rgPermisos_ItemCommand"
							                EnableEmbeddedSkins="true" Skin="WebBlue"                                               
							                Width="100%">
							                <MasterTableView
								                AutoGenerateColumns="false"
								                DataKeyNames="IdUsuarioPermisos"
								                AllowPaging="false"
								                PageSize="20"
								                Width="100%"   
                                            
								                NoMasterRecordsText="No se encontraron asignaciones.">
                                                <GroupByExpressions >
                                                    <tlk:GridGroupByExpression>
                                                        <GroupByFields >
                                                            <tlk:GridGroupByField FieldName="IdRol" />                                                           
                                                        </GroupByFields>
                                                        <SelectFields >
                                                            <tlk:GridGroupByField FieldName="NombreRol" HeaderText="Rol" />
                                                        </SelectFields>
                                                    </tlk:GridGroupByExpression>
                                                </GroupByExpressions>
								                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
								                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
								                <AlternatingItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
								                <Columns>
									                <tlk:GridBoundColumn DataField="Nombre" HeaderText="Página">
										                <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
										                <ItemStyle VerticalAlign="Middle" HorizontalAlign="Left" />
									                </tlk:GridBoundColumn>                        
									                <tlk:GridTemplateColumn HeaderText="Crear/Editar">
										                <ItemTemplate>
											                <asp:CheckBox ID="chkWrite" runat="server" style="cursor:pointer;" Checked='<%# Eval("Write") %>' data-id='<%# Eval("IdUsuarioPermisos") %>' OnCheckedChanged="chkDeleteWrite_CheckedChanged" AutoPostBack="true" />
										                </ItemTemplate>
                                                        <ItemStyle Width="150px" />
                                                        <HeaderStyle Width="150px" />
									                </tlk:GridTemplateColumn>
									                <tlk:GridTemplateColumn HeaderText="Eliminar">
										                <ItemTemplate>
											                <asp:CheckBox ID="chkDelete" runat="server" style="cursor:pointer;" Checked='<%# Eval("Delete") %>' data-id='<%# Eval("IdUsuarioPermisos") %>'  OnCheckedChanged="chkDeleteWrite_CheckedChanged"
                                                             AutoPostBack="true" />                                                            
										                </ItemTemplate>
                                                        <ItemStyle Width="150px" />
                                                        <HeaderStyle Width="150px" />
									                </tlk:GridTemplateColumn>                        
									                <tlk:GridButtonColumn HeaderText="Privilegios Campo y Herramientas" CommandName="HERRAMIENTAS"                            
										                ButtonType="LinkButton" Text="<i class='fa fa-chevron-down' aria-hidden='true'></i>" >
                                                        <ItemStyle Width="200px" />
                                                        <HeaderStyle Width="200px" />
									                </tlk:GridButtonColumn>
								                </Columns>       
                                                <NestedViewTemplate>   
                                                    <div style="padding:1% 2%;background: rgb(90, 120, 146);" > 
                                                        <div class="box box-warning">
                                                            <div class="box-header with-border">
                                                                <h3 class="box-title">Herramientas</h3>                
                                                                <div class="box-tools pull-right">                              
                                                                    <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>                    
                                                                </div>
                                                            </div>
                                                            <div class="box-body">
                                                                <asp:CheckBoxList ID="checkHerramientas" runat="server" RepeatDirection="Horizontal" RepeatColumns="4" CssClass="list-check-square-war" AutoPostBack="true"
                                                                    OnSelectedIndexChanged="checkHerramientas_SelectedIndexChanged" >
                                                                    <asp:ListItem Text="algo" Value="2" Selected="True" ></asp:ListItem>
                                                                    <asp:ListItem Text="algo" Value="2" Selected="True" ></asp:ListItem>
                                                                    <asp:ListItem Text="algo" Value="2" Selected="True" ></asp:ListItem>
                                                                    <asp:ListItem Text="algo" Value="2" Selected="True" ></asp:ListItem>
                                                                    <asp:ListItem Text="algo" Value="2" Selected="True" ></asp:ListItem>
                                                                </asp:CheckBoxList>                                                
                                                            </div>                                                        
                                                         </div>
                                                    </div>
                                                </NestedViewTemplate>                                                
							                </MasterTableView>                                            
							                <ClientSettings>
								                <Scrolling AllowScroll="true" ScrollHeight="100%" UseStaticHeaders="true" />
							                </ClientSettings>
						                </tlk:RadGrid>            
    
                                </div>                                                
                            </asp:Panel>
                      </div>
                     <div class="box-footer">
                        <table style="width:100%;">
                            <tr>
                                <td style="text-align:right;vertical-align:middle;">
                                    <asp:Button ID="btnCancelarPermisos" runat="server" Text="Aceptar" CssClass="btn btn-pinterest"  OnClick="btnCancelarPermisos_Click" />
                                </td>
                            </tr>
                        </table>
                 </div>
                 </div>
             </ContentTemplate>                 
        </asp:UpdatePanel>
    </asp:Panel>






    <!-- ------------------ Modal registro y edicion -------------------------------- -->
    <cc1:ModalPopupExtender ID="mpeUsuario" runat="server"
            TargetControlID="hfUsuario"
            PopupControlID="pnlUsuario"
            BackgroundCssClass="FondoModal"
            BehaviorID="mpeUsuario">
        </cc1:ModalPopupExtender>
        <asp:HiddenField ID="hfUsuario" runat="server" />
        <asp:Panel ID="pnlUsuario" runat="server" CssClass="PanelModal" Style="display: none;" Width="100%" Height="100%">
            <asp:UpdatePanel ID="upFrameUsuario" runat="server" class="col-lg-offset-2 col-lg-8" style="height: 100%;">
                <ContentTemplate>                   
                    <div class="box box-solid box-border-sys">
                      <div class="box-header with-border box-sys">
                        <h3 class="box-title">Registro de nuevo Usuario</h3>
                        <div class="box-tools pull-right">                                                    
                        </div><!-- /.box-tools -->
                      </div><!-- /.box-header -->
                      <div class="box-body">
                        <asp:Panel ID="pnlErrorReg" runat="server" Visible="false" >
                            <div class="callout callout-danger lead">                                
                                <asp:Label ID="lblErrorReg" runat="server" ></asp:Label>
                            </div>
                        </asp:Panel>
                        <div class="form-horizontal">
                            <div class="form-group"> 
                                    <asp:Label runat="server" class="col-lg-2 control-label" id="lbUsuario">Usuario</asp:Label>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="tbUsuario" runat="server" CssClass="form-control" ></asp:TextBox>
                                </div>
                                <asp:Label runat="server" class="col-lg-2 control-label" id="lbPass">Contraseña</asp:Label>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="tbPass" runat="server" CssClass="form-control" TextMode="Password" ></asp:TextBox>
                                </div>
                             </div>
                            <hr />
                            <div class="form-group"> 
                                <label class="col-lg-2 control-label">Nombre</label>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="tbNombre" runat="server" CssClass="form-control" ></asp:TextBox>
                                </div>
                                <label class="col-lg-2 control-label">Apellido Paterno</label>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="tbApellidoP" runat="server" CssClass="form-control" ></asp:TextBox>
                                </div>
                             </div>
                            <div class="form-group">                             
                                <label class="col-lg-2 control-label">Apellido Materno</label>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="tbApellidoM" runat="server" CssClass="form-control" ></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group"> 
                                <label class="col-lg-2 control-label">Correo</label>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="tbCorreo" runat="server" CssClass="form-control" ></asp:TextBox>
                                </div>
                                <label class="col-lg-2 control-label">Celular</label>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="tbCelualar" runat="server" CssClass="form-control" ></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Extensión</label>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="tbExtension" runat="server" CssClass="form-control" ></asp:TextBox>
                                </div>
                                <label class="col-lg-2 control-label">Estatus</label>
                                <div class="col-lg-4">
                                    <asp:DropDownList ID="tbEstatus"
                                        AutoPostBack="false"
                                        runat="server">

                                        <asp:ListItem Selected="True" Value="1"> Activo </asp:ListItem>
                                        <asp:ListItem Value="2"> Inactivo </asp:ListItem>
                                      
                                    </asp:DropDownList>
                                    
                                </div>
                            </div>    
                            <div class="form-group">
                                <asp:Label ID="lbFechaVencimiento" runat="server" class="col-lg-2 control-label">Fecha de vencimiento</asp:Label>
                                <div class="col-lg-4">

                                    <asp:TextBox ID="tbFechaDeVencimiento"  runat="server" CssClass="form-control" disabled="true" placeholder="dd/mm/yyyy"></asp:TextBox>

                                    <tlk:RadAjaxPanel runat="server" ID="RadAjaxPanel1" LoadingPanelID="RadAjaxLoadingPanel1">
                                        <span class="picked-date"><em></em><asp:Label runat="server" ID="Lable1"></asp:Label></span>
                                        <tlk:RadCalendar RenderMode="Lightweight" ID="RadCalendar1" Width="100%" EnableMultiSelect="false" EnableKeyboardNavigation="true"
                                            ShowColumnHeaders="true" ShowDayCellToolTips="true" OnSelectionChanged="RadCalendar1_SelectionChanged" ShowRowHeaders="false" runat="server"
                                            AutoPostBack="true">
                                            <FastNavigationSettings EnableTodayButtonSelection="true"></FastNavigationSettings>
                                        </tlk:RadCalendar>
                                    </tlk:RadAjaxPanel>

                                </div>
                            </div>                        
                        </div>
                      </div><!-- /.box-body -->
                      <div class="box-footer">
                        <table style="width:100%;">
                            <tr>
                                <td style="text-align:right;vertical-align:middle;">
                                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-pinterest"  OnClick="btnCancelar_Click" />
                                    <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-primary" OnClick="btnRegistrar_Click" />
                                </td>
                            </tr>
                        </table>
                      </div><!-- box-footer -->
                    </div><!-- /.box -->
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnRegistrar" />
                </Triggers>
            </asp:UpdatePanel>
        </asp:Panel>

</asp:Content>

<asp:Content ID="Content7" ContentPlaceHolderID="cpFooterScript" runat="server">
    <script src="../Assets/js/telerik/scriptsTelerik.js"></script>
    <script>

        hand = new handlerRadClick("RadMenuContextual");
        var winRoles = null;

        function closeOpenWinRoles() {
            try {
                if (winRoles != null || winRoles != undefined) {
                    winRoles.dialog("destroy");
                }
            }
            catch (e) { }
        }

        function openWinRoles() {
            closeOpenWinRoles();
            winRoles = $("#<%= upWinRoles.ClientID%>").dialog({
                dialogClass: "col-md-6",
                width: "1e",
                autoOpen: false,
                close: function (event, ui) {
                    winRoles.dialog("destroy");
                }
            });

            winRoles.dialog("open");
        }

        
    </script>
</asp:Content>

