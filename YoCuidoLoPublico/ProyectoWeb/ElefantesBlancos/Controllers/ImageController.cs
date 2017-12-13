using System;
using System.Collections.Generic;
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
    public class ImageController : Controller
    {
        #region Variable
        public static List<ImageModels> ObjImegeModelsList;
        #endregion

        public ActionResult ImageControl()
        {
            ObjImegeModelsList = new List<ImageModels>();
            for (int i = 0; i < 10; i++)
            {
                ImageModels objImageModels = new ImageModels();
                objImageModels.Id = i + 1;
                objImageModels.Route = "../Images/Slider/IMG_37" + (88 + i) + ".jpg";
                objImageModels.Tittle = "IMG_37" + (88 + i);
                objImageModels.Description = "IMG_37" + (88 + i);
                if (i == 7)
                {
                    objImageModels.Isprincipal = true;
                }
                else
                {
                    objImageModels.Isprincipal = false;
                }

                ObjImegeModelsList.Add(objImageModels);
            }

            return View();
        }

        public ActionResult GetImages()
        {
            ObjImegeModelsList = new List<ImageModels>();
            for (int i = 0; i < 10; i++)
            {
                ImageModels objImageModels = new ImageModels();
                objImageModels.Id = i + 1;
                objImageModels.Route = "../Images/Slider/IMG_37" + (88 + i) + ".jpg";
                objImageModels.Tittle = "IMG_37" + (88 + i);
                objImageModels.Description = "IMG_37" + (88 + i);
                if (i == 7)
                {
                    objImageModels.Isprincipal = true;
                }
                else
                {
                    objImageModels.Isprincipal = false;
                }

                ObjImegeModelsList.Add(objImageModels);
            }

            return Json(from resul in ObjImegeModelsList
                        orderby resul.Isprincipal descending
                        select resul);
        }

        public ActionResult UpdatePrincipalImages(int idOld, int idNew)
        {

            foreach (var items in ObjImegeModelsList)
            {
                if (items.Id == idOld)
                {
                    items.Isprincipal = false;
                }
                else
                {
                    if (items.Id == idNew)
                    {
                        items.Isprincipal = true;
                    }
                }
            }
            return null;
        }

        protected override void OnException(ExceptionContext filterContext)
        {
            string ruta = "";
            ruta = Server.MapPath("/Log");
            Log.WriteLog(ruta, filterContext.Exception.ToString());
        }

    }
}
