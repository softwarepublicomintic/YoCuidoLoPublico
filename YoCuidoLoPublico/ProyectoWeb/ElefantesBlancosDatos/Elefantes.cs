using ElefantesBlancosDatos.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos
{
    public class Elefantes
    {
        #region Consultas
        public List<stra_elefantes> ConsultaElefantesPorDivipola(string municipio = "0", string estado = "0", string strParametro ="1")
        {
            List<stra_elefantes> ListElefantes = new List<stra_elefantes>();
            using (moviles4Entities moviles = new moviles4Entities())
            {
                if ((!String.IsNullOrEmpty(municipio)) && (municipio != "0"))
                {

                    if ((!String.IsNullOrEmpty(estado)) && (estado != "0"))
                    {
                        int intEstado = Convert.ToInt32(estado);


                        if (estado == "2")
                        {
                            switch (strParametro)
                            {
                                case "2":
                                    //Join conImagenes Pendientes
                                    ListElefantes = (from e in moviles.stra_elefantes
                                                     join ip in moviles.stra_imagenes on e.id_stra_elefante equals ip.id_stra_elefante
                                                     where e.id_stra_municipio == municipio
                                                     where e.id_stra_estado_elefante == 2
                                                     where ip.estado_imagen == 0
                                                     where ip.tipo_imagen == 2
                                                     select e).ToList();
                                    break;
                                case "3":
                                    //Join con Información Pendiente
                                    ListElefantes = (from e in moviles.stra_elefantes.Where(x => (x.estado_id_rango_tiempo == 0 && x.id_stra_rango_tiempo != null)
                                                                            || (x.estado_contratista == 0 && x.contratista != null)
                                                                            || (x.estado_costo == 0 && x.costo != null))
                                                     where e.id_stra_municipio == municipio
                                                     where e.id_stra_estado_elefante == intEstado
                                                     select e).ToList();
                                    break;
                                case "4":
                                    //No es un elefante
                                    ListElefantes = (from e in moviles.stra_elefantes
                                                     where e.id_stra_municipio == municipio
                                                     where e.id_stra_estado_elefante == intEstado
                                                     where e.no_es_un_elefante == true
                                                     select e).ToList();
                                    break;
                                default:
                                    // Todos
                                    ListElefantes = (from e in moviles.stra_elefantes
                                                     where e.id_stra_municipio == municipio
                                                     where e.id_stra_estado_elefante == intEstado
                                                     select e).ToList();
                                    break;
                            }

                        }
                        else
                        {
                            ListElefantes = (from e in moviles.stra_elefantes
                                             where e.id_stra_municipio == municipio
                                             where e.id_stra_estado_elefante == intEstado
                                             select e).ToList();
                        }


                    }
                    else
                    {
                        ListElefantes = (from e in moviles.stra_elefantes
                                         where e.id_stra_municipio == municipio
                                         where e.id_stra_estado_elefante != 3
                                         select e).ToList();
                    }
                }
                else
                {

                    if ((!String.IsNullOrEmpty(estado)) && (estado != "0"))
                    {
                        int intEstado = Convert.ToInt32(estado);
                        ListElefantes = (from e in moviles.stra_elefantes
                                         where e.id_stra_estado_elefante == intEstado
                                         select e).ToList();
                    }
                    else
                    {
                        ListElefantes = (from e in moviles.stra_elefantes
                                         where e.id_stra_estado_elefante != 3
                                         select e).ToList();
                    }
                }

            }
            return ListElefantes;
        }

        public static List<ElefanteModels> ConsultasElefantesPorMunicipio(string municipio = "0")                                             
        {
            List<ElefanteModels> ListElefantes = new List<ElefanteModels>();
            using (moviles4Entities moviles = new moviles4Entities())
            {
                if ((!String.IsNullOrEmpty(municipio)) && (municipio != "0"))
                {
                    ListElefantes = (from e in moviles.stra_elefantes
                                     join s in moviles.stra_regiones on e.id_stra_region equals s.id_stra_region
                                     join d in moviles.stra_departamentos on e.id_stra_departamento equals d.id_stra_departamento
                                     join m in moviles.stra_municipios on e.id_stra_municipio equals m.id_stra_municipio
                                     where e.id_stra_municipio == municipio
                                     select new ElefanteModels
                                     {   region = s.nombre, 
                                         departamento = (d.nombre.Length > 39 ? d.nombre.Substring(0, 39) : d.nombre),
                                         municipio = (m.nombre.Length > 39 ? m.nombre.Substring(0, 39) : m.nombre),
                                         id_stra_estado_elefante = e.id_stra_estado_elefante,
                                         no_es_un_elefante = e.no_es_un_elefante,
                                      }).ToList();

                }
            }
            return ListElefantes;
        }

        public static int CantidadElefantesValidados(string municipio = "0")
        {
            int cantidad = 0;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                if ((!String.IsNullOrEmpty(municipio)) && (municipio != "0"))
                {
                    cantidad = (from e in moviles.stra_elefantes
                                where e.id_stra_municipio == municipio
                                where e.id_stra_estado_elefante == 2
                                select e).Count();

                }
            }
            return cantidad;
        }

        public static int CantidadElefantesYanoesunelefante(string municipio = "0")
        {
            int cantidad = 0;
            List<stra_elefantes> elefantes;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                if ((!String.IsNullOrEmpty(municipio)) && (municipio != "0"))
                {
                    elefantes = (from e in moviles.stra_elefantes
                                 where e.id_stra_municipio == municipio
                                 where e.id_stra_estado_elefante == 2
                                 where e.no_es_un_elefante == true
                                 select e).ToList();

                    cantidad = elefantes.Count;

                }
            }
           
            return cantidad;
        }
        public static int CantidadImagenesPendientes(string municipio = "0")
        {
            int cantidad = 0;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                if ((!String.IsNullOrEmpty(municipio)) && (municipio != "0"))
                {
                    cantidad = (from e in moviles.stra_elefantes
                                join i in moviles.stra_imagenes on e.id_stra_elefante equals i.id_stra_elefante
                                where e.id_stra_municipio == municipio
                                where e.id_stra_estado_elefante == 2
                                where i.estado_imagen == 0
                                where i.tipo_imagen == 2
                                select e).Count();

                }
            }
            return cantidad;
        }

        public static int CantidadInformacionPendiente(string municipio = "0")
        {
            int cantidad = 0;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                if ((!String.IsNullOrEmpty(municipio)) && (municipio != "0"))
                {
                    cantidad = (from e in moviles.stra_elefantes.Where(x => (x.estado_id_rango_tiempo == 0 && x.id_stra_rango_tiempo != null) ||
                                                                    (x.estado_contratista == 0 && !String.IsNullOrEmpty(x.contratista)) ||
                                                                    (x.estado_costo == 0 && x.costo > 0))
                                 where e.id_stra_estado_elefante == 2
                                 where e.id_stra_municipio == municipio
                                  select e).Count(); 
                }
            }
            return cantidad;
        }
        public static List<ElefanteModels> ConsultasElefantesPorRegion(int region = 0)
        {
            List<ElefanteModels> ListElefantes = new List<ElefanteModels>();
            using (moviles4Entities moviles = new moviles4Entities())
            {
                if (region != 0)
                {
                    ListElefantes = (from e in moviles.stra_elefantes
                                     from ip in moviles.stra_imagenes.Where(x => (e.id_stra_estado_elefante == 2 &&
                                        e.id_stra_elefante == x.id_stra_elefante && x.estado_imagen == 0 && x.tipo_imagen == 2)).DefaultIfEmpty()
                                     where e.id_stra_region == region
                                     select new ElefanteModels
                                     {
                                        id_stra_estado_elefante = e.id_stra_estado_elefante,
                                         no_es_un_elefante = e.no_es_un_elefante,
                                         imagenpendiente = (ip != null && e.id_stra_estado_elefante == 2 ? ip.id_stra_imagen : 0),
                                         EsImagen = (ip != null && e.id_stra_estado_elefante == 2 ? true : false),
                                         EsInformacion = ((e.estado_id_rango_tiempo == 0 && e.id_stra_rango_tiempo != null && e.id_stra_estado_elefante == 2)
                                                         || (e.estado_contratista == 0 && e.contratista != null && e.id_stra_estado_elefante == 2)
                                                         || (e.estado_costo == 0 && e.costo != null && e.id_stra_estado_elefante == 2) ? true : false)
                                     }).ToList();

                }
            }
            return ListElefantes;
        }


        public static List<Elefantesregionmodels> ConsultaElefantesValidados()
        {
            List<Elefantesregionmodels> ListElefantes = new List<Elefantesregionmodels>();
            using (moviles4Entities moviles = new moviles4Entities())
            {

                ListElefantes = (from e in moviles.stra_elefantes
                                 where e.id_stra_estado_elefante == 2
                                 group e by e.id_stra_region into region
                                 let count = region.Count()
                                 orderby count
                                 select new Elefantesregionmodels {
                                                 cantidad = count, 
                                                 id_stra_region = region.Key 
                                                }).ToList();

                 
                
            }
            return ListElefantes;
        }

        public static List<Elefantesregionmodels> ConsultaElefantesPendientes()
        {
            List<Elefantesregionmodels> ListElefantes = new List<Elefantesregionmodels>();
            using (moviles4Entities moviles = new moviles4Entities())
            {

                ListElefantes = (from e in moviles.stra_elefantes
                                 where e.id_stra_estado_elefante == 1
                                 group e by e.id_stra_region into region
                                 let count = region.Count()
                                 orderby count
                                 select new Elefantesregionmodels
                                 {
                                     cantidad = count,
                                     id_stra_region = region.Key
                                 }).ToList();



            }
            return ListElefantes;
        }

        public static List<Elefantesregionmodels> ConsultaElefantesFotosPendientes()
        {
            List<Elefantesregionmodels> ListElefantes = new List<Elefantesregionmodels>();
            using (moviles4Entities moviles = new moviles4Entities())
            {

                ListElefantes = (from e in moviles.stra_elefantes
                                 join i in moviles.stra_imagenes on e.id_stra_elefante equals i.id_stra_elefante
                                 where e.id_stra_estado_elefante == 2
                                 where i.estado_imagen == 0
                                 where i.tipo_imagen == 2
                                 group e by e.id_stra_region into region
                                 let count = region.Count()
                                 orderby count
                                 select new Elefantesregionmodels
                                 {
                                     cantidad = count,
                                     id_stra_region = region.Key
                                 }).ToList();

    

            }
            return ListElefantes;
        }

        public static List<Elefantesregionmodels> ConsultaElefantesNuevaInformacion()
        {
            List<Elefantesregionmodels> ListElefantes = new List<Elefantesregionmodels>();
            using (moviles4Entities moviles = new moviles4Entities())
            {

                ListElefantes = (from e in moviles.stra_elefantes.Where(x=> (x.estado_id_rango_tiempo == 0 && x.id_stra_rango_tiempo != null)
                                                                            || (x.estado_contratista == 0 && !String.IsNullOrEmpty(x.contratista))
                                                                            || (x.estado_costo == 0 && x.costo > 0) )
                                 where e.id_stra_estado_elefante == 2                                
                                 group e by e.id_stra_region into region
                                 let count = region.Count()
                                 orderby count
                                 select new Elefantesregionmodels
                                 {
                                     cantidad = count,
                                     id_stra_region = region.Key
                                 }).ToList();



            }
            return ListElefantes;
        }
        #endregion

        #region Actualizacion
        public void ActualizarAprobacionElefantes(int Id, 
                                                  string titulo, 
                                                  sbyte? estadotitulo, 
                                                  string entidadresponsable, 
                                                  sbyte? estadoentidad, 
                                                  int motivo, 
                                                  sbyte? estadomotivo,
                                                  int? rangotiempo, 
                                                  sbyte? estadotiempo, 
                                                  long? costo, 
                                                  sbyte? estadocosto, 
                                                  string contratista, 
                                                  sbyte? estadocontratista,
                                                  int Id_imagen_principal_grande,
                                                  int Id_Imagen_principal_pequena,
                                                  stra_elefantes elefantesold,
                                                  int id_stra_usuario,
                                                  string usuario)
        {

            using (moviles4Entities moviles = new moviles4Entities())
            {
                string datos = "";
                datos += "Estado título: validado " + "// ";
                datos += "Estado entidad: validado " + "// ";
                datos += "Estado motivo: validado " + "// ";
                datos += "Estado foto: validado " + "// ";
                if (elefantesold.titulo != titulo)
                    datos += "Título: " + titulo + "// ";
                if (elefantesold.entidad_responsable != entidadresponsable)
                    datos += "Entidad responsable: " + entidadresponsable + "// ";
                if (elefantesold.id_stra_motivo_elefante != motivo)
                    datos += "Entidad responsable: " + entidadresponsable + "// ";

                stra_elefantes elefante = (from e in moviles.stra_elefantes
                                           where e.id_stra_elefante == Id
                                           select e).First();
                elefante.titulo = titulo;
                elefante.estado_titulo = estadotitulo;
                elefante.entidad_responsable = entidadresponsable;
                elefante.estado_entidad = estadoentidad;
                elefante.id_stra_motivo_elefante = motivo;
                elefante.estado_id_motivo_elefante = estadomotivo;
                if (rangotiempo != 0)
                {
                    elefante.id_stra_rango_tiempo = rangotiempo;
                    if (elefantesold.id_stra_rango_tiempo != rangotiempo)
                         datos += "Rango tiempo : " + rangotiempo + "// ";
                }

                if (estadotiempo != null)
                {
                    elefante.estado_id_rango_tiempo = estadotiempo;
                    if (estadotiempo == 1)
                        datos += "Estado rango tiempo: validado " + "// ";
                    else  if (estadotiempo == 2)
                        datos += "Estado rango tiempo: rechazado " + "// ";
                }

                if ((costo != null) && (costo != 0))
                {
                    elefante.costo = costo;
                    if (elefantesold.costo != costo)
                        datos += "Costo: " + costo + "// ";
                }
                if (estadocosto != null)
                {
                    elefante.estado_costo = estadocosto;
                    if (estadocosto == 1)
                        datos += "Estado costo: validado " + "// ";
                    else if (estadocosto == 2)
                        datos += "Estado costo: rechazado " + "// ";
                }

                if (!String.IsNullOrEmpty(contratista))
                {
                    elefante.contratista = contratista;
                    if (elefantesold.contratista != contratista)
                        datos += "Contratista: " + contratista + "// ";
                }
                if (estadocontratista != null)
                {
                    elefante.estado_contratista = estadocontratista;
                    if (estadocontratista == 1)
                        datos += "Estado contratista: validado " + "// ";
                    else if (estadocontratista == 2)
                        datos += "Estado contratista: rechazado " + "// ";
                }
                
                if ((estadoentidad == 1) && (estadomotivo == 1) && (estadotitulo == 1))
                {
                    //El elefante queda aprobado
                    elefante.id_stra_estado_elefante = 2;
                }

                elefante.estado_imagen = 1;
              
                //Aprobamos la imagen principal grande y pequena
        
                stra_imagenes stra_imagenes = (from e in moviles.stra_imagenes
                                           where e.id_stra_imagen == Id_imagen_principal_grande
                                           select e).First();

                stra_imagenes stra_imagenes1 = (from e in moviles.stra_imagenes
                                               where e.id_stra_imagen == Id_Imagen_principal_pequena
                                               select e).First();

                stra_imagenes.estado_imagen = 1;
                stra_imagenes1.estado_imagen = 1;
                
                moviles.SaveChanges();

                //Ahora hacemos el llamado para dejar el registro en auditoria.                
                LogicaAuditoria.CrearRegistroAuditoria(Id, id_stra_usuario, 2, 2, datos, usuario, titulo);

            }

        }


        public void ActualizarElefantesAprobados(int Id,
                                                 string titulo,
                                                 string entidadresponsable,
                                                 int motivo,
                                                 int? rangotiempo,
                                                 sbyte? estadotiempo,
                                                 long? costo,
                                                 sbyte? estadocosto,
                                                 string contratista,
                                                 sbyte? estadocontratista,
                                                 stra_elefantes elefantesold,
                                                 int id_stra_usuario,
                                                 string usuario)
                                                
        {

            using (moviles4Entities moviles = new moviles4Entities())
            {
                string datos = "";
                if (elefantesold.titulo != titulo)
                    datos += "Titulo: " + titulo + "// ";
                if (elefantesold.entidad_responsable != entidadresponsable)
                    datos += "Entidad responsable: " + entidadresponsable + "// ";
                if (elefantesold.id_stra_motivo_elefante != motivo)
                    datos += "Entidad responsable: " + entidadresponsable + "// ";

                stra_elefantes elefante = (from e in moviles.stra_elefantes
                                           where e.id_stra_elefante == Id
                                           select e).First();


                elefante.titulo = titulo;
                elefante.entidad_responsable = entidadresponsable;
                elefante.id_stra_motivo_elefante = motivo;

                if (rangotiempo != 0)
                {
                    elefante.id_stra_rango_tiempo = rangotiempo;
                    //elefante.estado_id_rango_tiempo = estadotiempo;
                    if (elefantesold.id_stra_rango_tiempo != rangotiempo)
                        datos += "Rango tiempo : " + rangotiempo + "// ";
                }
                if (estadotiempo != 0)
                {
                    elefante.estado_id_rango_tiempo = estadotiempo;
                    if (estadotiempo == 1)
                        datos += "Estado rango tiempo: validado " + "// ";
                    else if (estadotiempo == 2)
                        datos += "Estado rango tiempo: rechazado " + "// ";
                }

                if (costo != 0)
                {
                    elefante.costo = costo;
                    if (elefantesold.costo != costo)
                        datos += "Costo: " + costo + "// ";
                }
                if (estadocosto != 0)
                {
                   elefante.estado_costo = estadocosto;
                   if (estadocosto == 1)
                       datos += "Estado costo: validado " + "// ";
                   else if (estadocosto == 2)
                       datos += "Estado costo: rechazado " + "// ";
                }

                if (!String.IsNullOrEmpty(contratista))
                {
                    elefante.contratista = contratista;
                    if (elefantesold.contratista != contratista)
                        datos += "Contratista: " + contratista + "// ";
                }
                if (estadocontratista != 0)
                {
                    elefante.estado_contratista = estadocontratista;
                    if (estadocontratista == 1)
                        datos += "Estado contratista: validado " + "// ";
                    else if (estadocontratista == 2)
                        datos += "Estado contratista: rechazado " + "// ";
                }
                elefante.estado_imagen = 1;
                moviles.SaveChanges();
                //Ahora hacemos el llamado para dejar el registro en auditoria.                
                LogicaAuditoria.CrearRegistroAuditoria(Id, id_stra_usuario, 5, 2, datos, usuario, titulo);

            }

        }

        public void ActualizarYaNoEsUnElefante(int Id, int UserID, string usuario)
        {

            using (moviles4Entities moviles = new moviles4Entities())
            {
                stra_elefantes elefante = (from e in moviles.stra_elefantes
                                           where e.id_stra_elefante == Id
                                           select e).First();
               
                              
               elefante.no_es_un_elefante = true;
               elefante.estado_imagen = 1;
                
                moviles.SaveChanges();
                string datos = "El elefante pasa hacer ya no es un elefante";
                LogicaAuditoria.CrearRegistroAuditoria(Id, UserID, 4, 2, datos, usuario, elefante.titulo);
            }

         
        }

        public void ActualizarImagenPrincipal(int IdImagenOld, int IdImagenNew,  int Id_stra_usuario, string usuario)
        {
            string datos = "";

            using (moviles4Entities moviles = new moviles4Entities())
            {
                            
                    stra_imagenes imagen = (from e in moviles.stra_imagenes
                                            where e.id_stra_imagen == IdImagenNew
                                            select e).First();

                    if (imagen != null)
                    {
                         stra_elefantes elefante = (from e in moviles.stra_elefantes
                                                   where e.id_stra_elefante == imagen.id_stra_elefante
                                                   select e).First();
                        if (elefante != null)
                        {                                                
                            elefante.id_stra_imagen_principal_grande = IdImagenNew;
                            elefante.id_stra_imagen_principal_pequena = imagen.id_stra_imagen_asociada;
                            elefante.estado_imagen = 1;
                            moviles.SaveChanges();
                        }

                        datos += "Id imagen principal: " + IdImagenNew + "// ";
                        datos += "Id imagen principal antigua: " + IdImagenOld + "// ";
                        LogicaAuditoria.CrearRegistroAuditoria(elefante.id_stra_elefante, Id_stra_usuario, 9, 2, datos, usuario, elefante.titulo);
                    }
                 
                }
          
        }

        public void ActualizarRechazoElefantes(int Id, 
                                               int? razonrechazo, 
                                               string comentariorechazo,
                                               string titulo, 
                                               sbyte? estadotitulo, 
                                               string entidadresponsable, 
                                               sbyte? estadoentidad, 
                                               int motivo, 
                                               sbyte? estadomotivo,
                                               int Id_imagen_principal_grande,
                                               int Id_Imagen_principal_pequena,
                                               stra_elefantes elefantesold,
                                               int id_stra_usuario,
                                               string usuario)
        {

            using (moviles4Entities moviles = new moviles4Entities())
            {
                string datos = "";
               
               stra_elefantes elefante = (from e in moviles.stra_elefantes
                                           where e.id_stra_elefante == Id
                                           select e).First();
             

                if (razonrechazo != 0)
                {
                    elefante.id_stra_razon_rechazo = razonrechazo;
                    datos += "Razón rechazo: " + razonrechazo + "// ";
                    elefante.comentario_rechazo = comentariorechazo;
                    elefante.titulo = titulo;
                    if (elefantesold.titulo != titulo)
                        datos += "Titulo: " + titulo + "// ";

                    elefante.estado_titulo = estadotitulo;
                    if (estadotitulo == 1)
                        datos += "Estado titulo: validado " + "// ";
                    else if (estadotitulo == 2)
                        datos += "Estado titulo: rechazado " + "// ";

                    elefante.entidad_responsable = entidadresponsable;
                    if (elefantesold.entidad_responsable != entidadresponsable)
                        datos += "Entidad responsable: " + entidadresponsable + "// ";
                    elefante.estado_entidad = estadoentidad;
                    if (estadoentidad == 1)
                        datos += "Estado entidad: validado " + "// ";
                    else if (estadoentidad == 2)
                        datos += "Estado entidad: rechazado " + "// ";

                    elefante.id_stra_motivo_elefante = motivo;
                    if (elefantesold.id_stra_motivo_elefante != motivo)
                        datos += "Motivo: " + motivo + "// ";

                    elefante.estado_id_motivo_elefante = estadomotivo;
                    if (estadomotivo == 1)
                        datos += "Estado motivo: validado " + "// ";
                    else if (estadomotivo == 2)
                        datos += "Estado motivo: rechazado " + "// ";
                    //El elefante queda No Aprobado
                    elefante.id_stra_estado_elefante = 3;
                    elefante.estado_imagen = 2;
                  
                }

                //rechazamos la imagen principal grande y pequena

                stra_imagenes stra_imagenes = (from e in moviles.stra_imagenes
                                               where e.id_stra_imagen == Id_imagen_principal_grande
                                               select e).First();

                stra_imagenes stra_imagenes1 = (from e in moviles.stra_imagenes
                                                where e.id_stra_imagen == Id_Imagen_principal_pequena
                                                select e).First();

                stra_imagenes.estado_imagen = 2;
                stra_imagenes1.estado_imagen = 2;
                moviles.SaveChanges();

                //Ahora hacemos el llamado para dejar el registro en auditoria.                
                LogicaAuditoria.CrearRegistroAuditoria(Id, id_stra_usuario, 3, 2, datos, usuario, titulo);
            }

        }
        #endregion
    }
}
