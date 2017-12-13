using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos.Models
{
    public class ElefanteModels
    {
        public int id_stra_elefante { get; set; }
        public string titulo { get; set; }
        public bool no_es_un_elefante { get; set; }
        [DataType(DataType.DateTime)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:dd/MM/yyyy}")]
        public System.DateTime fecha_creacion { get; set; }
        public string id_stra_departamento { get; set; }
        public int id_stra_region { get; set; }
        public string id_stra_municipio { get; set; }
        public string departamento { get; set; }
        public string municipio { get; set; }
        public string region { get; set; }
        public int id_stra_estado_elefante { get; set; }
        public string estado { get; set; }
        public Nullable<int> id_stra_imagen_principal_pequena { get; set; }
        public Nullable<int> id_stra_imagen_principal_grande { get; set; }
        public Nullable<int> imagenpendiente { get; set; }
        public int cantidadarangotiempo { get; set; }
        public int cantidadcosto { get; set; }
        public int cantidadcontratista { get; set; }
        public string ruta { get; set; }
        public bool EsInformacion { get; set; }
        public bool EsImagen { get; set; }
    }

    public class Elefantesregionmodels
    {
        public int id_stra_region { get; set; }
        public int cantidad { get; set; }
    }
}
