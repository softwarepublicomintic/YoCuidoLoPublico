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

namespace ElefantesBlancos.Controllers
{
      [HandleError(
      View = "ErrorPersonalizado",
      Master = "_Layout",
      Order = 0)]
    public class ImagenController : Controller
    {
        private moviles4Entities db = new moviles4Entities();

         [Authorize]
        public ActionResult GetImage()
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");
            ListImageModels objImageModels = new ListImageModels();
            objImageModels.ImageShort = (List<ImageModels>)Session["listPequeno"];
            objImageModels.ImageBig = (List<ImageModels>)Session["listaGrande"];
            return Json(objImageModels);
        }


         [Authorize]
        public ActionResult UpdateImage(int IdOld, int IdNew)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");
            Elefantes objElefantes = new Elefantes();
            objElefantes.ActualizarImagenPrincipal(IdOld, IdNew, (int)Session["UserID"], User.Identity.Name);
            
            ///Aqui para recargar nuevamente la vista
            ///
            
                int id = (int)Session["id"];
                stra_imagenes stra_imagenes = db.stra_imagenes.Find(id);
                if (stra_imagenes == null)
                {
                    return HttpNotFound();
                }

                List<EncabezadoImagen> list = new List<EncabezadoImagen>();
                List<ImageModels> listImagenesAprobadas = new List<ImageModels>();
                List<ImageModels> listImagenesAprobadasGrandes = new List<ImageModels>();
                int? Id_Imagen_Grande = 0;
                int? IdImagenPequena = 0;


                ViewBag.ImagenId = id;
                ViewBag.Rechazar = 0;
                ViewBag.Aprobar = 0;

                //Para llenar el encabezado de la view
                list = ConsultasBusqueda.ConsultaEncabezadoPorImagenId(id);
                foreach (EncabezadoImagen item in list)
                {
                    ViewBag.Estado = item.Estado;
                    ViewBag.Ubicacion = item.Ubicacion;
                    ViewBag.Fecha = item.Fecha;
                    ViewBag.Id = item.Id_stra_elefante;
                    Id_Imagen_Grande = item.Id_Imagen_Grande;
                    ViewBag.titulo = item.titulo;
                }

                //Busca las imagenes pequeñas
                listImagenesAprobadas = ConsultasBusqueda.ConsultaImagenesPequenaVisor(ViewBag.Id);

                foreach (ImageModels item in listImagenesAprobadas)
                {
                    item.Route = UtilsImagen.ObtenerRuta(item.Id);
                    if (item.Isprincipal == true)
                        IdImagenPequena = item.Id;

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
                if (Id_Imagen_Grande != 0)
                {
                    ViewBag.RutaImagenGrande = UtilsImagen.ObtenerRuta((int)Id_Imagen_Grande);
                }

                if (IdImagenPequena != 0)
                {
                    ViewBag.ImagenPrincipalPequena = UtilsImagen.ObtenerRuta((int)IdImagenPequena);
                }
                ViewBag.id_stra_razon_rechazo = new SelectList(db.stra_razones_rechazo.Where(r => r.id_stra_razon_rechazo != 2), "id_stra_razon_rechazo", "razon", stra_imagenes.id_stra_razon_rechazo);

                return View(stra_imagenes);          
        }

        
        //
        // GET: /Imagen/Edit/5
         [Authorize]
        public ActionResult Edit(int id = 0)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            stra_imagenes stra_imagenes = db.stra_imagenes.Find(id);
            string ruta = "";
            ruta = Server.MapPath("/ElefantesImagenes");
            if (stra_imagenes == null)
            {
                return HttpNotFound();
            }

            Session["id"] = id;

          
            List<EncabezadoImagen> list = new List<EncabezadoImagen>();
            List<ImageModels> listImagenesAprobadas = new List<ImageModels>();
            List<ImageModels> listImagenesAprobadasGrandes = new List<ImageModels>();
            int? Id_Imagen_Grande = 0;
            int? IdImagenPequena = 0;


            ViewBag.ImagenId = id;
            ViewBag.Rechazar = 0;
            ViewBag.Aprobar = 0;

            //Para llenar el encabezado de la view
            list = ConsultasBusqueda.ConsultaEncabezadoPorImagenId(id);
            foreach (EncabezadoImagen item in list)
            {
                ViewBag.Estado = item.Estado;
                ViewBag.Ubicacion = item.Ubicacion;
                ViewBag.Fecha = item.Fecha;
                ViewBag.Id = item.Id_stra_elefante;
                Id_Imagen_Grande = item.Id_Imagen_Grande;
                ViewBag.titulo = item.titulo;
                Session["tituloelefante"] = item.titulo;
            }

            //Busca las imagenes pequeñas
            listImagenesAprobadas = ConsultasBusqueda.ConsultaImagenesPequenaVisor(ViewBag.Id);

            foreach (ImageModels item in listImagenesAprobadas)
            {
                Imagen.CopiarCache((int)item.Id, ruta);
                item.Route = UtilsImagen.ObtenerRuta(item.Id);
                if (item.Isprincipal == true)
                    IdImagenPequena = item.Id;

            }
            Session["IdImagenPequena"] = IdImagenPequena;
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
            if (Id_Imagen_Grande != 0)
            {
                Imagen.CopiarCache((int)Id_Imagen_Grande, ruta);
                ViewBag.RutaImagenGrande = UtilsImagen.ObtenerRuta((int)Id_Imagen_Grande);
            }
            else
            {
                ViewBag.RutaImagenGrande = "../ElefantesImagenes";
            }

            if (IdImagenPequena != 0)
            {
                Imagen.CopiarCache((int)IdImagenPequena, ruta);
                ViewBag.ImagenPrincipalPequena = UtilsImagen.ObtenerRuta((int)IdImagenPequena);
            }
            else
            {
                ViewBag.ImagenPrincipalPequena = "../ElefantesImagenes";
            }
            ViewBag.id_stra_razon_rechazo = new SelectList(db.stra_razones_rechazo.Where(r => r.id_stra_razon_rechazo != 2), "id_stra_razon_rechazo", "razon", stra_imagenes.id_stra_razon_rechazo);
            return View(stra_imagenes);
        }

        //
        // POST: /Imagen/Edit/5
        [Authorize]
        [HttpPost]
        public ActionResult Edit(stra_imagenes stra_imagenes, string rechazar)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            List<EncabezadoImagen> list = new List<EncabezadoImagen>();
            List<ImagenesAprobadas> listImagenesAprobadas = new List<ImagenesAprobadas>();
            int? Id_Imagen_Grande = 0;
            int? IdImagenPequena = 0;
            bool boolvalidacion = false;

            if (ModelState.IsValid)
            {
                Imagenes objImagenes = new Imagenes();
                if (String.IsNullOrEmpty(rechazar))
                {

                    if (stra_imagenes.estado_imagen == 2)
                    {
                        ViewBag.Aprobar = '1';
                        ViewBag.Rechazar = '0';
                        ViewBag.ImagenId = stra_imagenes.id_stra_imagen;
                        list = ConsultasBusqueda.ConsultaEncabezadoPorImagenId(stra_imagenes.id_stra_imagen);
                        foreach (EncabezadoImagen item in list)
                        {
                            ViewBag.Estado = item.Estado;
                            ViewBag.Ubicacion = item.Ubicacion;
                            ViewBag.Fecha = item.Fecha;
                            ViewBag.Id = item.Id_stra_elefante;
                            Id_Imagen_Grande = item.Id_Imagen_Grande;
                            ViewBag.titulo = item.titulo;
                        }


                        ViewBag.Fotos = Session["listPequeno"];
                        IdImagenPequena = (int)Session["IdImagenPequena"];

                        if (Id_Imagen_Grande != 0)
                        {
                            ViewBag.RutaImagenGrande = UtilsImagen.ObtenerRuta((int)Id_Imagen_Grande);
                        }

                        if (IdImagenPequena != 0)
                        {
                            ViewBag.ImagenPrincipalPequena = UtilsImagen.ObtenerRuta((int)IdImagenPequena);
                        }

                        ViewBag.id_stra_razon_rechazo = new SelectList(db.stra_razones_rechazo.Where(r => r.id_stra_razon_rechazo != 2), "id_stra_razon_rechazo", "razon", stra_imagenes.id_stra_razon_rechazo);
                        return View(stra_imagenes);

                    }
                    objImagenes.ActualizarEstadoImagenes(stra_imagenes.id_stra_imagen, 
                                                         (int)Session["UserID"], 
                                                         User.Identity.Name, 
                                                         (string)Session["tituloelefante"]);


                }
                else
                {
                    //Validacion de rechazo
                    if (stra_imagenes.estado_imagen == 2)
                        boolvalidacion = false;
                    else
                        boolvalidacion = true;

                    if (stra_imagenes.id_stra_razon_rechazo == null)
                        boolvalidacion = true;
                    else if (stra_imagenes.id_stra_razon_rechazo == 1)
                    {
                        if (String.IsNullOrEmpty(stra_imagenes.razon_rechazo))
                            boolvalidacion = true;
                        else
                            boolvalidacion = false;
                    }
                    else
                        boolvalidacion = false;

                    if (boolvalidacion)
                    {
                        ViewBag.Rechazar = '1';
                        ViewBag.Aprobar = '0';
                        ViewBag.ImagenId = stra_imagenes.id_stra_imagen;
                        list = ConsultasBusqueda.ConsultaEncabezadoPorImagenId(stra_imagenes.id_stra_imagen);
                        foreach (EncabezadoImagen item in list)
                        {
                            ViewBag.Estado = item.Estado;
                            ViewBag.Ubicacion = item.Ubicacion;
                            ViewBag.Fecha = item.Fecha;
                            ViewBag.Id = item.Id_stra_elefante;
                            Id_Imagen_Grande = item.Id_Imagen_Grande;
                            ViewBag.titulo = item.titulo;
                        }

                        ViewBag.Fotos = Session["listPequeno"];
                        IdImagenPequena = (int)Session["IdImagenPequena"];
                        if (Id_Imagen_Grande != 0)
                        {
                            ViewBag.RutaImagenGrande = UtilsImagen.ObtenerRuta((int)Id_Imagen_Grande);
                        }

                        if (IdImagenPequena != 0)
                        {
                            ViewBag.ImagenPrincipalPequena = UtilsImagen.ObtenerRuta((int)IdImagenPequena);
                        }

                        ViewBag.id_stra_razon_rechazo = new SelectList(db.stra_razones_rechazo.Where(r => r.id_stra_razon_rechazo != 2), "id_stra_razon_rechazo", "razon", stra_imagenes.id_stra_razon_rechazo);
                        return View(stra_imagenes);

                    }

                    objImagenes.ActualizarRechazoImagen(stra_imagenes.id_stra_imagen, 
                                                        stra_imagenes.id_stra_razon_rechazo, 
                                                        stra_imagenes.razon_rechazo, 
                                                        (int)Session["UserID"],
                                                        User.Identity.Name,
                                                        (string)Session["tituloelefante"]);
                }
                List<ImageModels> listImagenesAprobadasGrandes = new List<ImageModels>();
                listImagenesAprobadasGrandes = (List<ImageModels>)Session["listaGrande"];
                foreach (ImageModels item in listImagenesAprobadasGrandes)
                {
                    Imagen.EliminarCache(item.Id, Server.MapPath("/ElefantesImagenes"));
                }
                Session["listPequeno"] = null;
                Session["listaGrande"] = null;
                Session["ruta"] = null;
                Session["tituloelefante"] = null;
                return RedirectToAction("Index", "Home");
            }

            ViewBag.ImagenId = stra_imagenes.id_stra_imagen;
            list = ConsultasBusqueda.ConsultaEncabezadoPorImagenId(stra_imagenes.id_stra_imagen);
            foreach (EncabezadoImagen item in list)
            {
                ViewBag.Estado = item.Estado;
                ViewBag.Ubicacion = item.Ubicacion;
                ViewBag.Fecha = item.Fecha;
                ViewBag.Id = item.Id_stra_elefante;
                Id_Imagen_Grande = item.Id_Imagen_Grande;
                ViewBag.titulo = item.titulo;
            }

            ViewBag.Fotos = Session["listPequeno"];
            IdImagenPequena = (int)Session["IdImagenPequena"];
            if (Id_Imagen_Grande != 0)
            {
                ViewBag.RutaImagenGrande = UtilsImagen.ObtenerRuta((int)Id_Imagen_Grande);
            }

            if (IdImagenPequena != 0)
            {
                ViewBag.ImagenPrincipalPequena = UtilsImagen.ObtenerRuta((int)IdImagenPequena);
            }

            ViewBag.id_stra_razon_rechazo = new SelectList(db.stra_razones_rechazo.Where(r => r.id_stra_razon_rechazo != 2), "id_stra_razon_rechazo", "razon", stra_imagenes.id_stra_razon_rechazo);
            return View(stra_imagenes);
        }

     

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