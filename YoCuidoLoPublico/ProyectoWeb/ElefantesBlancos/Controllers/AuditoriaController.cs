using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using ElefantesBlancosDatos;
using ElefantesBlancosDatos.Models;
using ElefantesBlancos.Utils;
using System.Web.UI.WebControls;

namespace ElefantesBlancos.Controllers
{
       [HandleError(
        View = "ErrorPersonalizado",
        Master = "_Layout",
        Order = 0)]
    public class AuditoriaController : Controller
    {
        private AuditoriaEntities db = new AuditoriaEntities();

        
        // GET: /Auditoria/
         [Authorize]
        public ActionResult Index(string AccionSelector, string UsuarioSelector, string titulo, string inicio, string final)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            if (!String.IsNullOrEmpty(AccionSelector))
                ViewBag.accionId = AccionSelector;
            else
               ViewBag.accionId = "";
            
            if (!String.IsNullOrEmpty(titulo))
               ViewBag.buscartitulo = titulo;
            else
               ViewBag.buscartitulo = "";
            
            if (!String.IsNullOrEmpty(UsuarioSelector))
                ViewBag.usuarioID = UsuarioSelector;
            else
                ViewBag.usuarioID = "";

            if (!String.IsNullOrEmpty(inicio))
                ViewBag.fechainicio = inicio;
            else
                ViewBag.fechainicio = "";

            if (!String.IsNullOrEmpty(final))
                ViewBag.fechafinal = final;
            else
                ViewBag.fechafinal = "";

            LogicaAuditoria.ActualizarAdicionarFoto();
            List<ListUsuarios> usuarioList = Usuarios.ConsultarUsuariosActivos();
            Session["UsuarioList"] = usuarioList;
            ViewBag.Buscar = "0";
            ViewBag.Accion = new SelectList(db.stra_acciones.ToList(), "id_stra_accion", "nombre", ViewBag.accionId);
            ViewBag.Usuario = new SelectList(usuarioList, "value", "text", ViewBag.usuarioID);
            return View();
        }

        [Authorize]
        [HttpGet]
        public ActionResult Busqueda(string AccionSelector, string UsuarioSelector, string titulo, string inicio, string final, int? page)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");
            ViewBag.Buscar = "1";
            List<AuditoriaModels> listAudioria = new List<AuditoriaModels>();
            int UserID = 0;
            int AccionID = 0;
            if (!String.IsNullOrEmpty(AccionSelector))
            {
                ViewBag.accionId = AccionSelector;
                AccionID = Convert.ToInt32(AccionSelector);
            }
            else
                ViewBag.accionId = "";

            if (!String.IsNullOrEmpty(titulo))
                ViewBag.buscartitulo = titulo;
            else
                ViewBag.buscartitulo = "";

            if (!String.IsNullOrEmpty(UsuarioSelector))
            {
                ViewBag.usuarioID = UsuarioSelector;
                UserID = Convert.ToInt32(UsuarioSelector);
            }
            else
                ViewBag.usuarioID = "";

            if (!String.IsNullOrEmpty(inicio))
                ViewBag.fechainicio = inicio;
            else
                ViewBag.fechainicio = "01/25/2014";

            if (!String.IsNullOrEmpty(final))
                ViewBag.fechafinal = final;
            else
                ViewBag.fechafinal = "";

            if (page == null)
            {
                listAudioria = LogicaAuditoria.ConsultaAuditoria(inicio, final, titulo, UserID, AccionID);
                Session["listAudioria"] = listAudioria;
            }
            else
            {
                if (Session["listAudioria"] == null)
                {
                    listAudioria = LogicaAuditoria.ConsultaAuditoria(inicio, final, titulo, UserID, AccionID);
                    Session["listAudioria"] = listAudioria;
                }
                else
                {
                    listAudioria = (List<AuditoriaModels>)Session["listAudioria"];
                }
            }

            var auditoria = from l in listAudioria
                            select l;
            int pageSize = 10;
            int pageNumber = (page ?? 1);

            if (page == null)
                return PartialView("Listadoauditoria", auditoria.ToPagedList(pageNumber, pageSize));
            else
            {
                List<ListUsuarios> usuarioList;
                if (Session["UsuarioList"] == null)
                {
                    usuarioList = Usuarios.ConsultarUsuariosActivos();
                    Session["UsuarioList"] = usuarioList;
                }
                else
                    usuarioList = (List<ListUsuarios>)Session["UsuarioList"];

                ViewBag.Accion = new SelectList(db.stra_acciones.ToList(), "id_stra_accion", "nombre", ViewBag.accionId);
                ViewBag.Usuario = new SelectList(usuarioList, "value", "text", ViewBag.usuarioID);
                return View("Index", auditoria.ToPagedList(pageNumber, pageSize));
            }
            
        }

        public List<AuditoriaDatos> CargarInformacion()
        {
            List<AuditoriaDatos> listExportar = new List<AuditoriaDatos>();
            List<AuditoriaModels> listauditoria;

            listauditoria = (List<AuditoriaModels>)Session["listAudioria"];

            foreach (AuditoriaModels item in listauditoria)
            {
                AuditoriaDatos objExportar = new AuditoriaDatos();
                objExportar.Codigo = item.id_stra_elefante;
                objExportar.Titulo = item.titulo;
                 objExportar.FechaModificación = item.fecha_creacion.ToString("dd/MM/yyyy");
                 objExportar.Gestor = item.usuario;
                 objExportar.Tipo = item.tipo;
                 objExportar.Acción = item.accion;
                 objExportar.CambiosRealizados = item.datos;
                
                listExportar.Add(objExportar);
            }

            return listExportar;

        }

         [Authorize]
        public ActionResult Download()
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            if (Session["listAudioria"] != null)
            {
                List<AuditoriaDatos> listExportar = CargarInformacion();
                GridView gv = new GridView();
                gv.DataSource = listExportar;
                gv.DataBind();
                Dispose();
                string nombre = "Auditoria " +  " " + DateTime.Now.ToString("yyyy/MM/dd HH:mm") + ".xls";
                return new DownloadFileActionResult(gv, nombre);
            }
            else
            {
                return new JavaScriptResult();
            }
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