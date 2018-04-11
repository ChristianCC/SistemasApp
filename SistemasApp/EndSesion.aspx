<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EndSesion.aspx.cs" Inherits="SistemasApp.EndSesion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script>
        function go(e) {
            setTimeout(e, 2000);
        }
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scriptManager" runat="server">
        </asp:ScriptManager>
    <div>
    <label>Tu sesión ha terminado</label>
    </div>
    </form>    
</body>    
</html>
