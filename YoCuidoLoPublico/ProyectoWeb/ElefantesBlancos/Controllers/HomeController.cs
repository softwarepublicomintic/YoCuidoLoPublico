using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ElefantesBlancosDatos;
using ElefantesBlancosDatos.Models;
using PagedList;
using System.Web.UI.WebControls;
using ElefantesBlancos.Utils;
using System.Threading.Tasks;

namespace ElefantesBlancos.Controllers
{

    [Authorize]
    [HandleError(
      View = "ErrorPersonalizado",
      Master = "_Layout",
      Order = 0)
  ]
    public class HomeController : Controller
    {
        moviles4Entities db = new moviles4Entities();
        private readonly List<ListData> itemData = new List<ListData>{
            new ListData { value = "1", text = "Todos" },
            new ListData { value = "2", text = "Imagénes Pendientes" },
            new ListData { value = "3", text = "Información Pendiente" },
            new ListData { value = "4", text = "Ya no es un elefante" },
            };

        [Authorize]
        public ActionResult Ingreso()
        {
            if (Session["EsAdmin"] != null)
            {
                bool IsHome = (bool)Session["EsAdmin"];
                if (IsHome)
                    return RedirectToAction("Administrador", "Home");
            }
            else
                return RedirectToAction("Login", "Account");
            return View();
        }

     

        public ActionResult Index(string sortOrder,  
                                  string EstadoSelector, 
                                  string MunicipioSelector, 
                                  string DepartamentoSelector,  
                                  string RegionSelector, 
                                  string ValidadoSelector,
                                  int? page)
        {

            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");
           
                      
                List<ElefanteModels> listElefantes;
                int cantidadRegistros = 0;
                int cantidadtotal = 0;
                int Index = 0;
                Session["listPequeno"] = null;
                Session["listaGrande"] = null;
                Session["ruta"] = null;
                ViewBag.CurrentSort = sortOrder;
                ViewBag.CodigoSortParm = sortOrder == "Codigo" ? "Codigo_desc" : "Codigo";
                ViewBag.TituloSortParm = sortOrder == "Titulo" ? "Titulo_desc" : "Titulo";

                ViewBag.EstadoSortParm = sortOrder == "Estado" ? "Estado_desc" : "Estado";
                ViewBag.DepartamentoSortParm = sortOrder == "Departamento" ? "Departamento_desc" : "Departamento";
                ViewBag.MunicipioSortParm = sortOrder == "Municipio" ? "Municipio_desc" : "Municipio";
                ViewBag.FechaSortParm = sortOrder == "Fecha" ? "Fecha_desc" : "Fecha";

                ViewBag.regiones = new SelectList(ConsultasBusqueda.ConsultaRegiones(), "Id_stra_region", "nombre");
                ViewBag.departamentos = new SelectList(ConsultasBusqueda.ConsultaDepartamentos(), "Id_stra_departamento", "nombre");
                ViewBag.municipios = new SelectList(ConsultasBusqueda.ConsultaMunicipios(), "Id_stra_municipio", "nombre", MunicipioSelector);
                ViewBag.estados = new SelectList(ConsultasBusqueda.ConsultaEstados(), "id_stra_estado_elefante", "nombre");
                ViewBag.validados = new SelectList(itemData, "value", "text");
                //aquí traemos los datos de resumen
                ViewBag.ElefantesPendiente = ConsultasBusqueda.CantidadElefantesBlancosPendientes();
                ViewBag.FotosElefantes = ConsultasBusqueda.CantidadImagenesPendientes();
                ViewBag.NuevaInformacion = ConsultasBusqueda.CantidadInformacionPendiente();
                ViewBag.ElefantesAprobados = ConsultasBusqueda.CantidadElefantesBlancosAprobados();


                if (!String.IsNullOrEmpty(MunicipioSelector))
                    ViewBag.MunicipioSelector = MunicipioSelector;
                else
                    ViewBag.MunicipioSelector = "0";
                if (!String.IsNullOrEmpty(EstadoSelector))
                    ViewBag.EstadoSelector = EstadoSelector;
                else
                    ViewBag.EstadoSelector = "";
                if (!String.IsNullOrEmpty(DepartamentoSelector))
                    ViewBag.DepartamentoSelector = DepartamentoSelector;
                else
                    ViewBag.DepartamentoSelector = "0";
                if (!String.IsNullOrEmpty(RegionSelector))
                    ViewBag.RegionSelector = RegionSelector;
                else
                    ViewBag.RegionSelector = "0";


                listElefantes = ConsultasBusqueda.ConsultaElefantes(EstadoSelector, MunicipioSelector, DepartamentoSelector, RegionSelector, ValidadoSelector);
                Session["listElefantes"] = listElefantes;
                listElefantes = listElefantes.OrderByDescending(s => s.id_stra_elefante).ToList();
                if (page == null)
                {
                    Index = 0;
                    cantidadRegistros = 10;
                    cantidadtotal = listElefantes.Count();
                    if (cantidadRegistros > cantidadtotal)
                        cantidadRegistros = cantidadtotal;
                }
                else
                {
                    cantidadRegistros = (Convert.ToInt32(page) * 10);
                    cantidadtotal = listElefantes.Count();
                    if (cantidadRegistros > cantidadtotal)
                        cantidadRegistros = cantidadtotal;
                    Index = cantidadRegistros - 10;

                }
                string ruta = "";
                ruta = Server.MapPath("/ElefantesImagenes");
                Parallel.For(Index, cantidadRegistros, i =>
                {
                    if (listElefantes[i].id_stra_imagen_principal_pequena != null)
                    {
                        Imagen.CopiarCache((int)listElefantes[i].id_stra_imagen_principal_pequena, ruta, true);
                        listElefantes[i].ruta = UtilsImagen.ObtenerRuta((int)listElefantes[i].id_stra_imagen_principal_pequena);
                    }
                    else
                        listElefantes[i].ruta = ruta;
                });


                var elefantes = from l in listElefantes
                                select l;

                Session["Redireccionar"] = "1";
                //Esta variable nos indica la cantidad de registro por paginas
                int pageSize = 10;
                int pageNumber = (page ?? 1);
                return View(elefantes.ToPagedList(pageNumber, pageSize));
          

        }


       [Authorize]
       public ActionResult Busqueda(string sortOrder,
                                 string EstadoSelector,
                                 string MunicipioSelector,
                                 string DepartamentoSelector,
                                 string RegionSelector,
                                 string ValidadoSelector,
                                 int? page)
       {

                  
           List<ElefanteModels> listElefantes;
           int cantidadRegistros = 0;
           int cantidadtotal = 0;
           int Index = 0;
           Session["Redireccionar"] = "1";
           ViewBag.CurrentSort = sortOrder;
           ViewBag.CodigoSortParm = sortOrder == "Codigo" ? "Codigo_desc" : "Codigo";
           ViewBag.TituloSortParm = sortOrder == "Titulo" ? "Titulo_desc" : "Titulo";

           ViewBag.EstadoSortParm = sortOrder == "Estado" ? "Estado_desc" : "Estado";
           ViewBag.DepartamentoSortParm = sortOrder == "Departamento" ? "Departamento_desc" : "Departamento";
           ViewBag.MunicipioSortParm = sortOrder == "Municipio" ? "Municipio_desc" : "Municipio";
           ViewBag.FechaSortParm = sortOrder == "Fecha" ? "Fecha_desc" : "Fecha";


           if (!String.IsNullOrEmpty(MunicipioSelector))
               ViewBag.MunicipioSelector = MunicipioSelector;
           else
               ViewBag.MunicipioSelector = "0";
           if (!String.IsNullOrEmpty(EstadoSelector))
               ViewBag.EstadoSelector = EstadoSelector;
           else
               ViewBag.EstadoSelector = "";
           if (!String.IsNullOrEmpty(DepartamentoSelector))
               ViewBag.DepartamentoSelector = DepartamentoSelector;
           else
               ViewBag.DepartamentoSelector = "0";
           if (!String.IsNullOrEmpty(RegionSelector))
               ViewBag.RegionSelector = RegionSelector;
           else
               ViewBag.RegionSelector = "0";
           if (!String.IsNullOrEmpty(ValidadoSelector))
               ViewBag.ValidadoSelector = ValidadoSelector;
           else
               ViewBag.ValidadoSelector = "1";

           //1.  Traemos el listado de elefantes
           if ((page == null) && (sortOrder == null))
           {
               listElefantes = ConsultasBusqueda.ConsultaElefantes(EstadoSelector, MunicipioSelector, DepartamentoSelector, RegionSelector, ValidadoSelector);
               Session["listElefantes"] = listElefantes;
           }
           else
           {
               if (Session["listElefantes"] == null)
               {
                   listElefantes = ConsultasBusqueda.ConsultaElefantes(EstadoSelector, MunicipioSelector, DepartamentoSelector, RegionSelector, ValidadoSelector);
                   Session["listElefantes"] = listElefantes;
               }
               else
               {
                   listElefantes = (List<ElefanteModels>)Session["listElefantes"];
               }
           }

        
           //Hacemos la ordenacion
           switch (sortOrder)
           {
               case "Codigo":
                   listElefantes = listElefantes.OrderBy(s => s.id_stra_elefante).ToList();
                   break;
               case "Codigo_desc":
                   listElefantes = listElefantes.OrderByDescending(s => s.id_stra_elefante).ToList();
                   break;
               case "Titulo":
                   listElefantes = listElefantes.OrderBy(s => s.titulo).ToList();
                   break;
               case "Titulo_desc":
                   listElefantes = listElefantes.OrderByDescending(s => s.titulo).ToList();
                   break;
               case "Estado":
                   listElefantes = listElefantes.OrderBy(s => s.estado).ToList();
                   break;
               case "Estado_desc":
                   listElefantes = listElefantes.OrderByDescending(s => s.estado).ToList();
                   break;
               case "Departamento":
                   listElefantes = listElefantes.OrderBy(s => s.departamento).ToList();
                   break;
               case "Departamento_desc":
                   listElefantes = listElefantes.OrderByDescending(s => s.departamento).ToList();
                   break;
               case "Municipio":
                   listElefantes = listElefantes.OrderBy(s => s.municipio).ToList();
                   break;
               case "Municipio_desc":
                   listElefantes = listElefantes.OrderByDescending(s => s.municipio).ToList();
                   break;
               case "Fecha":
                   listElefantes = listElefantes.OrderBy(s => s.fecha_creacion).ToList();
                   break;
               case "Fecha_desc":
                   listElefantes = listElefantes.OrderByDescending(s => s.fecha_creacion).ToList();
                   break;
               default:
                   listElefantes = listElefantes.OrderByDescending(s => s.id_stra_elefante).ToList();
                   break;
           }

           int pageSize = 10;
           int pageNumber = (page ?? 1);

           if (page == null)
           {
               Index = 0;
               cantidadRegistros = 10;
               cantidadtotal = listElefantes.Count();
               if (cantidadRegistros > cantidadtotal)
                   cantidadRegistros = cantidadtotal;
           }
           else
           {
               cantidadRegistros = (Convert.ToInt32(page) * 10);
               cantidadtotal = listElefantes.Count();
               if (cantidadRegistros > cantidadtotal)
                   cantidadRegistros = cantidadtotal;
               Index = cantidadRegistros - 10;

           }
           string ruta = "";
           ruta = Server.MapPath("/ElefantesImagenes");
            Parallel.For(Index, cantidadRegistros, i =>
            {
                if (listElefantes[i].id_stra_imagen_principal_pequena != null)
                {
                  Imagen.CopiarCache((int)listElefantes[i].id_stra_imagen_principal_pequena, ruta, true);
                  listElefantes[i].ruta = UtilsImagen.ObtenerRuta((int)listElefantes[i].id_stra_imagen_principal_pequena);
                }
                else
                    listElefantes[i].ruta = ruta;
            });

           var elefantes = from l in listElefantes
                           select l;
          
           //int pageSize = 10;
           //int pageNumber = (page ?? 1);

           if (Request.IsAjaxRequest())
               return PartialView("DetalleElefantes", elefantes.ToPagedList(pageNumber, pageSize));
           else
           {
               ViewBag.regiones = new SelectList(ConsultasBusqueda.ConsultaRegiones(), "Id_stra_region", "nombre");
               ViewBag.departamentos = new SelectList(ConsultasBusqueda.ConsultaDepartamentos(), "Id_stra_departamento", "nombre");
               ViewBag.municipios = new SelectList(ConsultasBusqueda.ConsultaMunicipios(), "Id_stra_municipio", "nombre", MunicipioSelector);
               ViewBag.estados = new SelectList(ConsultasBusqueda.ConsultaEstados(), "id_stra_estado_elefante", "nombre");
               ViewBag.validados = new SelectList(itemData, "value", "text");
               //aquí traemos los datos de resumen
               ViewBag.ElefantesPendiente = ConsultasBusqueda.CantidadElefantesBlancosPendientes();
               ViewBag.FotosElefantes = ConsultasBusqueda.CantidadImagenesPendientes();
               ViewBag.NuevaInformacion = ConsultasBusqueda.CantidadInformacionPendiente();
               ViewBag.ElefantesAprobados = ConsultasBusqueda.CantidadElefantesBlancosAprobados();
               return View("Index",elefantes.ToPagedList(pageNumber, pageSize));
           }
         
           
       }

       public List<ExportarDatos> CargarInformacion()
        {
            List<ExportarDatos> listExportar = new List<ExportarDatos>();
            List<ElefanteModels> listElefantes;
            
            listElefantes = (List<ElefanteModels>)Session["listElefantes"];
            
            foreach (ElefanteModels item in listElefantes)
            {
                ExportarDatos objExportar = new ExportarDatos();
                objExportar.Codigo = item.id_stra_elefante;
                objExportar.Departamento = item.departamento;
                objExportar.Municipio = item.municipio;
                objExportar.Estado = item.estado;
                objExportar.FechaCreación = item.fecha_creacion.ToString("dd/MM/yyyy");
                objExportar.Titulo = item.titulo;
                listExportar.Add(objExportar);
            }

            return listExportar;

        }

         [Authorize]
        public ActionResult Download()
        {
            if (Session["EsAdmin"] == null)
                return RedirectToAction("Login", "Account");

            if (Session["listElefantes"] != null)
            {
                List<ExportarDatos> listExportar = CargarInformacion();
                GridView gv = new GridView();
                gv.DataSource = listExportar;
                gv.DataBind();

                string nombre = "Elefantes " +  " " + DateTime.Now.ToString("yyyy/MM/dd HH:mm") +".xls";
                Dispose();
                return new DownloadFileActionResult(gv, nombre);
            }
            else
            {
                return new JavaScriptResult();
            }
        }

         [Authorize]
        public ActionResult Administrador()
        {
            if (Session["EsAdmin"] == null)
                 return RedirectToAction("Login", "Account");
            
            return View();

        }
        #region Json
        public JsonResult GetMunicipio(string departamento = null)
        {
           // ConsultasBusqueda objBusqueda = new ConsultasBusqueda();
            List<stra_municipios_listado> municipios = db.stra_municipios_listado.ToList();
            List<ListData> itemData = new List<ListData>();
            ListData item = new ListData();
                   
            if (departamento == "0")
            {
              
                 itemData = (from m in municipios
                             orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.id_stra_municipio,
                             }).ToList();

             
            }
            else
            {
                itemData = (from m in municipios
                            where m.id_stra_departamento.Equals(departamento)
                             orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.id_stra_municipio,
                            }).ToList();
            }

            item.text = "Municipio";
            item.value = "0";
            itemData.Add(item);
            var data = itemData;
            ViewBag.MunicipioSelector = "0";
            ViewBag.DepartamentoSelector = departamento; 
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMunicipioPorMunicipio(string municipio = null)
        {
            // ConsultasBusqueda objBusqueda = new ConsultasBusqueda();
            List<stra_municipios_listado> municipios = db.stra_municipios_listado.ToList();
            List<ListData> itemData = new List<ListData>();
            ListData item = new ListData();
            string departamento = "";

            if (municipio != "0")
            {
                departamento = (from m in db.stra_municipios_listado
                                where m.id_stra_municipio.Equals(municipio)
                                select m).First().id_stra_departamento;

                itemData = (from m in municipios
                            where m.id_stra_departamento.Equals(departamento)
                            orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.id_stra_municipio,
                            }).ToList();
            }
            else
            {
                itemData = (from m in municipios
                            orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.id_stra_municipio,
                            }).ToList();
            }

                item.text = "Municipio";
                item.value = "0";
                itemData.Add(item);
                var data = itemData;
                ViewBag.MunicipioSelector = municipio;
                ViewBag.DepartamentoSelector = departamento;
            
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetRegion(string departamento = null)
        {
            var data = "0";
            if (departamento != "0")
            {
                var departamentolist = from d in db.stra_departamentos_listado
                                       where d.id_stra_departamento.Equals(departamento)
                                       select d;


                foreach (var item in departamentolist)
                    data = item.id_stra_region.ToString();

                ViewBag.MunicipioSelector = "0";
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDepartamentoPorRegion(string region = null)
        {

            List<stra_departamentos_listado> departamentos = db.stra_departamentos_listado.ToList();
            List<ListData> itemData = new List<ListData>();
            ListData item = new ListData();

            if (region == "0")
            {
                itemData = (from d in departamentos
                           orderby (d.nombre)
                            select new ListData
                            {
                                text = (d.nombre.Length > 26 ? d.nombre.Substring(0,26) : d.nombre),
                                value = d.id_stra_departamento
                            }).ToList();
            }
            else
            {
                itemData = (from d in departamentos
                            where d.id_stra_region == int.Parse(region)
                            orderby (d.nombre)
                            select new ListData
                            {
                                text = (d.nombre.Length > 26 ? d.nombre.Substring(0, 26) : d.nombre),
                                value = d.id_stra_departamento
                            }).ToList();
            }

            item.text = "Departamento";
            item.value = "0";
            itemData.Add(item);
            var data = itemData;
            ViewBag.RegionSelector = region;
            ViewBag.DepartamentoSelector = "0";
            ViewBag.MunicipioSelector = "0";

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDepartamentoTodos(string departamento = null)
        {

            List<stra_departamentos_listado> departamentos = db.stra_departamentos_listado.ToList();
            List<ListData> itemData = new List<ListData>();
            ListData item = new ListData();

            if (departamento == "0")
            {
                itemData = (from d in departamentos
                            orderby (d.nombre)
                            select new ListData
                            {
                                text = (d.nombre.Length > 26 ? d.nombre.Substring(0, 26) : d.nombre),
                                value = d.id_stra_departamento
                            }).ToList();
            }
           

            item.text = "Departamento";
            item.value = "0";
            itemData.Add(item);
            var data = itemData;
            ViewBag.RegionSelector = "0";
            ViewBag.DepartamentoSelector = "0";
            ViewBag.MunicipioSelector = "0";

            return Json(data, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetMunicipioPorRegion(string region = null)
        {

            List<stra_municipios_listado> municipios = db.stra_municipios_listado.ToList();
            List<ListData> itemData = new List<ListData>();
            ListData item = new ListData();

            if (region == "0")
            {
                itemData = (from m in municipios
                           orderby (m.nombre)
                            select new ListData
                           {
                               text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                               value = m.id_stra_municipio
                           }).ToList();
            }
            else
            {
                itemData = (from m in municipios
                            where m.id_stra_region == int.Parse(region)
                            orderby (m.nombre)
                            select new ListData
                            {
                                text = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                value = m.id_stra_municipio
                            }).ToList();
            }



            item.text = "Municipio";
            item.value = "0";
            itemData.Add(item);
            var data = itemData;
            ViewBag.MunicipioSelector = "0";
            ViewBag.DepartamentoSelector = "0";
            ViewBag.RegionSelector = region;
         
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetRegionPorMunicipio(string municipio = null)
        {

            var data = "0";
            if (municipio != "0")
            {
                data = (from m in db.stra_municipios_listado
                        where m.id_stra_municipio.Equals(municipio)
                        select m).First().id_stra_region.ToString();


            }
            return Json(data, JsonRequestBehavior.AllowGet);
          
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
        public JsonResult GetDepartamentoPorMunicipio(string municipio = null)
        {

            var data = "0";

            if (municipio != "0")
            {
                data = (from m in db.stra_municipios_listado
                                     where m.id_stra_municipio.Equals(municipio)
                                     select m).First().id_stra_departamento;
             
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        #endregion       
       
        protected override void OnException(ExceptionContext filterContext)
        {
            string ruta = "";
            ruta = Server.MapPath("/Log");
            Log.WriteLog(ruta, filterContext.Exception.ToString());
        }
    }
}
