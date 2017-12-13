using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos.Models
{
    public class RegionModels
    {
        public int Id_stra_region { get; set; }
        public string nombre { get; set; }
       
    }

    public class DepartamentoModels
    {
        [Key]
        public int Id_stra_region { get; set; }
        public string Id_stra_departamento { get; set; }
        public string nombre { get; set; }

    }

    public class MunicipioModels
    {
        public int Id_stra_region { get; set; }
        public string Id_stra_departamento { get; set; }
        public string Id_stra_municipio { get; set; }
        public string nombre { get; set; }

    }

   
}
