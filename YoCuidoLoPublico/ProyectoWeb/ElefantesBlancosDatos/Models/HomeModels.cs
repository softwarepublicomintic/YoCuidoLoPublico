using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos.Models
{
    public class HomeModels
    {
        public List<RegionModels> ListRegionModels { get; set; }
        public List<DepartamentoModels> ListDepartamentoModels { get; set; }
        public List<MunicipioModels> ListMunicipioModels { get; set; }
        public List<stra_elefantes_detalle> ListElefanteModels { get; set; }
        public List<stra_estados_elefante> ListEstadoModels { get; set; }
        public long CantidadElefantesPendientes { get; set; }
        public long CantidadElefantesAprobados { get; set; }
        public long CantidadImagenesPendientes { get; set; }
        public long CantidadInformacionPendiete { get; set; }
    }
}
