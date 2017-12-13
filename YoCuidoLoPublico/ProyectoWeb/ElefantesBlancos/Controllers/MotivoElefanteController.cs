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
      [HandleError(
      View = "ErrorPersonalizado",
      Master = "_Layout",
      Order = 0)]
    public class MotivoElefanteController : Controller
    {
        private moviles4Entities db = new moviles4Entities();

        //
        // GET: /MotivoElefante/
        [Authorize]
        public ActionResult Index()
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            return View(db.stra_motivos_elefante.ToList());
        }

        //

        [Authorize]
        [HttpGet]
        public ActionResult CreatePartialView()
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            return PartialView("CreatePartialView");
        }
        [Authorize]
        [HttpPost]
        public ActionResult CreatePartialView(string motivo)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            bool IsValidate = db.stra_motivos_elefante.Any(r => r.motivo == motivo);
            if (!IsValidate)
            {
                stra_motivos_elefante motivos = new stra_motivos_elefante();
                motivos.motivo = motivo;
                db.stra_motivos_elefante.Add(motivos);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            else
            {
                ModelState.AddModelError("", "La razón de rechazo ya existe");
                return RedirectToAction("Index");

            }

        }
        [Authorize]
        [HttpPost]
        public ActionResult Create(string motivo)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            if (motivo != "")
            {
                stra_motivos_elefante motivos = new stra_motivos_elefante();
                motivos.motivo = motivo;
                db.stra_motivos_elefante.Add(motivos);
                db.SaveChanges();
                List<stra_motivos_elefante> listMotivo = new List<stra_motivos_elefante>();
                listMotivo = db.stra_motivos_elefante.ToList();
                return View(listMotivo);
            }
            else
            {
                ModelState.AddModelError("", "El usuario se encuentra inactivo");
                return PartialView("CreatePartialView");
            }

        }

        //
        // GET: /MotivoElefante/Edit/5
        [Authorize]
        public ActionResult Edit(int id = 0)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            stra_motivos_elefante stra_motivos_elefante = db.stra_motivos_elefante.Find(id);
            if (stra_motivos_elefante == null)
            {
                return HttpNotFound();
            }
            return View(stra_motivos_elefante);
        }

        //
        // POST: /MotivoElefante/Edit/5
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(stra_motivos_elefante stra_motivos_elefante)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            if (ModelState.IsValid)
            {
                db.Entry(stra_motivos_elefante).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(stra_motivos_elefante);
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
            stra_motivos_elefante stra_motivos_elefante = db.stra_motivos_elefante.Find(intID);
            if (stra_motivos_elefante == null)
            {
                return HttpNotFound();
            }


            return PartialView("EditPartialView", stra_motivos_elefante);
        }

        [Authorize]
        [HttpPost]
        public ActionResult EditPartialView(string Id, string motivo)
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            bool IsValidate = db.stra_motivos_elefante.Any(r => r.motivo == motivo);
            if (!IsValidate)
            {
            
                int intID = Convert.ToInt32(Id);
                stra_motivos_elefante stra_motivos_elefante = db.stra_motivos_elefante.Find(intID);
                stra_motivos_elefante.motivo = motivo;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            else
            {
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