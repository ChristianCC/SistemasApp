using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using SistemasApp.Common;

namespace SistemasApp
{
    public partial class EndSesion : System.Web.UI.Page
    {
        ParamEncrip paramEncrip = new ParamEncrip();

        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            if (!IsPostBack)
            {
                string url = " window.location.href = '"+ ResolveUrl("~/") ;

                if (paramEncrip["nurl"] != null)
                {
                    url += "?" + ParamEncrip.ObtenerParametrosPagina();
                }
                url += "'; ";
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "go", "go(\"" +url + "\")", true);
            }
            else
            {
            }

        }
    }
}