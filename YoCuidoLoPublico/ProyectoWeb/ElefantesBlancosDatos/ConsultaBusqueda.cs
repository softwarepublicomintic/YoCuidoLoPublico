using ElefantesBlancosDatos.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos
{
    public static class ConsultasBusqueda
    {

        #region Divipola
        public static List<RegionModels> ConsultaRegiones()
        {
            List<RegionModels> ListRegiones;
            RegionModels item = new RegionModels();
            using (moviles4Entities moviles = new moviles4Entities())
            {

                ListRegiones = (from r in moviles.stra_regiones_listado
                                select new RegionModels
                                {
                                    nombre = r.nombre,
                                    Id_stra_region = r.id_stra_region
                                }).ToList();




            }
            item.Id_stra_region = 0;
            item.nombre = " Región";
            ListRegiones.Add(item);
            ListRegiones = ListRegiones.OrderBy(s => s.Id_stra_region).ToList();
            return ListRegiones;
        }

        public static List<RegionModels> ConsultaRegionesSinElefantesRechazados()
        {
            List<RegionModels> ListRegiones;
            RegionModels item = new RegionModels();
            using (moviles4Entities moviles = new moviles4Entities())
            {

                ListRegiones = (from r in moviles.stra_regiones.AsEnumerable()
                                join e in moviles.stra_elefantes on r.id_stra_region equals e.id_stra_region
                                where e.id_stra_estado_elefante != 3
                                select new RegionModels
                                {
                                    nombre = r.nombre,
                                    Id_stra_region = r.id_stra_region
                                }).Distinct().ToList();




            }
            item.Id_stra_region = 0;
            item.nombre = " Región";
            ListRegiones.Add(item);
            ListRegiones = ListRegiones.OrderBy(s => s.Id_stra_region).ToList();
            return ListRegiones;
        }

        public static List<DepartamentoModels> ConsultaDepartamentos()
        {
            List<DepartamentoModels> ListDepatamento;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                ListDepatamento = (from d in moviles.stra_departamentos_listado.AsEnumerable()
                                   select new DepartamentoModels
                                   {
                                       nombre = (d.nombre.Length > 26 ? d.nombre.Substring(0, 26) : d.nombre),
                                       Id_stra_departamento = d.id_stra_departamento,
                                       Id_stra_region = d.id_stra_region
                                   }).Distinct().ToList();
            }
            return ListDepatamento;
        }


        public static List<DepartamentoModels> ConsultaDepartamentosPorRegion(int region)
        {
            List<DepartamentoModels> ListDepatamento;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                try
                {

                    ListDepatamento = (from d in moviles.stra_departamentos.AsEnumerable()
                                       join e in moviles.stra_elefantes on d.id_stra_departamento equals e.id_stra_departamento
                                       where d.id_stra_region == region
                                       where e.id_stra_estado_elefante != 3
                                       select new DepartamentoModels
                                       {
                                           nombre = (d.nombre.Length > 26 ? d.nombre.Substring(0, 26) : d.nombre),
                                           Id_stra_departamento = d.id_stra_departamento,
                                           Id_stra_region = d.id_stra_region
                                       }).Distinct().ToList();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }

                //ListDepatamento = new List<DepartamentoModels>();

                //foreach (stra_elefantes listaElefantes in moviles.stra_elefantes)
                //{
                //    foreach (var listaDepto in moviles.stra_departamentos)
                //    {
                //        if (listaDepto.id_stra_departamento == listaDepto.id_stra_departamento)
                //        {
                //            if (listaDepto.id_stra_region == region && listaElefantes.id_stra_estado_elefante != 3)
                //            {
                //                ListDepatamento.Add(new DepartamentoModels
                //                {
                //                    nombre = (listaDepto.nombre.Length > 26 ? listaDepto.nombre.Substring(0, 26) : listaDepto.nombre),
                //                    Id_stra_departamento = listaDepto.id_stra_departamento,
                //                    Id_stra_region = listaDepto.id_stra_region
                //                });
                //            }
                //        }
                //    }
                //}
            }

            ListDepatamento = ListDepatamento.GroupBy(p => p.Id_stra_departamento)
                                             .Select(g => g.First()).ToList();

            return ListDepatamento;
        }

        public static List<DepartamentoModels> ConsultaDepartamentosTodos()
        {
            List<DepartamentoModels> ListDepatamento;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                ListDepatamento = (from d in moviles.stra_departamentos.AsEnumerable()
                                   join e in moviles.stra_elefantes on d.id_stra_departamento equals e.id_stra_departamento
                                   where e.id_stra_estado_elefante != 3
                                   select new DepartamentoModels
                                   {
                                       nombre = (d.nombre.Length > 26 ? d.nombre.Substring(0, 26) : d.nombre),
                                       Id_stra_departamento = d.id_stra_departamento,
                                       Id_stra_region = d.id_stra_region
                                   }).Distinct().ToList();
            }

            ListDepatamento = ListDepatamento.GroupBy(p => p.Id_stra_departamento)
                                            .Select(g => g.First()).ToList();
            return ListDepatamento;
        }


        public static List<MunicipioModels> ConsultaMunicipios()
        {
            List<MunicipioModels> ListMunicipio;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                ListMunicipio = (from m in moviles.stra_municipios_listado.AsEnumerable()
                                 select new MunicipioModels
                                 {
                                     nombre = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                     Id_stra_departamento = m.id_stra_departamento,
                                     Id_stra_municipio = m.id_stra_municipio,
                                     Id_stra_region = m.id_stra_region
                                 }).Distinct().ToList();
            }
            return ListMunicipio;
        }

        public static List<MunicipioModels> ConsultaMunicipiosPorDepartamento(string departamento)
        {
            List<MunicipioModels> ListMunicipio;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                ListMunicipio = (from m in moviles.stra_municipios.AsEnumerable()
                                 join e in moviles.stra_elefantes on m.id_stra_municipio equals e.id_stra_municipio
                                 where e.id_stra_estado_elefante != 3
                                 where m.id_stra_departamento == departamento
                                 select new MunicipioModels
                                 {
                                     nombre = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                     Id_stra_departamento = m.id_stra_departamento,
                                     Id_stra_municipio = m.id_stra_municipio,
                                     Id_stra_region = e.id_stra_region
                                 }).Distinct().ToList();
            }

            ListMunicipio = ListMunicipio.GroupBy(p => p.Id_stra_municipio)
                                            .Select(g => g.First()).ToList();

            return ListMunicipio;
        }

        public static List<MunicipioModels> ConsultaMunicipiosTodos()
        {
            List<MunicipioModels> ListMunicipio;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                ListMunicipio = (from m in moviles.stra_municipios.AsEnumerable()
                                 join e in moviles.stra_elefantes on m.id_stra_municipio equals e.id_stra_municipio
                                 where e.id_stra_estado_elefante != 3
                                 select new MunicipioModels
                                 {
                                     nombre = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                     Id_stra_departamento = m.id_stra_departamento,
                                     Id_stra_municipio = m.id_stra_municipio,
                                     Id_stra_region = e.id_stra_region
                                 }).Distinct().ToList();
            }

            ListMunicipio = ListMunicipio.GroupBy(p => p.Id_stra_municipio)
                                            .Select(g => g.First()).ToList();

            return ListMunicipio;
        }

        public static List<MunicipioModels> ConsultaMunicipiosPorRegion(int region)
        {
            List<MunicipioModels> ListMunicipio;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                ListMunicipio = (from m in moviles.stra_municipios.AsEnumerable()
                                 join d in moviles.stra_elefantes on m.id_stra_departamento equals d.id_stra_departamento
                                 join e in moviles.stra_elefantes on m.id_stra_municipio equals e.id_stra_municipio
                                 where e.id_stra_estado_elefante != 3
                                 where d.id_stra_region == region
                                 select new MunicipioModels
                                 {
                                     nombre = (m.nombre.Length > 26 ? m.nombre.Substring(0, 26) : m.nombre),
                                     Id_stra_departamento = m.id_stra_departamento,
                                     Id_stra_municipio = m.id_stra_municipio,
                                     Id_stra_region = e.id_stra_region
                                 }).Distinct().ToList();
            }


            ListMunicipio = ListMunicipio.GroupBy(p => p.Id_stra_municipio)
                                            .Select(g => g.First()).ToList();

            return ListMunicipio;
        }

        #endregion

        #region Estado
        public static List<stra_estados_elefante> ConsultaEstados()
        {
            List<stra_estados_elefante> ListEstado;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                ListEstado = moviles.stra_estados_elefante.ToList();
            }
            return ListEstado;
        }

        public static List<stra_estados_elefante> ConsultaEstadosSinRechazados()
        {
            List<stra_estados_elefante> ListEstado;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                ListEstado = (from e in moviles.stra_estados_elefante
                              where e.id_stra_estado_elefante != 3
                              select e).ToList();
            }
            return ListEstado;
        }
        #endregion

        #region ElefantesBlancos
        public static List<ElefanteModels> ConsultaElefantes(string EstadoSelector,
                                                             string MunicipioSelector,
                                                             string DepartamentoSelector,
                                                             string RegionSelector,
                                                            string ValidadoSelector)
        {
            List<ElefanteModels> ListElefantes = new List<ElefanteModels>();
            using (moviles4Entities moviles = new moviles4Entities())
            {
                try
                {

                    //ListElefantes = (from e in moviles.stra_elefantes.AsEnumerable()
                    //                 from ip in moviles.stra_imagenes.Where(x => (e.id_stra_estado_elefante == 2 &&
                    //                    e.id_stra_elefante == x.id_stra_elefante && x.estado_imagen == 0 && x.tipo_imagen == 2)).ToList().DefaultIfEmpty().AsEnumerable()
                    //                 join s in moviles.stra_estados_elefante on e.id_stra_estado_elefante equals s.id_stra_estado_elefante
                    //                 join d in moviles.stra_departamentos on e.id_stra_departamento equals d.id_stra_departamento
                    //                 join m in moviles.stra_municipios on e.id_stra_municipio equals m.id_stra_municipio
                    //                 select new ElefanteModels
                    //                 {
                    //                     id_stra_elefante = e.id_stra_elefante,
                    //                     titulo = e.titulo,
                    //                     fecha_creacion = e.fecha_creacion,
                    //                     id_stra_departamento = e.id_stra_departamento,
                    //                     id_stra_municipio = e.id_stra_municipio,
                    //                     id_stra_region = e.id_stra_region,
                    //                     departamento = d.nombre,
                    //                     municipio = m.nombre,
                    //                     id_stra_estado_elefante = e.id_stra_estado_elefante,
                    //                     estado = s.nombre,
                    //                     id_stra_imagen_principal_grande = e.id_stra_imagen_principal_grande,
                    //                     id_stra_imagen_principal_pequena = e.id_stra_imagen_principal_pequena,
                    //                     no_es_un_elefante = e.no_es_un_elefante,
                    //                     imagenpendiente = (ip != null && e.id_stra_estado_elefante == 2 ? ip.id_stra_imagen : 0),
                    //                     cantidadarangotiempo = (e.estado_id_rango_tiempo == 0 && e.id_stra_rango_tiempo != null && e.id_stra_estado_elefante == 2 ? 1 : 0),
                    //                     cantidadcontratista = (e.estado_contratista == 0 && e.contratista != null && e.id_stra_estado_elefante == 2 ? 1 : 0),
                    //                     cantidadcosto = (e.estado_costo == 0 && e.costo != null && e.id_stra_estado_elefante == 2 ? 1 : 0),
                    //                     EsImagen = (ip != null && e.id_stra_estado_elefante == 2 ? true : false),
                    //                     EsInformacion = ((e.estado_id_rango_tiempo == 0 && e.id_stra_rango_tiempo != null && e.id_stra_estado_elefante == 2)
                    //                                           || (e.estado_contratista == 0 && !String.IsNullOrEmpty(e.contratista) && e.id_stra_estado_elefante == 2)
                    //                     || (e.estado_costo == 0 && e.costo > 0 && e.id_stra_estado_elefante == 2) ? true : false)
                    //                 }).ToList();

                    foreach (var dataElefantes in moviles.stra_elefantes.ToList())
                    {

                        string departamento = string.Empty;
                        string municipio = string.Empty;
                        string estado = string.Empty;


                        foreach (var depto in moviles.stra_departamentos.ToList())
                        {
                            if (depto.id_stra_departamento == dataElefantes.id_stra_departamento)
                            {
                                departamento = depto.nombre;
                            }
                        }


                        foreach (var dataMun in moviles.stra_municipios)
                        {
                            if (dataMun.id_stra_municipio == dataElefantes.id_stra_municipio)
                            {
                                municipio = dataMun.nombre;
                            }
                        }


                        foreach (var dataEstado in moviles.stra_estados_elefante)
                        {
                            if (dataEstado.id_stra_estado_elefante == dataElefantes.id_stra_estado_elefante)
                            {
                                estado = dataEstado.nombre;
                            }
                        }

                        int? imagenId = null;

                       
                        bool esImagen = false;

                        foreach (var dataImagenes in moviles.stra_imagenes.ToList())
                        {
                         


                            if (dataElefantes.id_stra_estado_elefante == 2
                                && dataElefantes.id_stra_elefante == dataImagenes.id_stra_elefante
                                && dataElefantes.estado_imagen == 0
                                && dataImagenes.tipo_imagen == 2)
                            {
                                imagenId = dataImagenes.id_stra_imagen;
                                esImagen = true;

                            }

                        }




                        ListElefantes.Add(new ElefanteModels
                        {
                            id_stra_elefante = dataElefantes.id_stra_elefante,
                            titulo = dataElefantes.titulo,
                            fecha_creacion = dataElefantes.fecha_creacion,
                            id_stra_departamento = dataElefantes.id_stra_departamento,
                            id_stra_municipio = dataElefantes.id_stra_municipio,
                            id_stra_region = dataElefantes.id_stra_region,
                            departamento = departamento,
                            municipio = municipio,
                            id_stra_estado_elefante = dataElefantes.id_stra_estado_elefante,
                            estado = estado,
                            id_stra_imagen_principal_grande = dataElefantes.id_stra_imagen_principal_grande,
                            id_stra_imagen_principal_pequena = dataElefantes.id_stra_imagen_principal_pequena,
                            no_es_un_elefante = dataElefantes.no_es_un_elefante,
                            imagenpendiente = imagenId,
                            cantidadarangotiempo = (dataElefantes.estado_id_rango_tiempo == 0 && dataElefantes.id_stra_rango_tiempo != null && dataElefantes.id_stra_estado_elefante == 2 ? 1 : 0),
                            cantidadcontratista = (dataElefantes.estado_contratista == 0 && dataElefantes.contratista != null && dataElefantes.id_stra_estado_elefante == 2 ? 1 : 0),
                            cantidadcosto = (dataElefantes.estado_costo == 0 && dataElefantes.costo != null && dataElefantes.id_stra_estado_elefante == 2 ? 1 : 0),
                            EsImagen = esImagen,
                            EsInformacion = ((dataElefantes.estado_id_rango_tiempo == 0 && dataElefantes.id_stra_rango_tiempo != null && dataElefantes.id_stra_estado_elefante == 2)
                                                         || (dataElefantes.estado_contratista == 0 && !String.IsNullOrEmpty(dataElefantes.contratista) && dataElefantes.id_stra_estado_elefante == 2)
                                   || (dataElefantes.estado_costo == 0 && dataElefantes.costo > 0 && dataElefantes.id_stra_estado_elefante == 2) ? true : false)
                        });

                    }


                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }

            }
            // Luego agregamos los filtros.
            if ((!String.IsNullOrEmpty(EstadoSelector)) && (!String.IsNullOrEmpty(MunicipioSelector)) && (MunicipioSelector != "0"))
            {
                int intEstado = Convert.ToInt32(EstadoSelector);
                if (intEstado == 2)
                {
                    if (!String.IsNullOrEmpty(ValidadoSelector))
                    {
                        switch (ValidadoSelector)
                        {
                            case "2":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_municipio == MunicipioSelector && e.EsImagen == true).ToList();
                                break;
                            case "3":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_municipio == MunicipioSelector && e.EsInformacion == true).ToList();
                                break;
                            case "4":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_municipio == MunicipioSelector && e.no_es_un_elefante == true).ToList();
                                break;
                            default:
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_municipio == MunicipioSelector).ToList();
                                break;
                        }
                    }
                    else
                    {
                        ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_municipio == MunicipioSelector).ToList();
                    }
                }
                else
                {
                    ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_municipio == MunicipioSelector).ToList();
                }

            }
            else if ((!String.IsNullOrEmpty(EstadoSelector)) && (!String.IsNullOrEmpty(DepartamentoSelector)) && (DepartamentoSelector != "0"))
            {
                int intEstado = Convert.ToInt32(EstadoSelector);
                if (intEstado == 2)
                {
                    if (!String.IsNullOrEmpty(ValidadoSelector))
                    {
                        switch (ValidadoSelector)
                        {
                            case "2":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_departamento == DepartamentoSelector && e.EsImagen == true).ToList();
                                break;
                            case "3":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_departamento == DepartamentoSelector && e.EsInformacion == true).ToList();
                                break;
                            case "4":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_departamento == DepartamentoSelector && e.no_es_un_elefante == true).ToList();
                                break;
                            default:
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_departamento == DepartamentoSelector).ToList();
                                break;
                        }
                    }
                    else
                    {
                        ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_departamento == DepartamentoSelector).ToList();
                    }
                }
                else
                {
                    ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_departamento == DepartamentoSelector).ToList();
                }

            }
            else if ((!String.IsNullOrEmpty(EstadoSelector)) && (!String.IsNullOrEmpty(RegionSelector)) && (RegionSelector != "0"))
            {
                int intEstado = Convert.ToInt32(EstadoSelector);
                int Region = Convert.ToInt32(RegionSelector);
                if (intEstado == 2)
                {
                    if (!String.IsNullOrEmpty(ValidadoSelector))
                    {
                        switch (ValidadoSelector)
                        {
                            case "2":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_region == Region && e.EsImagen == true).ToList();
                                break;
                            case "3":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_region == Region && e.EsInformacion == true).ToList();
                                break;
                            case "4":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_region == Region && e.no_es_un_elefante == true).ToList();
                                break;
                            default:
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_region == Region).ToList();
                                break;
                        }
                    }
                    else
                    {
                        ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_region == Region).ToList();
                    }
                }
                else
                {
                    ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.id_stra_region == Region).ToList();
                }

            }
            else if (!String.IsNullOrEmpty(EstadoSelector))
            {
                int intEstado = Convert.ToInt32(EstadoSelector);
                if (intEstado == 2)
                {
                    if (!String.IsNullOrEmpty(ValidadoSelector))
                    {
                        switch (ValidadoSelector)
                        {
                            case "2":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.EsImagen == true).ToList();
                                break;
                            case "3":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.EsInformacion == true).ToList();
                                break;
                            case "4":
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado && e.no_es_un_elefante == true).ToList();
                                break;
                            default:
                                ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado).ToList();
                                break;
                        }
                    }
                    else
                    {
                        ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado).ToList();
                    }
                }
                else
                {
                    ListElefantes = ListElefantes.Where(e => e.id_stra_estado_elefante == intEstado).ToList();
                }


            }
            else if (!String.IsNullOrEmpty(MunicipioSelector) && (MunicipioSelector != "0"))
            {
                ListElefantes = ListElefantes.Where(e => e.id_stra_municipio == MunicipioSelector).ToList();
            }
            else if (!String.IsNullOrEmpty(DepartamentoSelector) && (DepartamentoSelector != "0"))
            {
                ListElefantes = ListElefantes.Where(e => e.id_stra_departamento == DepartamentoSelector).ToList();
            }
            else if (!String.IsNullOrEmpty(RegionSelector) && (RegionSelector != "0"))
            {
                int Region = int.Parse(RegionSelector);
                ListElefantes = ListElefantes.Where(e => e.id_stra_region == Region).ToList();
            }


            return ListElefantes;
        }

        public static long CantidadElefantesBlancosPendientes()
        {
            long longElefantesBlancosPendientes = 0;
            using (moviles4Entities moviles = new moviles4Entities())
            {
                var cantidadPendiente = moviles.stra_cantidad_elefantes_pendientes.ToList();

                foreach (stra_cantidad_elefantes_pendientes item in cantidadPendiente)
                    longElefantesBlancosPendientes = item.Cantidad;


            }
            return longElefantesBlancosPendientes;
        }

        public static long CantidadElefantesBlancosAprobados()
        {
            long longElefantesBlancosAprobados = 0;
            using (moviles4Entities moviles = new moviles4Entities())
            {

                var cantidadAprobados = moviles.stra_cantidad_elefantes_aprobados.ToList();

                foreach (stra_cantidad_elefantes_aprobados item in cantidadAprobados)
                    longElefantesBlancosAprobados = item.Cantidad;


            }
            return longElefantesBlancosAprobados;
        }

        public static long CantidadImagenesPendientes()
        {
            long longImagenesPendientes = 0;
            using (moviles4Entities moviles = new moviles4Entities())
            {

                var cantidadimagenes = moviles.stra_cantidad_imagenes_pendientes.ToList();

                foreach (var item in cantidadimagenes)
                    longImagenesPendientes = item.cantidad;
            }
            return longImagenesPendientes;
        }

        public static long CantidadInformacionPendiente()
        {
            long longInformacionPendiente = 0;
            using (moviles4Entities moviles = new moviles4Entities())
            {

                List<ElefanteModels> ListElefantes = new List<ElefanteModels>();

                longInformacionPendiente = (from e in moviles.stra_elefantes.Where(x => (x.estado_id_rango_tiempo == 0 && x.id_stra_rango_tiempo != null) ||
                                                                        (x.estado_contratista == 0 && !String.IsNullOrEmpty(x.contratista)) ||
                                                                        (x.estado_costo == 0 && x.costo > 0))
                                            where e.id_stra_estado_elefante == 2
                                            select e).Count();



            }
            return longInformacionPendiente;
        }


        public static List<EncabezadoModels> ConsultaEncabezado(int Id)
        {
            List<EncabezadoModels> list = new List<EncabezadoModels>();
            using (moviles4Entities moviles = new moviles4Entities())
            {


                list = (from e in moviles.stra_elefantes
                        join s in moviles.stra_estados_elefante on e.id_stra_estado_elefante equals s.id_stra_estado_elefante
                        join d in moviles.stra_departamentos on e.id_stra_departamento equals d.id_stra_departamento
                        join m in moviles.stra_municipios on e.id_stra_municipio equals m.id_stra_municipio
                        where (e.id_stra_elefante == Id)
                        select new EncabezadoModels
                        {
                            Estado = s.nombre,
                            Ubicacion = d.nombre + " - " + m.nombre + " " + (e.direccion != null ? e.direccion : " "),
                            Fecha = e.fecha_creacion,
                            NoesunElefante = e.no_es_un_elefante
                        }).ToList();


            }
            return list;
        }

        public static int CantidadImagenesPendientes(int Id)
        {
            int cantidad = 0;
            using (moviles4Entities moviles = new moviles4Entities())
            {


                var elefante = (from i in moviles.stra_imagenes
                                join e in moviles.stra_elefantes on i.id_stra_elefante equals e.id_stra_elefante
                                where (e.id_stra_elefante == Id)
                                where (e.id_stra_estado_elefante == 2)
                                where (i.estado_imagen == 0)
                                select i).Count();

                cantidad = (int)elefante;

            }
            return cantidad;
        }

        public static List<EncabezadoImagen> ConsultaEncabezadoPorImagenId(int ImagenId)
        {
            List<EncabezadoImagen> list = new List<EncabezadoImagen>();
            using (moviles4Entities moviles = new moviles4Entities())
            {


                list = (from e in moviles.stra_elefantes
                        join s in moviles.stra_estados_elefante on e.id_stra_estado_elefante equals s.id_stra_estado_elefante
                        join d in moviles.stra_departamentos on e.id_stra_departamento equals d.id_stra_departamento
                        join m in moviles.stra_municipios on e.id_stra_municipio equals m.id_stra_municipio
                        join i in moviles.stra_imagenes on e.id_stra_elefante equals i.id_stra_elefante
                        where (i.id_stra_imagen == ImagenId)
                        select new EncabezadoImagen
                        {
                            Estado = s.nombre,
                            Ubicacion = d.nombre + " - " + m.nombre,
                            Fecha = e.fecha_creacion,
                            NoesunElefante = e.no_es_un_elefante,
                            Id_stra_elefante = e.id_stra_elefante,
                            Id_Imagen_Grande = i.id_stra_imagen_asociada,
                            titulo = e.titulo
                        }).ToList();


            }
            return list;
        }


        public static List<ImagenesAprobadas> ConsultaImagenesPequenas(int Id_stra_elefante)
        {
            List<ImagenesAprobadas> list = new List<ImagenesAprobadas>();
            using (moviles4Entities moviles = new moviles4Entities())
            {


                list = (from i in moviles.stra_imagenes
                        join e in moviles.stra_elefantes on i.id_stra_elefante equals e.id_stra_elefante
                        where (e.id_stra_elefante == Id_stra_elefante)
                        where (i.tipo_imagen == 2)
                        where (i.estado_imagen == 1)
                        select new ImagenesAprobadas
                        {
                            Id = i.id_stra_imagen,
                            Id_Imagen_principal_pequena = (int)e.id_stra_imagen_principal_pequena

                        }).ToList();



            }
            return list;
        }

        public static List<ImageModels> ConsultaImagenesPequenaVisor(int Id_stra_elefante)
        {
            List<ImageModels> list = new List<ImageModels>();
            using (moviles4Entities moviles = new moviles4Entities())
            {


                list = (from i in moviles.stra_imagenes
                        join e in moviles.stra_elefantes on i.id_stra_elefante equals e.id_stra_elefante
                        where (e.id_stra_elefante == Id_stra_elefante)
                        where (i.tipo_imagen == 2)
                        where (i.estado_imagen == 1)
                        select new ImageModels
                        {
                            Id = i.id_stra_imagen,
                            Idpadre = i.id_stra_imagen_asociada,
                            Description = "",
                            Tittle = "",
                            Isprincipal = (e.id_stra_imagen_principal_pequena == i.id_stra_imagen)
                        }).ToList();



            }
            return list;
        }


        public static List<ImageModels> ConsultaImagenesGrandesVisor(int Id_stra_elefante)
        {
            List<ImageModels> list = new List<ImageModels>();
            using (moviles4Entities moviles = new moviles4Entities())
            {


                list = (from i in moviles.stra_imagenes
                        join e in moviles.stra_elefantes on i.id_stra_elefante equals e.id_stra_elefante
                        where (e.id_stra_elefante == Id_stra_elefante)
                        where (i.tipo_imagen == 1)
                        where (i.estado_imagen == 1)
                        select new ImageModels
                        {
                            Id = i.id_stra_imagen,
                            Description = "",
                            Tittle = "",
                            Isprincipal = (e.id_stra_imagen_principal_grande == i.id_stra_imagen)
                        }).ToList();



            }
            return list;
        }




        #endregion

    }
}
