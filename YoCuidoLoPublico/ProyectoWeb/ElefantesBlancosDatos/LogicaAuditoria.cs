using ElefantesBlancosDatos.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos
{
    public static class LogicaAuditoria
    {
        public static void CrearRegistroAuditoria(int id_stra_elefante,
                                                  int id_stra_usuario,
                                                  int id_stra_accion,
                                                  int id_stra_tipo,
                                                  string datos,
                                                  string usuario,
                                                  string titulo)
                                
        {
            try
            {
                using (AuditoriaEntities db = new AuditoriaEntities())
                {
                    stra_auditoria auditoria = new stra_auditoria();
                    auditoria.id_stra_elefante = id_stra_elefante;
                    auditoria.id_stra_usuario = id_stra_usuario;
                    auditoria.id_stra_accion = id_stra_accion;
                    auditoria.id_stra_tipo = id_stra_tipo;
                    auditoria.fecha_creacion = DateTime.Now;
                    auditoria.datos = datos;
                    auditoria.usuario = usuario;
                    auditoria.titulo = titulo;

                    db.stra_auditoria.Add(auditoria);
                    db.SaveChanges();

                }
            }
            catch (DbEntityValidationException e)
            {
                string str = e.Message;
            }

        }

        public static List<AuditoriaModels> ConsultaAuditoria(string fechaInicio = "", string fechafinal = "", string titulo = "", int UserID = 0, int accion = 0)
        {
            List<AuditoriaModels> listAuditoria = new List<AuditoriaModels>();
            DateTime datFechaInicio;
            DateTime datFechaFinal;
            using (AuditoriaEntities auditoria = new AuditoriaEntities())
            {
                datFechaInicio = DateTime.Parse(fechaInicio);
                datFechaFinal = DateTime.Parse(fechafinal);
                datFechaFinal= datFechaFinal.AddDays(1);
                datFechaFinal = datFechaFinal.AddHours(-1);
                if ((fechaInicio != "") && (fechafinal != "") && (!String.IsNullOrEmpty(titulo)) && (UserID != 0) && (accion != 0))
                {
                   
                    listAuditoria = (from a in auditoria.stra_auditoria
                                     join t in auditoria.stra_tipos on a.id_stra_tipo equals t.id_stra_tpo
                                     join c in auditoria.stra_acciones on a.id_stra_accion equals c.id_stra_accion
                                     where a.titulo.Contains(titulo)
                                     where a.fecha_creacion >= datFechaInicio
                                     where a.fecha_creacion <= datFechaFinal
                                     where a.id_stra_usuario == UserID
                                     where a.id_stra_accion == accion
                                     select new AuditoriaModels {
                                         id_stra_elefante = a.id_stra_elefante,
                                         id_stra_accion = a.id_stra_accion,
                                         id_stra_auditoria = a.id_stra_auditoria,
                                         usuario = a.usuario,
                                         titulo = a.titulo,
                                         fecha_creacion = a.fecha_creacion,
                                         tipo = t.nombre,
                                         accion = c.nombre,
                                        datos = a.datos 
                                     }).ToList();
                }
                else if ((fechaInicio != "") && (fechafinal != "") && (!String.IsNullOrEmpty(titulo)) && (UserID == 0) && (accion != 0))
                {
                   
                    listAuditoria = (from a in auditoria.stra_auditoria
                                     join t in auditoria.stra_tipos on a.id_stra_tipo equals t.id_stra_tpo
                                     join c in auditoria.stra_acciones on a.id_stra_accion equals c.id_stra_accion
                                     where a.titulo.Contains(titulo)
                                     where a.fecha_creacion >= datFechaInicio
                                     where a.fecha_creacion <= datFechaFinal
                                     where a.id_stra_accion == accion
                                     select new AuditoriaModels
                                     {
                                         id_stra_elefante = a.id_stra_elefante,
                                         id_stra_accion = a.id_stra_accion,
                                         id_stra_auditoria = a.id_stra_auditoria,
                                         usuario = a.usuario,
                                         titulo = a.titulo,
                                         fecha_creacion = a.fecha_creacion,
                                         tipo = t.nombre,
                                         accion = c.nombre,
                                         datos = a.datos
                                     }).ToList();
                }
                else if ((fechaInicio != "") && (fechafinal != "") && (String.IsNullOrEmpty(titulo)) && (UserID != 0) && (accion != 0))
                {
                   
                    listAuditoria = (from a in auditoria.stra_auditoria
                                     join t in auditoria.stra_tipos on a.id_stra_tipo equals t.id_stra_tpo
                                     join c in auditoria.stra_acciones on a.id_stra_accion equals c.id_stra_accion
                                     where a.fecha_creacion >= datFechaInicio
                                     where a.fecha_creacion <= datFechaFinal
                                     where a.id_stra_accion == accion
                                     where a.id_stra_usuario == UserID
                                     select new AuditoriaModels
                                     {
                                         id_stra_elefante = a.id_stra_elefante,
                                         id_stra_accion = a.id_stra_accion,
                                         id_stra_auditoria = a.id_stra_auditoria,
                                         usuario = a.usuario,
                                         titulo = a.titulo,
                                         fecha_creacion = a.fecha_creacion,
                                         tipo = t.nombre,
                                         accion = c.nombre,
                                         datos = a.datos
                                     }).ToList();
                }
                else if ((fechaInicio != "") && (fechafinal != "") && (String.IsNullOrEmpty(titulo)) && (UserID == 0) && (accion != 0))
                {
                   
                    listAuditoria = (from a in auditoria.stra_auditoria
                                     join t in auditoria.stra_tipos on a.id_stra_tipo equals t.id_stra_tpo
                                     join c in auditoria.stra_acciones on a.id_stra_accion equals c.id_stra_accion
                                     where a.fecha_creacion >= datFechaInicio
                                     where a.fecha_creacion <= datFechaFinal
                                     where a.id_stra_accion == accion
                                     select new AuditoriaModels
                                     {
                                         id_stra_elefante = a.id_stra_elefante,
                                         id_stra_accion = a.id_stra_accion,
                                         id_stra_auditoria = a.id_stra_auditoria,
                                         usuario = a.usuario,
                                         titulo = a.titulo,
                                         fecha_creacion = a.fecha_creacion,
                                         tipo = t.nombre,
                                         accion = c.nombre,
                                         datos = a.datos
                                     }).ToList();
                }

                else if ((fechaInicio != "") && (fechafinal != "") && (!String.IsNullOrEmpty(titulo)) && (UserID == 0) && (accion == 0))
                {

                    listAuditoria = (from a in auditoria.stra_auditoria
                                     join t in auditoria.stra_tipos on a.id_stra_tipo equals t.id_stra_tpo
                                     join c in auditoria.stra_acciones on a.id_stra_accion equals c.id_stra_accion
                                     where a.fecha_creacion >= datFechaInicio
                                     where a.fecha_creacion <= datFechaFinal
                                     where a.titulo.Contains(titulo)
                                     select new AuditoriaModels
                                     {
                                         id_stra_elefante = a.id_stra_elefante,
                                         id_stra_accion = a.id_stra_accion,
                                         id_stra_auditoria = a.id_stra_auditoria,
                                         usuario = a.usuario,
                                         titulo = a.titulo,
                                         fecha_creacion = a.fecha_creacion,
                                         tipo = t.nombre,
                                         accion = c.nombre,
                                         datos = a.datos
                                     }).ToList();
                } 
            }
            return listAuditoria;
        }

        public static void ActualizarAdicionarFoto()
        {
            using (AuditoriaEntities auditoria = new AuditoriaEntities())
            {
                var listauditoria = (from a in auditoria.stra_auditoria
                                 where a.id_stra_accion == 8
                                 where a.titulo == "" || a.titulo == null
                                 select a);

                foreach (var item in listauditoria)
                {
                    string titulo = " ";
                    using (moviles4Entities moviles = new moviles4Entities())
                    {
                        titulo = (from e in moviles.stra_elefantes
                                  where e.id_stra_elefante == item.id_stra_elefante
                                  select e).FirstOrDefault().titulo;
                    }

                    item.titulo = titulo;

                }

                auditoria.SaveChanges();
            }
        }
    }


    

}
