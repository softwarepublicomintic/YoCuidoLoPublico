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
    public class UsuarioController : Controller
    {
        private moviles4Entities db = new moviles4Entities();

        //
        // GET: /Usuario/
        [Authorize]
        public ActionResult Index()
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            List<stra_usuarios> list = new List<stra_usuarios>();
            list = db.stra_usuarios.ToList();


#if DEBUG

            list.Add(new stra_usuarios
            {
                apellidos = "Lopez",
                cargo = "Admin",
                celular = "3102569879",
                ConfirmarClave = "NO",
                contrasena = "123456",
                correo_electronico = "prueba@asesoftware.com",
                entidad = "MIn TIC",
                estado = 1,
                id_stra_grupo = 1,
                id_stra_usuario = 1,
                nombres = "Harry",
                nombre_estado = "Admin",
                NuevaClave = "1",
                primera_vez = 1,
                segundo_apellido = "Vargas",
                segundo_nombre = "",
                telefono = "123456",
                usuario = "hlopez",
                ViejaClave = "234567"
            });

#endif

            foreach (var item in list)
            {
                if (item.estado == 1)
                    item.nombre_estado = "Activo";
                else
                    item.nombre_estado = "Inactivo";
            }
            return View(list);
        }

        //
        // GET: /Usuario/Details/5
        [Authorize]
        public ActionResult Details(int id = 0)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            stra_usuarios stra_usuarios = db.stra_usuarios.Find(id);
            if (stra_usuarios == null)
            {
                return HttpNotFound();
            }
            return View(stra_usuarios);
        }

        //
        // GET: /Usuario/Create
        [Authorize]
        public ActionResult Create()
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            ViewBag.Validar = '0';
            ViewBag.id_stra_grupo = new SelectList(db.stra_grupos, "id_stra_grupo", "descripcion");
            return View();
        }



        //
        // POST: /Usuario/Create
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(stra_usuarios stra_usuarios)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            Usuarios objUsuarios = new Usuarios();
            List<stra_usuarios> listUsuarios = new List<stra_usuarios>();

            listUsuarios = objUsuarios.ConsultaUsuario(stra_usuarios.correo_electronico);

            if (listUsuarios.Count == 0)
            {
                ViewBag.Validar = '0';

                string segundonombre = "";
                string segundoApellido = "";
                if (!String.IsNullOrEmpty(stra_usuarios.segundo_nombre))
                    segundonombre = stra_usuarios.segundo_nombre.Trim();
                if (!String.IsNullOrEmpty(stra_usuarios.segundo_apellido))
                    segundoApellido = stra_usuarios.segundo_apellido.Trim();

                objUsuarios.CrearUsuario(stra_usuarios.nombres.Trim(),
                                        segundonombre,
                                        stra_usuarios.apellidos.Trim(),
                                        segundoApellido,
                                        stra_usuarios.correo_electronico.Trim(),
                                        stra_usuarios.cargo.Trim());

                return RedirectToAction("Index");

            }
            else
            {
                ViewBag.Validar = '1';
                ViewBag.id_stra_grupo = new SelectList(db.stra_grupos, "id_stra_grupo", "descripcion");
                return View(stra_usuarios);

            }

        }

        [HttpGet]
        public JsonResult CargarEstado()
        {
            List<ListData> itemData = new List<ListData>{
            new ListData { value = "1", text = "Activo" },
            new ListData { value = "2", text = "Inactivo" },
             };
            var data = itemData;
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        //
        // GET: /Usuario/Cambiarcontrasena/5
        [Authorize]
        public ActionResult Cambiarcontrasena(int id = 0)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            stra_usuarios stra_usuarios = db.stra_usuarios.Find(id);
            if (stra_usuarios == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_stra_grupo = new SelectList(db.stra_grupos, "id_stra_grupo", "descripcion", stra_usuarios.id_stra_grupo);
            return View(stra_usuarios);
        }

        //
        // POST: /Usuario/Cambiarcontrasena/5
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Cambiarcontrasena(stra_usuarios stra_usuario)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            stra_usuarios stra_usuariosold = db.stra_usuarios.Find(stra_usuario.id_stra_usuario);
            if (stra_usuariosold.contrasena == Usuarios.encryptar(stra_usuario.ViejaClave))
            {
                Usuarios objUsuario = new Usuarios();
                objUsuario.CambiarContrasena(stra_usuario.id_stra_usuario, stra_usuario.NuevaClave);
                return RedirectToAction("Ingreso", "Home");
            }
            else
            {
                ModelState.AddModelError("", "Contraseña anterior no coincide con la información en la base de datos");
            }
            return View(stra_usuario);


        }

        [AllowAnonymous]
        public ActionResult RecuperacionContrasena()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        //[InitializeSimpleMembership]
        public ActionResult RecuperacionContrasena(string UserName)
        {
            //check user existance
            if (UserName == String.Empty)
            {
                TempData["Message"] = "Usuario o Correo Electrónico es obligatorio.";
                return View();
            }



            bool userValid = db.stra_usuarios.Any(user => user.usuario == UserName);

            //var user = Membership.GetUser(UserName);
            if (!userValid)
            {
                TempData["Message"] = "Usuario no existe en el administrador de Yo cuido lo público.";
            }
            else
            {
                bool userValidActivo = db.stra_usuarios.Any(user => user.usuario == UserName && user.estado == 1);

                if (userValidActivo)
                {
                    Usuarios objUsuario = new Usuarios();
                    objUsuario.ResetearContrasena(UserName);

                    string subject = "Reseteo de contraseña del Administrador de Yo cuido lo público";
                    string body = Mail.BodyResetearContraseña(); //edit it
                    string usuariosoporte = Mail.usuarioSoporte();
                    try
                    {
                        string mensajeenvio = Mail.enviarmail(usuariosoporte, UserName, subject, body);
                        TempData["Message"] = mensajeenvio;
                    }
                    catch (Exception ex)
                    {
                        TempData["Message"] = "Error occured while sending email." + ex.Message;
                    }

                }
                else
                {
                    TempData["Message"] = "El usuario se encuentra inactivo.";
                }
            }

            return View();
        }
        //
        // GET: /Usuario/Edit/5
        [Authorize]
        public ActionResult Edit(int id = 0)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            stra_usuarios stra_usuarios = db.stra_usuarios.Find(id);
            if (stra_usuarios == null)
            {
                return HttpNotFound();
            }
            List<ListData> itemData = new List<ListData>{
            new ListData { value = "1", text = "Activo" },
            new ListData { value = "2", text = "Inactivo" },
             };

            string value = stra_usuarios.estado.ToString();
            ViewBag.estado = value;
            ViewBag.id_stra_grupo = new SelectList(db.stra_grupos, "id_stra_grupo", "descripcion", stra_usuarios.id_stra_grupo);
            ViewBag.lista = new SelectList(itemData, "value", "text", value);
            return View(stra_usuarios);
        }

        //
        // POST: /Usuario/Edit/5
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(stra_usuarios stra_usuarios, string selectEstado)
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            Usuarios objUsuarios = new Usuarios();
            sbyte intestado = 1;
            if (stra_usuarios != null)
            {
                if (!String.IsNullOrEmpty(selectEstado))
                {
                    intestado = sbyte.Parse(selectEstado);
                    stra_usuarios.estado = intestado;
                }

                string segundonombre = "";
                string segundoApellido = "";
                if (!String.IsNullOrEmpty(stra_usuarios.segundo_nombre))
                    segundonombre = stra_usuarios.segundo_nombre.Trim();
                if (!String.IsNullOrEmpty(stra_usuarios.segundo_apellido))
                    segundoApellido = stra_usuarios.segundo_apellido.Trim();

                objUsuarios.EditarUsuario(stra_usuarios.id_stra_usuario,
                                            stra_usuarios.nombres.Trim(),
                                            segundonombre,
                                            stra_usuarios.apellidos.Trim(),
                                            segundoApellido,
                                            stra_usuarios.cargo.Trim(), intestado);

                return RedirectToAction("Index");
            }
            List<ListData> itemData = new List<ListData>{
            new ListData { value = "1", text = "Activo" },
            new ListData { value = "2", text = "Inactivo" },
             };
            string value = stra_usuarios.estado.ToString();
            ViewBag.estado = value;
            ViewBag.id_stra_grupo = new SelectList(db.stra_grupos, "id_stra_grupo", "descripcion", stra_usuarios.id_stra_grupo);
            ViewBag.lista = new SelectList(itemData, "value", "text", value);
            return View(stra_usuarios);
        }




        [Authorize]
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