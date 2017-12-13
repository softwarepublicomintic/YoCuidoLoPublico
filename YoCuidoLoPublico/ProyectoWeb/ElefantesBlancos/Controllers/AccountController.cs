using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using DotNetOpenAuth.AspNet;
using Microsoft.Web.WebPages.OAuth;
using WebMatrix.WebData;
using ElefantesBlancos.Filters;
using ElefantesBlancos.Models;
using System.Configuration;
using ElefantesBlancosDatos.Models;
using ElefantesBlancosDatos;

namespace ElefantesBlancos.Controllers
{
    public class AccountController : Controller
    {
       
        // GET: /Account/Login

        [AllowAnonymous]
        [HandleError(
        View = "ErrorPersonalizado",
        Master = "_Layout",
        Order = 0)]
        public ActionResult Login(string returnUrl)
        {
            FormsAuthentication.SignOut();
            Session["EsAdmin"] = null;
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // POST: /Account/Login

        [AllowAnonymous]
        [HttpPost]
        public ActionResult Login(stra_usuarios model, string returnUrl)
        {

              using (moviles4Entities entities = new moviles4Entities())
                {

                    ElefantesBlancosDatos.Usuarios objUsuarios = new ElefantesBlancosDatos.Usuarios();
                    bool EsAdmin = false;
                    bool EsActivo = false;
                    bool EsPrimeraVez = false;
                    int id= 0;
                    List<stra_usuarios> ListUsuario = new List<stra_usuarios>();
                    string username = model.usuario;
                    string password = model.contrasena;
                    string encriptada = ElefantesBlancosDatos.Usuarios.encryptar(password);


                    ListUsuario = objUsuarios.ConsultarUsuarioValido(username, encriptada);

                    if (ListUsuario.Count > 0)
                    {
                        Session["Redireccionar"] = "1";
                        foreach (var item in ListUsuario)
                        {
                            if (item.id_stra_grupo == 1)
                                EsAdmin = true;
                            if (item.estado == 1)
                                EsActivo = true;
                            if (item.primera_vez == 1)
                                EsPrimeraVez = true;
                            id =item.id_stra_usuario;
                            Session["UserId"] = id;
                        }

                        if (EsActivo)
                        {

                            
                                FormsAuthentication.SetAuthCookie(username, false);
                                if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                                    && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                                {
                                    return Redirect(returnUrl);
                                }
                                else
                                {
                                    if (EsAdmin)
                                    {
                                        Session["EsAdmin"] = true;
                                        if (EsPrimeraVez)
                                            return RedirectToAction("Cambiarcontrasena", "Usuario", new { id = id });
                                        else
                                            return RedirectToAction("Administrador", "Home");
                                     
                                    }
                                    else
                                    {
                                        Session["EsAdmin"] = false;
                                        if (EsPrimeraVez)
                                            return RedirectToAction("Cambiarcontrasena", "Usuario",  new { id = id });
                                        else
                                            return RedirectToAction("Ingreso", "Home");
                                        
                                    }
                                }
                            
                        }
                        else
                        {
                            ModelState.AddModelError("", "El usuario se encuentra inactivo");
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("", "El usuario y/o el password son incorrectos");
                    }
                }

                       
            return View(model);
        }

        //
        // POST: /Account/LogOff

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();
           return RedirectToAction("Login", "Account");

        }

        protected override void OnException(ExceptionContext filterContext)
        {
            string ruta = "";
            ruta = Server.MapPath("/Log");
            Log.WriteLog(ruta, filterContext.Exception.ToString());
        }

        #region Helpers
        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        public enum ManageMessageId
        {
            ChangePasswordSuccess,
            SetPasswordSuccess,
            RemoveLoginSuccess,
        }

        internal class ExternalLoginResult : ActionResult
        {
            public ExternalLoginResult(string provider, string returnUrl)
            {
                Provider = provider;
                ReturnUrl = returnUrl;
            }

            public string Provider { get; private set; }
            public string ReturnUrl { get; private set; }

            public override void ExecuteResult(ControllerContext context)
            {
                OAuthWebSecurity.RequestAuthentication(Provider, ReturnUrl);
            }
        }

        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://go.microsoft.com/fwlink/?LinkID=177550 for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "User name already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A user name for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
        #endregion
    }
}
