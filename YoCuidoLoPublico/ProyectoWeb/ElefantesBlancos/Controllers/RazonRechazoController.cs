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
    public class RazonRechazoController : Controller
    {
        private moviles4Entities db = new moviles4Entities();

        //
        // GET: /RazonRechazo/
        [Authorize]    
        public ActionResult Index()
        {
            if (Session["EsAdmin"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            return View(db.stra_razones_rechazo.ToList());
        }

        //
        [Authorize]
        [HttpGet]
        public ActionResult CreatePartialView()
        {
           
            return PartialView("CreatePartialView",  new stra_razones_rechazo());
        }

        //
        [Authorize]
        [HttpPost]
        public ActionResult CreatePartialView(string razon)
        {
            bool IsValidate = db.stra_razones_rechazo.Any(r => r.razon == razon);
            if (!IsValidate)
            {
                stra_razones_rechazo razones = new stra_razones_rechazo();
                razones.razon = razon;
                db.stra_razones_rechazo.Add(razones);
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
        [HttpGet]
        public ActionResult EditPartialView(string id)
        {                      
            int intID = Convert.ToInt32(id);
            ViewBag.Id = id;
            stra_razones_rechazo stra_razones_rechazo = db.stra_razones_rechazo.Find(intID);
            if (stra_razones_rechazo == null)
            {
                return HttpNotFound();
            }

            return PartialView("EditPartialView", stra_razones_rechazo);
        }

        [Authorize]
        [HttpPost]
        public ActionResult EditPartialView(string Id, string razon)
        {
            bool IsValidate = db.stra_razones_rechazo.Any(r => r.razon == razon);
            if (!IsValidate)
            {
                int intID = Convert.ToInt32(Id);
                stra_razones_rechazo stra_razones_rechazo = db.stra_razones_rechazo.Find(intID);
                stra_razones_rechazo.razon = razon;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            else
            {
                ModelState.AddModelError("", "La razón de rechazo ya existe");
                return RedirectToAction("Index");

            }
        }
        //
       
      

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