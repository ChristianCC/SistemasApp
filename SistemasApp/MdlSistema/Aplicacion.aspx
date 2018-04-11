<%@ Page Title="" Language="C#" MasterPageFile="~/MdlSistema/Shared/SistemaMaster.master" AutoEventWireup="true" CodeBehind="Aplicacion.aspx.cs" Inherits="SistemasApp.MdlSistema.Aplicacion" %>
<%@ MasterType VirtualPath="~/MdlSistema/Shared/SistemaMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
    <style>
        .frame-contenido
        {
                width: 100%;
                height: inherit;
                min-height: inherit;
                border: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpContenidoPrincipal" runat="server">    
    <iframe id="frameContenido" runat="server" class="frame-contenido" src=""  >        
    </iframe>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpFooterScript" runat="server">
    <script>
        var source = '';
        function navigateTo(target) {
            $(".contenido-ext").css("min-height", window.screen.height - 125)
            source = $(target).data("target");
            $("#<%= frameContenido.ClientID %>").on("load", function () {
                $("#<%= frameContenido.ClientID %>").unbind("load");
                refresh();
            });
            $("#<%= frameContenido.ClientID %>").attr("src",'loading.html');            
        }

        function refresh() {
            
            $("#<%= frameContenido.ClientID %>").attr("src", source);
        }
    </script>
</asp:Content>