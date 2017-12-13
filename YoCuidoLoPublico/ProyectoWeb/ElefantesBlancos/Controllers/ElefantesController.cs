using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElefantesBlancosDatos.Models;
using ElefantesBlancosDatos;
using ElefantesBlancos.Utils;

using System.Drawing;
using System.Drawing.Imaging;
using System.Windows.Forms;
using System.IO;
using System.Text;
using System.Web.UI;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Drawing.Drawing2D;
using System.Runtime.InteropServices;
using System.Threading;

namespace ElefantesBlancos.Controllers
{
     [HandleError(
      View = "ErrorPersonalizado",
      Master = "_Layout",
      Order = 0)]
    public class ElefantesController : Controller
    {
        private moviles4Entities db = new moviles4Entities();
        private string ruta = "";
        private readonly List<ListData> itemData = new List<ListData>{
            new ListData { value = "1", text = "Todos" },
            new ListData { value = "2", text = "Imagénes Pendientes" },
            new ListData { value = "3", text = "Información Pendiente" },
            new ListData { value = "4", text = "Ya no es un elefante" },
            };

         [Authorize]
        public ActionResult GetImage()
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            ListImageModels objImageModels = new ListImageModels();
            objImageModels.ImageShort = (List<ImageModels>)Session["listPequeno"];
            objImageModels.ImageBig = (List<ImageModels>)Session["listaGrande"];
            return Json(objImageModels);
        }

        [Authorize]
        public ActionResult UpdateImage(int IdOld, int IdNew)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            List<EncabezadoModels> list = new List<EncabezadoModels>();
            List<ImageModels> listImagenesAprobadas = new List<ImageModels>();
            List<ImageModels> listImagenesAprobadasGrandes = new List<ImageModels>();
            Elefantes objElefantes = new Elefantes();
            objElefantes.ActualizarImagenPrincipal(IdOld, IdNew, (int)Session["UserID"], User.Identity.Name);

            ///Aqui para recargar nuevamente la vista
            ///

            int id = (int)Session["id"];
            stra_elefantes stra_elefantes = db.stra_elefantes.Find(id);
            if (stra_elefantes == null)
            {
                return HttpNotFound();
            }

            ViewBag.Id = id;
            list = ConsultasBusqueda.ConsultaEncabezado(id);
            foreach (EncabezadoModels item in list)
            {
                ViewBag.Estado = item.Estado;
                ViewBag.Ubicacion = item.Ubicacion;
                ViewBag.Fecha = item.Fecha;
                ViewBag.Noesunelefante = item.NoesunElefante;
            }
            if (stra_elefantes.id_stra_imagen_principal_grande != null)
            {
                Session["ruta"] = UtilsImagen.ObtenerRuta((int)stra_elefantes.id_stra_imagen_principal_grande);
                ViewBag.ruta = Session["ruta"];
            }
            ViewBag.id_stra_motivo_elefante = new SelectList(db.stra_motivos_elefante, "id_stra_motivo_elefante", "motivo", stra_elefantes.id_stra_motivo_elefante);
            ViewBag.id_stra_rango_tiempo = new SelectList(db.stra_rango_tiempo, "id_stra_rango_tiempo", "rango_tiempo", stra_elefantes.id_stra_rango_tiempo);

            //Busca las imagenes pequeñas
            listImagenesAprobadas = ConsultasBusqueda.ConsultaImagenesPequenaVisor(ViewBag.Id);

            foreach (ImageModels item in listImagenesAprobadas)
            {
                item.Route = UtilsImagen.ObtenerRuta(item.Id);
            }
            //busca la ruta de las imagenes grandes
            listImagenesAprobadasGrandes = ConsultasBusqueda.ConsultaImagenesGrandesVisor(ViewBag.Id);
            foreach (ImageModels item in listImagenesAprobadasGrandes)
            {
                item.Route = UtilsImagen.ObtenerRuta(item.Id);

            }

            Session["listPequeno"] = listImagenesAprobadas;
            Session["listaGrande"] = listImagenesAprobadasGrandes;
            ViewBag.Fotos = Session["listPequeno"];

           return null;

        }

        [Authorize]
        public ActionResult Exportarfoto()
        {
            Bitmap bitmap = new Bitmap(1366, 768);
            Graphics graphics = Graphics.FromImage(bitmap as System.Drawing.Image);
            graphics.CopyFromScreen(0, 0, 0, 0, bitmap.Size);
            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();
            bitmap.Save(memoryStream, System.Drawing.Imaging.ImageFormat.Jpeg);


            byte[] bytes = memoryStream.GetBuffer();
            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = "application/octet-stream";
            Response.AddHeader("content-disposition", "attachment; filename=report.jpg");
            Response.BinaryWrite(bytes);
            Response.Flush();

            return null;
           
        }


       [Authorize]
        public ActionResult ExportarMapaPrincipal()
        {
         
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }

            string url1 = Request.Url.AbsoluteUri;
            string[] cadena = url1.Split('/');
          
            string url = cadena[0] + @"//" + cadena[2] + @"/Export/MapaPrincipal";
            //string url2 = "http://" + Request.Url.Authority + "/Export/MapaPrincipal";

            string fileName = "MapaPrincipal" + " " + DateTime.Now.ToString("yyyy/MM/dd HH:mm") + ".jpg";
            Thread thread = new Thread(delegate()
            {
               
                using (WebBrowser browser = new WebBrowser())
                {
                    browser.ScrollBarsEnabled = false;
                    browser.AllowNavigation = true;
                    browser.Navigate(url);
                    browser.Width = 1024;
                    browser.Height = 768;
                    browser.DocumentCompleted += new WebBrowserDocumentCompletedEventHandler(DocumentCompleted);
                    while (browser.ReadyState != WebBrowserReadyState.Complete)
                    {
                        System.Windows.Forms.Application.DoEvents();
                    }
                }
            });
            thread.SetApartmentState(ApartmentState.STA);
            thread.Start();
            thread.Join();
            Dispose();
            byte[] fileBytes = (byte[])Session["bytes"]; 
            Session["bytes"] = null; 
            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
        }

       

        private void DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
        {
            WebBrowser browser = sender as WebBrowser;
            
            using (Bitmap bitmap = new Bitmap(browser.Width, browser.Height))
            {
                browser.DrawToBitmap(bitmap, new System.Drawing.Rectangle(0, 0, browser.Width, browser.Height));
                using (MemoryStream stream = new MemoryStream())
                {
                    bitmap.Save(stream, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] bytes = stream.ToArray();
                    Session["bytes"] = bytes;
                    //Response.Buffer = true;
                    //Response.Clear();
                    //Response.ContentType = "application/octet-stream";
                    //Response.AddHeader("content-disposition", "attachment; filename=" + Session["strnombre"]);
                    //Response.BinaryWrite(bytes);
                    //Response.Flush();
                }
            }
        }

        [Authorize]
        public ActionResult ExportarMapaEstado(string Id)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }

            string url1 = Request.Url.AbsoluteUri;
            string[] cadena = url1.Split('/');

            string url = cadena[0] + @"//" + cadena[2] + @"/Export/MapaPorEstado/" + Id;
            //string url = "http://" + Request.Url.Authority + "/Export/MapaPorEstado/" + Id;
            ViewBag.tipomapa = Id;
            string fileName = "";

            if (String.IsNullOrEmpty(Id))
                fileName = "MapaPorEstado" + " " + DateTime.Now.ToString("yyyy/MM/dd HH:mm") + ".jpg";
            else if (Id == "1")
                fileName = "MapaValidados" + " " + DateTime.Now.ToString("yyyy/MM/dd HH:mm") + ".jpg";
            else if (Id == "2")
                fileName = "MapaPendiente" + " " + DateTime.Now.ToString("yyyy/MM/dd HH:mm") + ".jpg";
            else if (Id == "3")
                fileName = "MapaImagenesPendiente" + " " + DateTime.Now.ToString("yyyy/MM/dd HH:mm") + ".jpg";
            else if (Id == "4")
                fileName = "MapaInformacionPendiente" + " " + DateTime.Now.ToString("yyyy/MM/dd HH:mm") + ".jpg";

            Thread thread = new Thread(delegate()
            {
                using (WebBrowser browser = new WebBrowser())
                {
                    browser.ScrollBarsEnabled = false;
                    browser.AllowNavigation = true;
                    browser.Navigate(url);
                    browser.Width = 1024;
                    browser.Height = 768;
                    browser.DocumentCompleted += new WebBrowserDocumentCompletedEventHandler(DocumentCompleted);
                    while (browser.ReadyState != WebBrowserReadyState.Complete)
                    {
                        System.Windows.Forms.Application.DoEvents();
                    }
                }
            });
            thread.SetApartmentState(ApartmentState.STA);
            thread.Start();
            thread.Join();
            thread.Abort();
            Dispose();
            byte[] fileBytes = (byte[])Session["bytes"];
            Session["bytes"] = null;
            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
        }

         
         [Authorize]
        public ActionResult MapaPrincipal()
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            Session["Redireccionar"] = "2";
            MapaPrincipalModels objMapa = new MapaPrincipalModels();
            List<Elefantesregionmodels> ListElefantes;
            objMapa.Pendiete = ConsultasBusqueda.CantidadElefantesBlancosPendientes().ToString() + " Reportes";
            objMapa.Imagenes = ConsultasBusqueda.CantidadImagenesPendientes().ToString() + " Fotos Reportes";
            objMapa.NuevaInformacion = ConsultasBusqueda.CantidadInformacionPendiente().ToString() + " Nueva Información";
            objMapa.Validados = ConsultasBusqueda.CantidadElefantesBlancosAprobados().ToString() + "Reportes";
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

        [Authorize]
        public ActionResult MapaPorEstado(string Id)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            Session["Redireccionar"] = "2";
            MapaModels objMapa = new MapaModels();
            List<Elefantesregionmodels> ListElefantes = new List<Elefantesregionmodels>();
            int intId = 0;
            objMapa.Pendiete = ConsultasBusqueda.CantidadElefantesBlancosPendientes().ToString() + " Reportes";
            objMapa.Imagenes = ConsultasBusqueda.CantidadImagenesPendientes().ToString() + " Fotos Reportes";
            objMapa.NuevaInformacion  = ConsultasBusqueda.CantidadInformacionPendiente().ToString() + " Nueva Información";
            objMapa.Validados = ConsultasBusqueda.CantidadElefantesBlancosAprobados().ToString() + " Reportes";
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
        //
   
         [Authorize]
         [HttpGet]
         public ActionResult InformacionMunicipio(string Id)
         {
             if (Session["EsAdmin"] == null)
                 return RedirectToAction("Login", "Account");
             ResumenMunicipio(Id);
             if (Request.IsAjaxRequest())
                 return PartialView("InformacionMunicipio");
             else
                return View();
         }

         [Authorize]
         [HttpGet]
        public ActionResult ElefantesMap(string Id)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

          
            if (!String.IsNullOrEmpty(Id))
            {
                ViewBag.MunicipioSelector = Id;
                ViewBag.DepartamentoSelector = db.stra_municipios.Find(Id).id_stra_departamento;
                ViewBag.RegionSelector = db.stra_departamentos.Find(ViewBag.DepartamentoSelector).id_stra_region;
            }
            else
            {
                ViewBag.DepartamentoSelector = "11";
                ViewBag.MunicipioSelector = "11001";
                ViewBag.RegionSelector = "2";
            }

            Session["Redireccionar"] = ViewBag.MunicipioSelector;
            int intRegion = Convert.ToInt32(ViewBag.RegionSelector);
            ViewBag.regiones = new SelectList(ConsultasBusqueda.ConsultaRegionesSinElefantesRechazados(), "Id_stra_region", "nombre", intRegion);
            ViewBag.departamentos = new SelectList(ConsultasBusqueda.ConsultaDepartamentosTodos(), "Id_stra_departamento", "nombre", ViewBag.DepartamentoSelector);
            ViewBag.municipios = new SelectList(ConsultasBusqueda.ConsultaMunicipiosTodos(), "Id_stra_municipio", "nombre", ViewBag.MunicipioSelector);
            ViewBag.estados = new SelectList(ConsultasBusqueda.ConsultaEstadosSinRechazados(), "id_stra_estado_elefante", "nombre");
            ViewBag.validados = new SelectList(itemData, "value", "text");
            return View();
        }

        [Authorize]
        [HttpGet]
        public ActionResult ConsultaDepartamento(string Id)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            int intRegion = Convert.ToInt32(Id);
            ViewBag.nombreregion = db.stra_regiones.Find(intRegion).nombre;
            ViewBag.departamentos = new SelectList(ConsultasBusqueda.ConsultaDepartamentosPorRegion(intRegion), "Id_stra_departamento", "nombre", ViewBag.DepartamentoSelector);
            ViewBag.municipios = new SelectList(ConsultasBusqueda.ConsultaMunicipiosPorRegion(intRegion), "Id_stra_municipio", "nombre", ViewBag.MunicipioSelector);
            return PartialView("ConsultaDepartamento");
        }

        [Authorize]
        [HttpPost]
        public ActionResult ConsultaDepartamento(string DepartamentoSelector, string MunicipioSelector)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }

            return RedirectToAction("ElefantesMap", "Elefantes", new { Id = MunicipioSelector });
        }

        private void ResumenMunicipio(string municipio = "0")
        {
            List<ElefanteModels> ListElefantes = Elefantes.ConsultasElefantesPorMunicipio(municipio);
            Session["Redireccionar"] = municipio;
            if (ListElefantes.Count == 0)
            {
                ViewBag.nombreregion = " ";
                ViewBag.nombredepartamento = " ";
                ViewBag.nombremunicipio = " ";
                ViewBag.yanoesunelefante = "0";
                ViewBag.elefantependientes = "0";
                ViewBag.elefantevalidados = "0";
                ViewBag.imagenespendientes = "0";
                ViewBag.informacionpendiente = "0";
            }
            else
            {
                ViewBag.nombreregion = ListElefantes[0].region;
                ViewBag.nombredepartamento = ListElefantes[0].departamento;
                ViewBag.nombremunicipio = ListElefantes[0].municipio;
                ViewBag.yanoesunelefante = Elefantes.CantidadElefantesYanoesunelefante(municipio);
                ViewBag.elefantependientes = ListElefantes.Where(l => l.id_stra_estado_elefante == 1).Count();
                ViewBag.elefantevalidados = Elefantes.CantidadElefantesValidados(municipio);
                ViewBag.imagenespendientes = Elefantes.CantidadImagenesPendientes(municipio);
                ViewBag.informacionpendiente = Elefantes.CantidadInformacionPendiente(municipio);
            }
        }

        public JsonResult ObtenerUbicaciones(string municipio = "0", string estado = "0", string validados = "1")
        {
           
            Elefantes objElefantes = new Elefantes();
            List<stra_elefantes> elefante = objElefantes.ConsultaElefantesPorDivipola(municipio, estado, validados);
            ViewBag.directorio = Server.MapPath("");
            var data = (from m in elefante
                        select new
                        {
                            text = m.latitud + "|" + m.longitud + "|" + m.titulo + "|" + m.direccion + "|" + m.id_stra_estado_elefante + "|" + m.no_es_un_elefante,
                            value = m.id_stra_elefante,
                        }).ToList();

            if (data.Count > 0)
                ViewBag.primerreg = data[0].text;
            else
                ViewBag.primerreg = "";

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        // GET: /Elefantes/Details/5

         [Authorize]
        public ActionResult Details(int id = 0)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

           List<EncabezadoModels> list = new List<EncabezadoModels>();
           stra_elefantes stra_elefantes = db.stra_elefantes.Find(id);
            ruta = Server.MapPath("/ElefantesImagenes");
            if (stra_elefantes == null)
            {
                return HttpNotFound();
            }

            ViewBag.Id = id;
            list = ConsultasBusqueda.ConsultaEncabezado(id);
            foreach (EncabezadoModels item in list)
            {
                ViewBag.Estado = item.Estado;
                ViewBag.Ubicacion = item.Ubicacion;
                ViewBag.Fecha = item.Fecha;
            }

            if (stra_elefantes.id_stra_imagen_principal_grande != null)
            {
                Imagen.CopiarCache((int)stra_elefantes.id_stra_imagen_principal_grande, ruta);
                ViewBag.ruta = UtilsImagen.ObtenerRuta((int)stra_elefantes.id_stra_imagen_principal_grande);
            }
            else
            {
                ViewBag.ruta = ruta;
            }
            ViewBag.id_stra_motivo_elefante = new SelectList(db.stra_motivos_elefante, "id_stra_motivo_elefante", "motivo", stra_elefantes.id_stra_motivo_elefante);
            ViewBag.id_stra_rango_tiempo = new SelectList(db.stra_rango_tiempo, "id_stra_rango_tiempo", "rango_tiempo", stra_elefantes.id_stra_rango_tiempo);
            ViewBag.id_stra_razon_rechazo = new SelectList(db.stra_razones_rechazo.Where(r => r.id_stra_razon_rechazo != 2), "id_stra_razon_rechazo", "razon", stra_elefantes.id_stra_razon_rechazo);
            return View(stra_elefantes);
        }

       
        // GET: /Elefantes/Edit/5
         [Authorize]
        public ActionResult Edit(int id = 0)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            List<EncabezadoModels> list = new List<EncabezadoModels>();
            ruta = Server.MapPath("/ElefantesImagenes");
#if DEBUG
         //   ruta = @"D:\RepositorioImagenes";
#endif


            stra_elefantes stra_elefantes = db.stra_elefantes.Find(id);
            Session["elefantes"] = stra_elefantes;

            if (stra_elefantes == null)
            {
                return HttpNotFound();
            }

            ViewBag.Id = id;
            list = ConsultasBusqueda.ConsultaEncabezado(id);
            foreach (EncabezadoModels item in list)
            {
                ViewBag.Estado = item.Estado;
                ViewBag.Ubicacion = item.Ubicacion;
                ViewBag.Fecha = item.Fecha;
            }

            if (stra_elefantes.id_stra_imagen_principal_grande != null)
            {
                Imagen.CopiarCache((int)stra_elefantes.id_stra_imagen_principal_grande, ruta, true);
                Session["ruta"] = UtilsImagen.ObtenerRuta((int)stra_elefantes.id_stra_imagen_principal_grande);
                ViewBag.ruta = Session["ruta"];
            }
            else
            {
                Session["ruta"] = ruta;
                ViewBag.ruta = Session["ruta"];
            }

            ViewBag.Aprobar = '0';
            ViewBag.Rechazar = '0';
            ViewBag.id_stra_motivo_elefante = new SelectList(db.stra_motivos_elefante, "id_stra_motivo_elefante", "motivo", stra_elefantes.id_stra_motivo_elefante);
            ViewBag.id_stra_rango_tiempo = new SelectList(db.stra_rango_tiempo, "id_stra_rango_tiempo", "rango_tiempo", stra_elefantes.id_stra_rango_tiempo);
            ViewBag.id_stra_razon_rechazo = new SelectList(db.stra_razones_rechazo.Where(r => r.id_stra_razon_rechazo !=2), "id_stra_razon_rechazo", "razon", stra_elefantes.id_stra_razon_rechazo);
            return View(stra_elefantes);
        }

        //
        // POST: /Elefantes/Edit/5

         [Authorize]
        [HttpPost]
        public ActionResult Edit(stra_elefantes stra_elefantes, string rechazar)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            List<EncabezadoModels> list = new List<EncabezadoModels>();
            bool boolvalidacion = false;
            if (ModelState.IsValid)
            {
                Elefantes objElefantes = new Elefantes();
                if (String.IsNullOrEmpty(rechazar))
                {

                    if ((stra_elefantes.estado_titulo == 2) || (stra_elefantes.estado_entidad == 2) || (stra_elefantes.estado_id_motivo_elefante == 2) || (stra_elefantes.estado_imagen == 2))
                    {
                        ViewBag.Aprobar = '1';
                        ViewBag.Rechazar = '0';
                        ViewBag.Id = stra_elefantes.id_stra_elefante;
                        list = ConsultasBusqueda.ConsultaEncabezado(stra_elefantes.id_stra_elefante);
                        foreach (EncabezadoModels item in list)
                        {
                            ViewBag.Estado = item.Estado;
                            ViewBag.Ubicacion = item.Ubicacion;
                            ViewBag.Fecha = item.Fecha;
                        }

                        ViewBag.ruta = Session["ruta"];
                        ViewBag.id_stra_motivo_elefante = new SelectList(db.stra_motivos_elefante, "id_stra_motivo_elefante", "motivo", stra_elefantes.id_stra_motivo_elefante);
                        ViewBag.id_stra_rango_tiempo = new SelectList(db.stra_rango_tiempo, "id_stra_rango_tiempo", "rango_tiempo", stra_elefantes.id_stra_rango_tiempo);
                        ViewBag.id_stra_razon_rechazo = new SelectList(db.stra_razones_rechazo.Where(r => r.id_stra_razon_rechazo != 2), "id_stra_razon_rechazo", "razon", stra_elefantes.id_stra_razon_rechazo);
                        return View(stra_elefantes);

                    }
                    string contratista = "";
                    if (!String.IsNullOrEmpty(stra_elefantes.contratista))
                    { contratista = stra_elefantes.contratista; }
                    objElefantes.ActualizarAprobacionElefantes(stra_elefantes.id_stra_elefante,
                                                     stra_elefantes.titulo,
                                                     stra_elefantes.estado_titulo,
                                                     stra_elefantes.entidad_responsable,
                                                     stra_elefantes.estado_entidad,
                                                     stra_elefantes.id_stra_motivo_elefante,
                                                     stra_elefantes.estado_id_motivo_elefante,
                                                     stra_elefantes.id_stra_rango_tiempo,
                                                     stra_elefantes.estado_id_rango_tiempo,
                                                     stra_elefantes.costo,
                                                     stra_elefantes.estado_costo,
                                                     stra_elefantes.contratista,
                                                     stra_elefantes.estado_contratista,
                                                     (int)stra_elefantes.id_stra_imagen_principal_grande,
                                                     (int)stra_elefantes.id_stra_imagen_principal_pequena,
                                                     (stra_elefantes)Session["elefantes"],
                                                     (int)Session["UserID"],
                                                     User.Identity.Name);
                }
                else
                {
                    //Validacion de rechazo
                    if ((stra_elefantes.estado_titulo == 2) || (stra_elefantes.estado_entidad == 2) || (stra_elefantes.estado_id_motivo_elefante == 2) || (stra_elefantes.estado_imagen == 2))
                    {
                        boolvalidacion = false;
                    }
                    else
                    {
                        boolvalidacion = true;
                    }

                    if (stra_elefantes.id_stra_razon_rechazo == null)
                        boolvalidacion = true;
                    else if (stra_elefantes.id_stra_razon_rechazo == 1) 
                        if (String.IsNullOrEmpty(stra_elefantes.comentario_rechazo))
                            boolvalidacion = true;
                        else
                            boolvalidacion = false;
                    else
                        boolvalidacion = false;

                        if (boolvalidacion)
                        {
                            ViewBag.Rechazar = '1';
                            ViewBag.Aprobar = '0';
                            ViewBag.ruta = Session["ruta"];
                            ViewBag.Id = stra_elefantes.id_stra_elefante;
                            list = ConsultasBusqueda.ConsultaEncabezado(stra_elefantes.id_stra_elefante);
                            foreach (EncabezadoModels item in list)
                            {
                                ViewBag.Estado = item.Estado;
                                ViewBag.Ubicacion = item.Ubicacion;
                                ViewBag.Fecha = item.Fecha;
                            }

                            ViewBag.id_stra_motivo_elefante = new SelectList(db.stra_motivos_elefante, "id_stra_motivo_elefante", "motivo", stra_elefantes.id_stra_motivo_elefante);
                            ViewBag.id_stra_rango_tiempo = new SelectList(db.stra_rango_tiempo, "id_stra_rango_tiempo", "rango_tiempo", stra_elefantes.id_stra_rango_tiempo);
                            ViewBag.id_stra_razon_rechazo = new SelectList(db.stra_razones_rechazo.Where(r => r.id_stra_razon_rechazo != 2), "id_stra_razon_rechazo", "razon", stra_elefantes.id_stra_razon_rechazo);
                            return View(stra_elefantes);

                        }
                    
                    objElefantes.ActualizarRechazoElefantes(stra_elefantes.id_stra_elefante,
                                                     stra_elefantes.id_stra_razon_rechazo,
                                                     stra_elefantes.comentario_rechazo,
                                                     stra_elefantes.titulo,
                                                     stra_elefantes.estado_titulo,
                                                     stra_elefantes.entidad_responsable,
                                                     stra_elefantes.estado_entidad,
                                                     stra_elefantes.id_stra_motivo_elefante,
                                                     stra_elefantes.estado_id_motivo_elefante,
                                                     (int)stra_elefantes.id_stra_imagen_principal_grande,
                                                     (int)stra_elefantes.id_stra_imagen_principal_pequena, 
                                                     (stra_elefantes)Session["elefantes"],
                                                     (int)Session["UserID"],
                                                     User.Identity.Name);
                }
                Session["elefantes"] = null;
                Imagen.EliminarCache((int)stra_elefantes.id_stra_imagen_principal_grande, Server.MapPath("/ElefantesImagenes"));
               if ((string)Session["Redireccionar"] == "1")
                    return RedirectToAction("Index", "Home");
                else
                    return RedirectToAction("ElefantesMap", "Elefantes", new { Id = Session["Redireccionar"] });
            }

           

            ViewBag.Id = stra_elefantes.id_stra_elefante;
            list = ConsultasBusqueda.ConsultaEncabezado(stra_elefantes.id_stra_elefante);

            if(stra_elefantes.estado_contratista == null)
            {
                stra_elefantes.estado_contratista = 1;
            }

            foreach (EncabezadoModels item in list)
            {
                ViewBag.Estado = item.Estado;
                ViewBag.Ubicacion = item.Ubicacion;
                ViewBag.Fecha = item.Fecha;
            }

            ViewBag.id_stra_motivo_elefante = new SelectList(db.stra_motivos_elefante, "id_stra_motivo_elefante", "motivo", stra_elefantes.id_stra_motivo_elefante);
            ViewBag.id_stra_rango_tiempo = new SelectList(db.stra_rango_tiempo, "id_stra_rango_tiempo", "rango_tiempo", stra_elefantes.id_stra_rango_tiempo);
            ViewBag.id_stra_razon_rechazo = new SelectList(db.stra_razones_rechazo.Where(r => r.id_stra_razon_rechazo != 2), "id_stra_razon_rechazo", "razon", stra_elefantes.id_stra_razon_rechazo);
            return View(stra_elefantes);
        }


        //Aprobar
        // GET: /Elefantes/Edit/5
         [Authorize]
        public ActionResult Aprobado(int id = 0)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");
            List<EncabezadoModels> list = new List<EncabezadoModels>();
            List<ImageModels> listImagenesAprobadas = new List<ImageModels>();
            List<ImageModels> listImagenesAprobadasGrandes = new List<ImageModels>();
            Session["id"] = id;
            stra_elefantes stra_elefantes = db.stra_elefantes.Find(id);
            Session["elefantes"] = stra_elefantes;
            ruta = Server.MapPath("/ElefantesImagenes");
            if (stra_elefantes == null)
            {
                return HttpNotFound();
            }

            ViewBag.Id = id;
            ViewBag.Cantidad = ConsultasBusqueda.CantidadImagenesPendientes(id);
            if ((stra_elefantes.id_stra_rango_tiempo != null) &&  (stra_elefantes.estado_id_rango_tiempo == 0))
                ViewBag.Cantidad = 2;
            else if ((stra_elefantes.costo != null) && (stra_elefantes.estado_costo == 0))
                ViewBag.Cantidad = 3;
            else if ((stra_elefantes.contratista != null) && (stra_elefantes.estado_costo == 0))
                ViewBag.Cantidad = 4;

            list = ConsultasBusqueda.ConsultaEncabezado(id);
            foreach (EncabezadoModels item in list)
            {
                ViewBag.Estado = item.Estado;
                ViewBag.Ubicacion = item.Ubicacion;
                ViewBag.Fecha = item.Fecha;
                ViewBag.Noesunelefante = item.NoesunElefante;
            }
            if (stra_elefantes.id_stra_imagen_principal_grande != null)
            {
                Imagen.CopiarCache((int)stra_elefantes.id_stra_imagen_principal_grande, ruta, true);
                Session["ruta"] = UtilsImagen.ObtenerRuta((int)stra_elefantes.id_stra_imagen_principal_grande);
                ViewBag.ruta = Session["ruta"];
            }
            ViewBag.id_stra_motivo_elefante = new SelectList(db.stra_motivos_elefante, "id_stra_motivo_elefante", "motivo", stra_elefantes.id_stra_motivo_elefante);
            ViewBag.id_stra_rango_tiempo = new SelectList(db.stra_rango_tiempo, "id_stra_rango_tiempo", "rango_tiempo", stra_elefantes.id_stra_rango_tiempo);

            //Busca las imagenes pequeñas
            listImagenesAprobadas = ConsultasBusqueda.ConsultaImagenesPequenaVisor(ViewBag.Id);

            foreach (ImageModels item in listImagenesAprobadas)
            {            
                Imagen.CopiarCache((int)item.Id, ruta);
                item.Route = UtilsImagen.ObtenerRuta(item.Id);
             }
            //busca la ruta de las imagenes grandes
            listImagenesAprobadasGrandes = ConsultasBusqueda.ConsultaImagenesGrandesVisor(ViewBag.Id);
            foreach (ImageModels item in listImagenesAprobadasGrandes)
            {
                Imagen.CopiarCache((int)item.Id, ruta);
                item.Route = UtilsImagen.ObtenerRuta(item.Id);

            }

            Session["listPequeno"] = listImagenesAprobadas;
            Session["listaGrande"] = listImagenesAprobadasGrandes;
            ViewBag.Fotos = Session["listPequeno"];

            return View(stra_elefantes);
        }

        //
        // POST: /Elefantes/Edit/5
         [Authorize]
        [HttpPost]
        public ActionResult Aprobado(int Id,
                                    string titulo,
                                    string entidad,
                                    string Motivo,
                                    string tiempo,
                                    string costo,
                                    string contratista,
                                    string estadotiempo,
                                    string estadocosto,
                                    string estadocontratista,
                                    string noesunelefante)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            if (Id > 0)
            {
                int intRago = 0;
                sbyte intEstadoRango = 0;
                long lngCosto = 0;
                sbyte intEstadoCosto = 0;
                sbyte intEstadoContratista = 0;
                ViewBag.ruta = Session["ruta"];

                if (!String.IsNullOrEmpty(tiempo))
                    intRago = int.Parse(tiempo);

                if (!String.IsNullOrEmpty(estadotiempo))
                    intEstadoRango = sbyte.Parse(estadotiempo);

                if (!String.IsNullOrEmpty(costo))
                    lngCosto = long.Parse(costo);

                if (!String.IsNullOrEmpty(estadocosto))
                    intEstadoCosto = sbyte.Parse(estadocosto);

                if (!String.IsNullOrEmpty(estadocontratista))
                    intEstadoContratista = sbyte.Parse(estadocontratista);

                Elefantes objElefantes = new Elefantes();
                objElefantes.ActualizarElefantesAprobados(Id,
                                                         titulo,
                                                         entidad,
                                                         int.Parse(Motivo),
                                                         intRago,
                                                         intEstadoRango,
                                                         lngCosto,
                                                         intEstadoCosto,
                                                         contratista,
                                                         intEstadoContratista,
                                                         (stra_elefantes)Session["elefantes"],
                                                         (int)Session["UserID"],
                                                         User.Identity.Name);

                if (noesunelefante == "True")
                {
                    objElefantes.ActualizarYaNoEsUnElefante(Id, (int)Session["UserID"], User.Identity.Name);
                }
                List<ImageModels> listImagenesAprobadasGrandes = new List<ImageModels>();
                listImagenesAprobadasGrandes =(List<ImageModels>) Session["listaGrande"];
               foreach (ImageModels item in listImagenesAprobadasGrandes)
                {
                    Imagen.EliminarCache(item.Id, Server.MapPath("/ElefantesImagenes"));
                }
                Session["listPequeno"] = null;
                Session["listaGrande"] = null;
                Session["ruta"] = null;
                if ((string)Session["Redireccionar"] == "1")
                    return Json(new { redirectUrl = Url.Action("Index", "Home"), isRedirect = true });
                else
                   return Json(new { redirectUrl = Url.Action("ElefantesMap", "Elefantes", new { Id = Session["Redireccionar"] }), isRedirect = true });

            }

            //return View(stra_elefantes);
            return Json(new { redirectUrl = Url.Action("Index", "Home"), isRedirect = true });
        }

         [Authorize]
        [HttpPost]
        public ActionResult Actualizar(int Id )
        {           
            if (Id > 0)
            {
                Elefantes objElefantes = new Elefantes();
                objElefantes.ActualizarYaNoEsUnElefante(Id, (int)Session["UserID"],User.Identity.Name);

                return Json(new { redirectUrl = Url.Action("Index", "Home"), isRedirect = true });
               
            }

            return Json(new { redirectUrl = Url.Action("Index", "Home"), isRedirect = true });
         
        }

#region Json
        public JsonResult GetMunicipio(string departamento = null)
        {
            List<MunicipioModels> municipios;
            List<ListData> itemData = new List<ListData>();
            ListData item = new ListData();

            if (departamento == "0")
            {
                municipios = ConsultasBusqueda.ConsultaMunicipiosTodos();
                itemData = (from m in municipios
                            orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.Id_stra_municipio,
                            }).ToList();


            }
            else
            {
                municipios = ConsultasBusqueda.ConsultaMunicipiosPorDepartamento(departamento);
                itemData = (from m in municipios
                            orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.Id_stra_municipio,
                            }).ToList();
            }

            item.text = "Municipio";
            item.value = "0";
            itemData.Add(item);
            var data = itemData;
            ViewBag.MunicipioSelector = "0";
            ViewBag.DepartamentoSelector = departamento;
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMunicipioPorMunicipio(string municipio = null)
        {
            // ConsultasBusqueda objBusqueda = new ConsultasBusqueda();
            List<MunicipioModels> municipios = ConsultasBusqueda.ConsultaMunicipiosTodos();
            List<ListData> itemData = new List<ListData>();
            ListData item = new ListData();
            string departamento = "";

            if (municipio != "0")
            {
                departamento = (from m in municipios
                                where m.Id_stra_municipio.Equals(municipio)
                                select m).First().Id_stra_departamento;

                itemData = (from m in municipios
                            where m.Id_stra_departamento.Equals(departamento)
                            orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.Id_stra_municipio,
                            }).ToList();
            }
            else
            {
                itemData = (from m in municipios
                            orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.Id_stra_municipio,
                            }).ToList();
            }

            item.text = "Municipio";
            item.value = "0";
            itemData.Add(item);
            var data = itemData;
            ViewBag.MunicipioSelector = municipio;
            ViewBag.DepartamentoSelector = departamento;

            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetRegion(string departamento = null)
        {
            var data = "0";
            if (departamento != "0")
            {
                var departamentolist = from d in db.stra_departamentos_listado
                                       where d.id_stra_departamento.Equals(departamento)
                                       select d;


                foreach (var item in departamentolist)
                    data = item.id_stra_region.ToString();

                ViewBag.MunicipioSelector = "0";
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDepartamentoPorRegion(string region = null)
        {

            List<DepartamentoModels> departamentos = ConsultasBusqueda.ConsultaDepartamentosTodos();
            List<ListData> itemData = new List<ListData>();
            ListData item = new ListData();

            if (region == "0")
            {
                itemData = (from d in departamentos
                            orderby (d.nombre)
                            select new ListData
                            {
                                text = (d.nombre.Length > 26 ? d.nombre.Substring(0, 26) : d.nombre),
                                value = d.Id_stra_departamento
                            }).ToList();
            }
            else
            {
                itemData = (from d in departamentos
                            where d.Id_stra_region == int.Parse(region)
                            orderby (d.nombre)
                            select new ListData
                            {
                                text = (d.nombre.Length > 26 ? d.nombre.Substring(0, 26) : d.nombre),
                                value = d.Id_stra_departamento
                            }).ToList();
            }

            item.text = "Departamento";
            item.value = "0";
            itemData.Add(item);
            var data = itemData;
            ViewBag.RegionSelector = region;
            ViewBag.DepartamentoSelector = "0";
            ViewBag.MunicipioSelector = "0";

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDepartamentoTodos(string departamento = null)
        {

            List<DepartamentoModels> departamentos = ConsultasBusqueda.ConsultaDepartamentosTodos();
            List<ListData> itemData = new List<ListData>();
            ListData item = new ListData();

            if (departamento == "0")
            {
                itemData = (from d in departamentos
                            orderby (d.nombre)
                            select new ListData
                            {
                                text = (d.nombre.Length > 26 ? d.nombre.Substring(0, 26) : d.nombre),
                                value = d.Id_stra_departamento
                            }).ToList();
            }


            item.text = "Departamento";
            item.value = "0";
            itemData.Add(item);
            var data = itemData;
            ViewBag.RegionSelector = "0";
            ViewBag.DepartamentoSelector = "0";
            ViewBag.MunicipioSelector = "0";

            return Json(data, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetMunicipioPorRegion(string region = null)
        {

            List<MunicipioModels> municipios = ConsultasBusqueda.ConsultaMunicipiosTodos();
            List<ListData> itemData = new List<ListData>();
            ListData item = new ListData();

            if (region == "0")
            {
                itemData = (from m in municipios
                            orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.Id_stra_municipio
                            }).ToList();
            }
            else
            {
                itemData = (from m in municipios
                            where m.Id_stra_region == int.Parse(region)
                            orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.Id_stra_municipio
                            }).ToList();
            }



            item.text = "Municipio";
            item.value = "0";
            itemData.Add(item);
            var data = itemData;
            ViewBag.MunicipioSelector = "0";
            ViewBag.DepartamentoSelector = "0";
            ViewBag.RegionSelector = region;

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetRegionPorMunicipio(string municipio = null)
        {

            var data = "0";
            if (municipio != "0")
            {
                data = (from m in db.stra_municipios_listado
                        where m.id_stra_municipio.Equals(municipio)
                        select m).First().id_stra_region.ToString();


            }
            return Json(data, JsonRequestBehavior.AllowGet);

        }

        public JsonResult GetDepartamentoPorMunicipio(string municipio = null)
        {

            var data = "0";

            if (municipio != "0")
            {
                data = (from m in db.stra_municipios_listado
                        where m.id_stra_municipio.Equals(municipio)
                        select m).First().id_stra_departamento;

            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }


        public JsonResult ValidarSession()
        {
            var data = "1";
            if (Session["EsAdmin"] == null)
            {
                data = "0";

            }
            return Json(data, JsonRequestBehavior.AllowGet);

        }

#endregion
          
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        protected override void OnException(ExceptionContext filterContext)
        {
            string ruta = "";
            ruta = Server.MapPath("/Log");
            Log.WriteLog(ruta, filterContext.Exception.ToString());
        }
    }
}