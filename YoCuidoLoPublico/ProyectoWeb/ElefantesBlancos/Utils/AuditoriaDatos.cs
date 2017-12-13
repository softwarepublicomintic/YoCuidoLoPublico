using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElefantesBlancos.Utils
{
    public class AuditoriaDatos
    {
        public int Codigo { get; set; }
            public string Titulo { get; set; }
            public string Gestor { get; set; }
            public string FechaModificación { get; set; }
            public string Tipo { get; set; }
            public string Acción { get; set; }
            public string CambiosRealizados { get; set; }

        
    }
}