using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos.Models
{
    public class AuditoriaModels
    {
        public int id_stra_auditoria { get; set; }
        public int id_stra_accion { get; set; }
        public int id_stra_elefante { get; set; }
        public int id_stra_usuario { get; set; }
        public int id_stra_tipo { get; set; }
        public string datos { get; set; }
        public System.DateTime fecha_creacion { get; set; }
        public string usuario { get; set; }
        public string titulo { get; set; }
        public string tipo { get; set; }
        public string accion { get; set; }
    }
}
