using ElefantesBlancosDatos.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos
{
    public class Imagenes
    {

        public void ActualizarEstadoImagenes(int Id, int UserID, string usuario, string titulo)
        {

            using (moviles4Entities moviles = new moviles4Entities())
            {
                int Id_imagen_asociada = 0;
                stra_imagenes imagenes = (from i in moviles.stra_imagenes
                                           where i.id_stra_imagen == Id
                                           select i).First();


                imagenes.estado_imagen = 1;
                if (imagenes.id_stra_imagen_asociada != null)
                    Id_imagen_asociada = (int)imagenes.id_stra_imagen_asociada;

                if (Id_imagen_asociada != 0)
                {
                    stra_imagenes imagenes1 = (from i in moviles.stra_imagenes
                                               where i.id_stra_imagen == Id_imagen_asociada
                                              select i).First();

                    imagenes1.estado_imagen = 1;
                }

                moviles.SaveChanges();
                LogicaAuditoria.CrearRegistroAuditoria((int)imagenes.id_stra_elefante, UserID, 6, 2, "Se aprobó la foto: " + Id.ToString(), usuario, titulo);

                int cantidadImagenesAprobadas = (from i in moviles.stra_imagenes
                                          where i.id_stra_elefante == imagenes.id_stra_elefante
                                          where i.tipo_imagen == 1
                                          where i.estado_imagen == 1
                                          select i).Count();

                if (cantidadImagenesAprobadas == 10)
                {
                    List<stra_imagenes> listImagenesPendientes = (from i in moviles.stra_imagenes
                                                                  where i.id_stra_elefante == imagenes.id_stra_elefante
                                                                  where i.tipo_imagen == 2
                                                                  where i.estado_imagen == 0
                                                                  select i).ToList();

                    foreach (var item in listImagenesPendientes)
                    {
                        //Están quemados el id del usuario
                        ActualizarRechazoImagen(item.id_stra_imagen, 2, " ", Convert.ToInt32(Parametros.recuperarparametro("CodigoAdministrador")), "Administrador", titulo);
                    }
                }
            }

        }

        public void ActualizarRechazoImagen(int Id, int? Id_rechazo, string rechazo, int UserID, string usuario, string titulo)
        {

            using (moviles4Entities moviles = new moviles4Entities())
            {
                int Id_imagen_asociada = 0;

                stra_imagenes imagenes = (from i in moviles.stra_imagenes
                                          where i.id_stra_imagen == Id
                                          select i).First();


                imagenes.estado_imagen = 2;
                imagenes.id_stra_razon_rechazo = Id_rechazo;
                imagenes.razon_rechazo = rechazo;
                if (imagenes.id_stra_imagen_asociada != null)
                    Id_imagen_asociada = (int)imagenes.id_stra_imagen_asociada;

                if (Id_imagen_asociada != 0)
                {
                    stra_imagenes imagenes1 = (from i in moviles.stra_imagenes
                                               where i.id_stra_imagen == Id_imagen_asociada
                                               select i).First();

                    imagenes1.estado_imagen = 2;
                    imagenes1.id_stra_razon_rechazo = Id_rechazo;
                    imagenes1.razon_rechazo = rechazo;
                }
                moviles.SaveChanges();
                LogicaAuditoria.CrearRegistroAuditoria((int)imagenes.id_stra_elefante, UserID, 7, 2, "Se rechazó la foto: " + Id.ToString(), usuario, titulo);

            }

        }
    }
}
