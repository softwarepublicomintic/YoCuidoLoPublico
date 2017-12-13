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
    public class RangoTiempoController : Controller
    {
        private moviles4Entities db = new moviles4Entities();

        private readonly List<ListData> itemData = new List<ListData>{
            new ListData { value = "0", text = "0" },
            new ListData { value = "1", text = "1" },
            new ListData { value = "2", text = "2" },
            new ListData { value = "3", text = "3" },
            new ListData { value = "4", text = "4" },
            new ListData { value = "5", text = "5" },
            new ListData { value = "6", text = "6" },
            new ListData { value = "7", text = "7" },
            new ListData { value = "8", text = "8" },
            new ListData { value = "9", text = "9" },
            new ListData { value = "10", text = "10" },
            new ListData { value = "11", text = "11" },
            new ListData { value = "12", text = "12" },
            new ListData { value = "13", text = "13" },
            new ListData { value = "14", text = "14" },
            new ListData { value = "15", text = "15" },
            new ListData { value = "16", text = "16" },
            new ListData { value = "17", text = "17" },
            new ListData { value = "18", text = "18" },
            new ListData { value = "19", text = "19" },
            new ListData { value = "20", text = "20" }
            };
        //
        // GET: /RangoTiempo/
        [Authorize]
        public ActionResult Index()
        {
            List<ListData> itemtres = new List<ListData>{
            new ListData { value = "Meses", text = "Meses" },
            new ListData { value = "Años", text = "Años" },         
            };
            ViewBag.uno = new SelectList(itemData, "value", "text");
            ViewBag.dos = new SelectList(itemData, "value", "text");
            ViewBag.tres = new SelectList(itemtres, "value", "text");
            return View(db.stra_rango_tiempo.ToList());
        }

        [Authorize]
        [HttpGet]
        public ActionResult CreatePartialView()
        {            
            List<ListData> itemtres = new List<ListData>{
            new ListData { value = "Meses", text = "Meses" },
            new ListData { value = "Años", text = "Años" },         
            };
            ViewBag.uno = new SelectList(itemData, "value", "text");
            ViewBag.dos = new SelectList(itemData, "value", "text");
            ViewBag.tres = new SelectList(itemtres, "value", "text");
            return PartialView("CreatePartialView");
        }

        [Authorize]
        [HttpPost]
        public ActionResult CreatePartialView(string tiempouno, string tiempodos, string periodo)
        {           
            if (tiempouno != null)
            {
                string name = "";
                name = "Entre " + tiempouno + " y " + tiempodos + " " + periodo;
                bool IsValidate = db.stra_rango_tiempo.Any(r => r.rango_tiempo == name);
                if (!IsValidate)
                {
                    stra_rango_tiempo tiempo = new stra_rango_tiempo();
                    tiempo.rango_tiempo = name;
                    db.stra_rango_tiempo.Add(tiempo);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {                    
                    return RedirectToAction("Index");

                }
            }
            return RedirectToAction("Index");
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
            string cadena = "";
            string value = "";
            stra_rango_tiempo stra_rango_tiempo = db.stra_rango_tiempo.Find(intID);
            if (stra_rango_tiempo == null)
            {
                return HttpNotFound();
            }

            List<ListData> itemtres = new List<ListData>{
            new ListData { value = "Meses", text = "Meses" },
            new ListData { value = "Años", text = "Años" },         
            };
            cadena = stra_rango_tiempo.rango_tiempo;
            cadena = cadena.Remove(0, 5);
            string[] words = cadena.Split(' ');
            value = words[1];
            ViewBag.uno = new SelectList(itemData, "value", "text", value);
            ViewBag.dos = new SelectList(itemData, "value", "text",  words[3]);
            ViewBag.tres = new SelectList(itemtres, "value", "text", words[4]);
            return PartialView("EditPartialView", stra_rango_tiempo);
        }

        [Authorize]
        [HttpPost]
        public ActionResult EditPartialView(string Id, string ListadoUno, string ListadoDos, string ListadoTres)
        {           
            if (ListadoUno != null)
            {
                string name = "";
                name = "Entre " + ListadoUno + " y " + ListadoDos + " " + ListadoTres;
                bool IsValidate = db.stra_rango_tiempo.Any(r => r.rango_tiempo == name);
                if (!IsValidate)
                {
                    int intID = Convert.ToInt32(Id);
                    stra_rango_tiempo stra_rango_tiempo = db.stra_rango_tiempo.Find(intID);
                    stra_rango_tiempo.rango_tiempo = name;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("", "El rango de tiempo ya existe");
                    return RedirectToAction("Index");
                }
            }
            return RedirectToAction("Index");
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