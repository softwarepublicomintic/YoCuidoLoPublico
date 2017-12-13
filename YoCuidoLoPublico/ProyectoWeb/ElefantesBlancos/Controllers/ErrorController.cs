using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElefantesBlancos.Controllers
{
    public class ErrorController : Controller
    {
        //
        // GET: /Error/

        public ActionResult FailWhale()
        {
            Response.StatusCode = 404;
            Response.TrySkipIisCustomErrors = true;
            return View();
        }

    }
}
