using ElefantesBlancosDatos;
using ElefantesBlancosDatos.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElefantesBlancos.Controllers
{
       [HandleError(
      View = "ErrorPersonalizado",
      Master = "_Layout",
      Order = 0)]
    public class ExportController : Controller
    {
     

        public ActionResult MapaPrincipal()
        {
            MapaPrincipalModels objMapa = new MapaPrincipalModels();
            List<Elefantesregionmodels> ListElefantes;
            objMapa.Pendiete = " Reportes";
            objMapa.Imagenes =  " Fotos Reportes";
            objMapa.NuevaInformacion = " Nueva Información";
            objMapa.Validados = " Reportes";
            objMapa.InsularImagen = "0";
            objMapa.InsularInformacion = "0";
            objMapa.InsularPendiente = "0";
            objMapa.InsularValidados = "0";
            objMapa.AmazoniaImagen = "0";
            objMapa.AmazoniaInformacion = "0";
            objMapa.AmazoniaPendiente = "0";
            objMapa.AmazoniaValidados = "0";
            objMapa.AndinaImagen = "0";
            objMapa.AndinaInformacion = "0";
            objMapa.AndinaPendiente = "0";
            objMapa.AndinaValidados = "0";
            objMapa.AtlanticaImagen = "0";
            objMapa.AtlanticaInformacion = "0";
            objMapa.AtlanticaPendiente = "0";
            objMapa.AtlanticaValidados = "0";
            objMapa.OrinoquiaImagen = "0";
            objMapa.OrinoquiaInformacion = "0";
            objMapa.OrinoquiaPendiente = "0";
            objMapa.OrinoquiaValidados = "0";
            objMapa.PacificaImagen = "0";
            objMapa.PacificaInformacion = "0";
            objMapa.PacificaPendiente = "0";
            objMapa.PacificaValidados = "0";

            //ElefantesValidados
            ListElefantes = new List<Elefantesregionmodels>();
            ListElefantes = Elefantes.ConsultaElefantesValidados();

            foreach (var item in ListElefantes)
            {
                if (item.id_stra_region == 1)
                    objMapa.AtlanticaValidados = item.cantidad.ToString();
                else if (item.id_stra_region == 2)
                    objMapa.AndinaValidados = item.cantidad.ToString();
                else if (item.id_stra_region == 3)
                    objMapa.PacificaValidados = item.cantidad.ToString();
                else if (item.id_stra_region == 4)
                    objMapa.OrinoquiaValidados = item.cantidad.ToString();
                else if (item.id_stra_region == 5)
                    objMapa.AmazoniaValidados = item.cantidad.ToString();
                else if (item.id_stra_region == 6)
                    objMapa.InsularValidados = item.cantidad.ToString();

            }

            // ElefantesPendientes
            ListElefantes = new List<Elefantesregionmodels>();
            ListElefantes = Elefantes.ConsultaElefantesPendientes();
            foreach (var item in ListElefantes)
            {
                if (item.id_stra_region == 1)
                    objMapa.AtlanticaPendiente = item.cantidad.ToString();
                else if (item.id_stra_region == 2)
                    objMapa.AndinaPendiente = item.cantidad.ToString();
                else if (item.id_stra_region == 3)
                    objMapa.PacificaPendiente = item.cantidad.ToString();
                else if (item.id_stra_region == 4)
                    objMapa.OrinoquiaPendiente = item.cantidad.ToString();
                else if (item.id_stra_region == 5)
                    objMapa.AmazoniaPendiente = item.cantidad.ToString();
                else if (item.id_stra_region == 6)
                    objMapa.InsularPendiente = item.cantidad.ToString();

            }

            // ImagenesPendientes
            ListElefantes = new List<Elefantesregionmodels>();
            ListElefantes = Elefantes.ConsultaElefantesFotosPendientes();
            foreach (var item in ListElefantes)
            {
                if (item.id_stra_region == 1)
                    objMapa.AtlanticaImagen = item.cantidad.ToString();
                else if (item.id_stra_region == 2)
                    objMapa.AndinaImagen = item.cantidad.ToString();
                else if (item.id_stra_region == 3)
                    objMapa.PacificaImagen = item.cantidad.ToString();
                else if (item.id_stra_region == 4)
                    objMapa.OrinoquiaImagen = item.cantidad.ToString();
                else if (item.id_stra_region == 5)
                    objMapa.AmazoniaImagen = item.cantidad.ToString();
                else if (item.id_stra_region == 6)
                    objMapa.InsularImagen = item.cantidad.ToString();

            }

            // InformacionPendiente
            ListElefantes = new List<Elefantesregionmodels>();
            ListElefantes = Elefantes.ConsultaElefantesNuevaInformacion();
            foreach (var item in ListElefantes)
            {
                if (item.id_stra_region == 1)
                    objMapa.AtlanticaInformacion = item.cantidad.ToString();
                else if (item.id_stra_region == 2)
                    objMapa.AndinaInformacion = item.cantidad.ToString();
                else if (item.id_stra_region == 3)
                    objMapa.PacificaInformacion = item.cantidad.ToString();
                else if (item.id_stra_region == 4)
                    objMapa.OrinoquiaInformacion = item.cantidad.ToString();
                else if (item.id_stra_region == 5)
                    objMapa.AmazoniaInformacion = item.cantidad.ToString();
                else if (item.id_stra_region == 6)
                    objMapa.InsularInformacion = item.cantidad.ToString();

            }
            return View(objMapa);
        }


        public ActionResult MapaPorEstado(string Id)
        {
            MapaModels objMapa = new MapaModels();
            List<Elefantesregionmodels> ListElefantes = new List<Elefantesregionmodels>();
            int intId = 0;
            objMapa.Pendiete =  " Reportes";
            objMapa.Imagenes = " Fotos Reportes";
            objMapa.NuevaInformacion =  " Nueva Información";
            objMapa.Validados = " Reportes";
            objMapa.Insular = "0";
            objMapa.Amazonia = "0";
            objMapa.Andina = "0";
            objMapa.Atlantica = "0";
            objMapa.Orinoquia = "0";
            objMapa.Pacifica = "0";

            if (!String.IsNullOrEmpty(Id))
            {
                ViewBag.tipomapa = Id;
                intId = Convert.ToInt32(Id);
            }
            else
            {
                ViewBag.tipomapa = "1";
                intId = 1;
            }


            switch (intId)
            {
                case 1:
                    ListElefantes = Elefantes.ConsultaElefantesValidados();
                    break;
                case 2:
                    ListElefantes = Elefantes.ConsultaElefantesPendientes();
                    break;
                case 3:
                    ListElefantes = Elefantes.ConsultaElefantesFotosPendientes();
                    break;
                case 4:
                    ListElefantes = Elefantes.ConsultaElefantesNuevaInformacion();
                    break;
                default:
                    ListElefantes = Elefantes.ConsultaElefantesValidados();
                    break;
            }


            foreach (var item in ListElefantes)
            {
                if (item.id_stra_region == 1)
                    objMapa.Atlantica = item.cantidad.ToString();
                else if (item.id_stra_region == 2)
                    objMapa.Andina = item.cantidad.ToString();
                else if (item.id_stra_region == 3)
                    objMapa.Pacifica = item.cantidad.ToString();
                else if (item.id_stra_region == 4)
                    objMapa.Orinoquia = item.cantidad.ToString();
                else if (item.id_stra_region == 5)
                    objMapa.Amazonia = item.cantidad.ToString();
                else if (item.id_stra_region == 6)
                    objMapa.Insular = item.cantidad.ToString();

            }
            return View(objMapa);
        }

        protected override void OnException(ExceptionContext filterContext)
        {
            string ruta = "";
            ruta = Server.MapPath("/Log");
            Log.WriteLog(ruta, filterContext.Exception.ToString());
        }

    }
}
