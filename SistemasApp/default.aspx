<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="SistemasApp._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>MONITOREO DB | Login</title>    
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link href="~/Assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="~/Assets/css/iu-explorador.css" rel="stylesheet" />  
    <link href="~/Assets/css/AdminLTE.min.css" rel="stylesheet" />      
    <link href="~/Assets/css/main.css" rel="stylesheet" />

    <link href="~/Assets/css/pschecker/pschecker.css" rel="stylesheet" />
    <%--<script src="~/Assets/js/jquery-3.1.1.min.js"></script>--%>
    <asp:PlaceHolder ID="PlaceHolder1" runat="server">
        <%: Scripts.Render("~/bundles/jquery") %>
        <%: Scripts.Render("~/bundles/pschecker") %>
        <%: Scripts.Render("~/bundles/jquery1.4") %>
        <%: Scripts.Render("~/bundles/notify") %>
    </asp:PlaceHolder>
    
    <script type="text/javascript">

        function Notificacion(mensaje, issuccess) 
        {
            var typeMessage = '';
            if (issuccess == 1)
                typeMessage = 'success';
            else typeMessage = 'warn';

            $.notify(mensaje, typeMessage);
        }

    </script>

</head>
<body style="background:#222d32;color:#FFF;">
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager">
                <Scripts>
                </Scripts>
            </asp:ScriptManager>

    <div class="container" id="divDatosSesion" runat="server">
        <div class="row" style="margin-top:20%;">            
            <div class="col-xs-offset-1 col-xs-10 col-sm-offset-4 col-sm-4" >
                <div class="form-horizontal" >
                    <div class="form-group" >
                        <asp:Panel ID="pnlMensajeError" runat="server"  >
                            <div class="callout callout-danger lead">                    
                                <asp:Label ID="lblMensajeError" runat="server" Text="erro" style="font-size:medium;" ></asp:Label>
                            </div>
                        </asp:Panel>
                    </div>
                    <div class="form-group" >
                        <label for="" class="control-label" >Usuario</label>
                        <asp:TextBox ID="tbUsuario" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group" >
                        <label for="" class="control-label" >Contraseña</label>
                        <asp:TextBox ID="tbPass" runat="server" CssClass="form-control" TextMode="Password" ></asp:TextBox>
                    </div>                   
                    <div class="form-group" >
                        <asp:CheckBox ID="chkCerrarSesiones" runat="server" CssClass="list-check-square-war" Text="Cerrar sesiones abiertas" Checked="false" />
                    </div> 
                    <asp:Button ID="btnIniciarSesion" runat="server" Text="Iniciar Sesión" CssClass="btn btn-primary" style="float:right;" OnClick="btnIniciarSesion_Click" OnClientClick="blockPage() " />
                </div>
            </div>
        </div>
    </div>

        <!-------------------MODAL EDICION DE CONTRASEÑA VENCIDA--------------------------->
        <div class="container" runat="server" id="divActualizaPassVencida">
            <div class="row" style="margin-top: 20%;">
                <div class="col-xs-offset-1 col-xs-10 col-sm-offset-4 col-sm-4">
                    <div class="form-horizontal">
                        <asp:Panel ID="pnlMensajeErrorPass" runat="server"  >
                            <div class="callout callout-danger lead">                    
                                <asp:Label ID="lblMensajeErrorPass" runat="server" Text="erro" style="font-size:medium;" ></asp:Label>
                                <asp:Label ID="lbUsr" runat="server" Text="" Visible="false" style="font-size:medium;" ></asp:Label>
                            </div>
                        </asp:Panel>
                        <div class="password-container">
                            <div class="form-group">
                                <label class="col-lg-4 contPagina-label" id="diverror3">Contraseña Actual</label>
                                <div class="col-lg-8 ">
                                    <asp:TextBox ID="txtLastPass" runat="server" CssClass="form-contPagina" BackColor="GrayText" TextMode="Password"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="password-container">
                            <div class="form-group">
                                <label class="col-lg-4 contPagina-label" >Nueva Contraseña</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="txtNewPass" class="strong-password" BackColor="GrayText" runat="server" TextMode="Password"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-4 contPagina-label">Confirmar contraseña</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="txtConfirmPass" runat="server" class="strong-password" BackColor="GrayText" TextMode="Password"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group strength-indicator">
                                <div class="meter">
                                </div>
                                <span class="MensajeError" style="font-size: 15px; background-color: aliceblue; border-radius: 7px 0px 7px 7px; color: gray; padding: 15px; float: left;" id="PassError2">
                                    <i class="fa fa-exclamation-circle text-primary" style="font-size: 20px;"></i>&nbsp;<span style="font-size: 20px;" class="text-primary">Error en la contraseña</span><br />
                                    Verifica los datos Mínimo 9 carácteres alfanuméricos, al menos 3 números y un carácter especial entre ($@$!%*?&).
                                </span>
                            </div>
                        </div>
                        <asp:Button ID="btnUpdatePassVencida" runat="server" Enabled="false" Text="Actualizar contraseña" CssClass="btn btn-primary" Style="float: right;" OnClick="btnActualizaPassVencida_Click" OnClientClick="blockPage() " />
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        function blockPage() {
            $("body").append("<div class='cargando' style='z-index:300001;' ></div>");
        }

        /*
        mvg 18-12-2017
        */
        $(document).ready(function () {


            $('.password-container').pschecker({ onPasswordValidate: validatePassword, onPasswordMatch: matchPassword });
            var submitbutton = $('.submit-button');
            var errorBox = $('.error');
            errorBox.css('visibility', 'hidden');
            submitbutton.attr("disabled", "disabled");
            //this function will handle onPasswordValidate callback, which mererly checks the password against minimum length
            function validatePassword(isValid) {
                if (!isValid)
                    errorBox.css('visibility', 'visible');
                else
                    errorBox.css('visibility', 'hidden');
            }
            //this function will be called when both passwords match
            function matchPassword(isMatched) {
                if (isMatched) {
                    submitbutton.addClass('unlocked').removeClass('locked');
                    submitbutton.removeAttr("disabled", "disabled");
                }
                else {
                    submitbutton.attr("disabled", "disabled");
                    submitbutton.addClass('locked').removeClass('unlocked');
                }
            }
        });
        $("#txtNewPass").keyup(function (){ VerificaContraseñas(); });

        $("#txtConfirmPass").keyup(function () { VerificaContraseñas(); });

        $("#txtLastPass").keyup(function () { VerificaContraseñas(); });

        function Exp_Reg_ValidaPass(Pass) {
            return (/^(?=.*[A-Za-z])(?=(.*\d){3,})(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{9,}$/).test(Pass);
        }

        function VerificaContraseñas()
        {
            if ($("#txtLastPass").val() != "") {

                if (!Exp_Reg_ValidaPass($("#txtNewPass").val())) {
                    $("#btnUpdatePassVencida").prop("disabled", true);
                    $("#PassError2").show();

                    if (!Exp_Reg_ValidaPass($("#txtConfirmPass").val())) {

                        $("#btnUpdatePassVencida").prop("disabled", true);
                        $("#PassError2").show();
                    }
                    else {
                        if ($("#txtNewPass").val() == $("#txtConfirmPass").val()) {
                            $("#btnUpdatePassVencida").prop("disabled", false);
                            $("#PassError2").hide();
                        }
                        else {
                            $("#btnUpdatePassVencida").prop("disabled", true);
                            $("#PassError2").show();
                        }

                    }


                }
                else {
                    if (!Exp_Reg_ValidaPass($("#txtNewPass").val())) {

                        $("#btnUpdatePassVencida").prop("disabled", true);
                        $("#PassError2").show();
                    }
                    else {

                        if ($("#txtNewPass").val() == $("#txtConfirmPass").val())
                        {

                            $("#btnUpdatePassVencida").prop("disabled", false);
                            $("#PassError2").hide();
                        }
                        else {
                            $("#btnUpdatePassVencida").prop("disabled", true);
                            $("#PassError2").show();
                        }
                    }
                }
            }
            else
            {
                $("#txtLastPass").focus();


                $("#btnUpdatePassVencida").prop("disabled", true);
            }
           
        }

    </script>
</body>
</html>

