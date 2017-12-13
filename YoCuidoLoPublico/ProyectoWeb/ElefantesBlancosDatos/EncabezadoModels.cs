using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos
{
    public class EncabezadoModels
    {
        public int Id_stra_elefante { get; set; }
        public string Estado { get; set; }
        public string Ubicacion { get; set; }
        public DateTime Fecha { get; set; }
        public bool NoesunElefante { get; set; }
        public int IdImagenPrincipal { get; set; }
        public string RutaImagenPrincipal { get; set; }

    }

   

    public class EncabezadoImagen
    {
        public int Id_stra_elefante { get; set; }
        public string Estado { get; set; }
        public string Ubicacion { get; set; }
        public DateTime Fecha { get; set; }
        public bool NoesunElefante { get; set; }
        public int? Id_Imagen_Grande { get; set; }
        public string RutaImagenGrande { get; set; }
        public string titulo { get; set; }

    }

    public class ImagenesAprobadas
    {
        public int Id { get; set; }
        public string ruta { get; set; }
        public bool EsPrincipal { get; set; }
        public int Id_Imagen_principal_pequena { get; set; }
       
    }

    public class ListData
    {
        public string text { get; set; }
        public string value { get; set; }
  
    }


    public class ListUsuarios
    {
        public string text { get; set; }
        public int value { get; set; }

    }
}
