using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace SistemasApp
{
    public class BundleConfig
    {
        // Para obtener más información sobre la unión, visite http://go.microsoft.com/fwlink/?LinkId=254726
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/WebFormsJs").Include(
                  "~/Scripts/WebForms/WebForms.js",
                  "~/Scripts/WebForms/WebUIValidation.js",
                  "~/Scripts/WebForms/MenuStandards.js",
                  "~/Scripts/WebForms/Focus.js",
                  "~/Scripts/WebForms/GridView.js",
                  "~/Scripts/WebForms/DetailsView.js",
                  "~/Scripts/WebForms/TreeView.js",
                  "~/Scripts/WebForms/WebParts.js"));

            bundles.Add(new ScriptBundle("~/bundles/MsAjaxJs").Include(
                "~/Scripts/WebForms/MsAjax/MicrosoftAjax.js",
                "~/Scripts/WebForms/MsAjax/MicrosoftAjaxApplicationServices.js",
                "~/Scripts/WebForms/MsAjax/MicrosoftAjaxTimer.js",
                "~/Scripts/WebForms/MsAjax/MicrosoftAjaxWebForms.js"));

            //-------------------------------------------------------------------------------
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                "~/Assets/js/jquery-3.1.1.js"));

            bundles.Add(new ScriptBundle("~/bundles/jquery-ui").Include(
                "~/Assets/js/jquery-ui-effects.js",
                "~/Assets/js/jquery-ui-dialog.js"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                "~/Assets/js/bootstrap.js"));

            bundles.Add(new ScriptBundle("~/bundles/telerik").Include(
                "~/Assets/js/telerik/scriptsTelerik.js"));

            bundles.Add(new ScriptBundle("~/bundles/app").Include(
                "~/Assets/js/app.js",
                "~/Assets/js/main.js"));

            // Use la versión de desarrollo de Modernizr para desarrollar y aprender. Luego, cuando esté listo
            // para la producción, use la herramienta de creación en http://modernizr.com para elegir solo las pruebas que necesite
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                "~/Scripts/modernizr-*"));


            bundles.Add(new ScriptBundle("~/bundles/pschecker").Include(
               "~/Assets/js/pschecker/pschecker.js"));

            bundles.Add(new ScriptBundle("~/bundles/jquery1.4").Include(
                "~/Assets/js/jquery-1.4.4.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/notify").Include(
                "~/Assets/js/Notify/notify.js"));
        }
    }
}