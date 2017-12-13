using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElefantesBlancos.Utils
{
    public static class UtilsImagen
    {
        const string rutapadre = @"../ElefantesImagenes";




        public static string ObtenerRuta(int Id_Imagen)
        {
            string ruta = "";
            int Dir_Interno = 0;
            int Dir_Externo = 0;
            Dir_Interno = (Id_Imagen % 1048576) / 1024;
            Dir_Externo = (Id_Imagen / 1048576);

            ruta = rutapadre + @"/" + Dir_Externo.ToString() + @"/" + Dir_Interno.ToString() + @"/" + Id_Imagen.ToString() + @".jpg";

#if DEBUG
            ruta = @"../ElefantesImagenes/0" + @"/" + Id_Imagen.ToString() + @".jpg";
#endif

           


            return ruta;
        }
    }
}