using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemasApp.MdlAdmin.Shared
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        #region metodos

        public void MostrarMensajeError(string msj)
        {
            lblMensajeError.Text = msj;
            pnlMsjError.Visible = true;
        }

        public void MostrarMensaje(string msj)
        {
            lblMensaje.Text = msj;
            pnlMsj.Visible = true;
        }

        public void CerrarMensajeError()
        {
            lblMensajeError.Text = "";
            pnlMsjError.Visible = false;
        }

        public void CerrarMensaje()
        {
            lblMensaje.Text = "";
            pnlMsj.Visible = false;
        }

        public void CerrarTodosLosMensajes()
        {
            this.CerrarMensaje();
            this.CerrarMensajeError();
        }


        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}