using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ElefantesBlancosDatos.Models;
using ElefantesBlancosDatos; 
namespace ElefantesBlancosDatos
{
    public static class Parametros
    {

        
        public static string recuperarparametro(string parametro){
            string devparametro = "";
            try
            {
                moviles4Entities db = new moviles4Entities();
                stra_parametros stra_parametros = db.stra_parametros.Find(parametro);
                db.Dispose();
                devparametro = stra_parametros.valor;
                
            }
            catch (Exception e)
            {
                throw new Exception("No es posible establecer parametro: " + parametro, e.InnerException);
            }

           
        return devparametro;

        }


    }
}