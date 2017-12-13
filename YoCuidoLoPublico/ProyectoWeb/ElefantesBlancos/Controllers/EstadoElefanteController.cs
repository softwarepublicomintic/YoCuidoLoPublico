using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElefantesBlancosDatos.Models;
using ElefantesBlancosDatos;

namespace ElefantesBlancos.Controllers
{
    [Authorize]
    [HandleError(
    View = "ErrorPersonalizado",
    Master = "_Layout",
    Order = 0)]
    public class EstadoElefanteController : Controller
    {
        private moviles4Entities db = new moviles4Entities();

        //
        // GET: /EstadoElefante/
      [Authorize]
        public ActionResult Index()
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            return View(db.stra_estados_elefante.ToList());
        }

        //
        // GET: /EstadoElefante/Details/5
      [Authorize]
        public ActionResult Details(int id = 0)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            stra_estados_elefante stra_estados_elefante = db.stra_estados_elefante.Find(id);
            if (stra_estados_elefante == null)
            {
                return HttpNotFound();
            }
            return View(stra_estados_elefante);
        }

        //
        // GET: /EstadoElefante/Create
      [Authorize]
        public ActionResult Create()
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }  
          return View();
        }

        [Authorize]
        [HttpGet]
        public ActionResult EditPartialView(string id)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            int intID = Convert.ToInt32(id);
            ViewBag.Id = id;
            stra_estados_elefante stra_estados_elefante = db.stra_estados_elefante.Find(intID);
            if (stra_estados_elefante == null)
            {
                return HttpNotFound();
            }

            return PartialView("EditPartialView", stra_estados_elefante);
        }
        [Authorize]
        [HttpPost]
        public ActionResult EditPartialView(string Id, string nombre)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            bool IsValidate = db.stra_estados_elefante.Any(r => r.nombre == nombre);
            if (!IsValidate)
            {
                int intID = Convert.ToInt32(Id);
                stra_estados_elefante stra_estados_elefante = db.stra_estados_elefante.Find(intID);
                stra_estados_elefante.nombre = nombre;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            else
            {
                ModelState.AddModelError("", "El estado ya existe");
                return RedirectToAction("Index");

            }
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