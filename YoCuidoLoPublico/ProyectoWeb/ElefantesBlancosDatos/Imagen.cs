using ElefantesBlancosDatos.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;

namespace ElefantesBlancosDatos
{
    public static class Imagen
    {
        private static string ObtenerRuta()
        {
            string rutabase = "";
            using (moviles4Entities moviles = new moviles4Entities())
            {

                rutabase = moviles.stra_rutas.First().ruta;


            }
            return rutabase;
        }

        public static void CopiarCache(int Id_Imagen, string rutaserver = "", bool imagenPeq = false)
        {
            string rutafuente, rutadestino;

            rutadestino = ArmarRutaDestino(Id_Imagen, rutaserver);
            rutafuente = ArmarRutaImagen(Id_Imagen);
            //Obtenemos la imagen del filesystem       


            if (File.Exists(rutadestino) == false && imagenPeq == false)
            {
                if (File.Exists(rutafuente) == true)
                {
                    Image image = Image.FromFile(rutafuente);
                    int ancho, alto = 0;
                    ancho = image.Width;
                    alto = image.Height;
                    while (ancho > 1000)
                    {
                        ancho = ancho / 2;
                        alto = alto / 2;
                    }
                    image = Redimensionar(image, ancho, alto, 72);
                    image.Save(rutadestino);
                    image.Dispose();
                   
                }

            }
            else if (File.Exists(rutadestino) == false && imagenPeq == true)
            {
                if (File.Exists(rutafuente) == true)
                {
                    File.Copy(rutafuente, rutadestino);
                }
            }


        }


        private static Image Redimensionar(Image Imagen, int Ancho, int Alto, int resolucion)
        {
            //Bitmap sera donde trabajaremos los cambios

            using (Bitmap imagenBitmap = new Bitmap(Ancho, Alto, PixelFormat.Format32bppRgb))
            {
                imagenBitmap.SetResolution(resolucion, resolucion);
                //Hacemos los cambios a ImagenBitmap usando a ImagenGraphics y la Imagen Original(Imagen)
                //ImagenBitmap se comporta como un objeto de referenciado
                using (Graphics imagenGraphics = Graphics.FromImage(imagenBitmap))
                {
                    imagenGraphics.SmoothingMode = SmoothingMode.AntiAlias;
                    imagenGraphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    imagenGraphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    imagenGraphics.DrawImage(Imagen, new Rectangle(0, 0, Ancho, Alto), new Rectangle(0, 0, Imagen.Width, Imagen.Height), GraphicsUnit.Pixel);
                    //todos los cambios hechos en imagenBitmap lo llevaremos un Image(Imagen) con nuevos datos a travez de un MemoryStream
                    MemoryStream imagenMemoryStream = new MemoryStream();
                    imagenBitmap.Save(imagenMemoryStream, ImageFormat.Jpeg);
                    Imagen = Image.FromStream(imagenMemoryStream);
                }
            }
            return Imagen;
        }

        public static void EliminarCache(int Id_Imagen, string rutaserver = "")
        {
            string rutadestino;
            rutadestino = ArmarRutaDestino(Id_Imagen, rutaserver);
            if (File.Exists(rutadestino) == true)
            {
                File.Delete(rutadestino);
            }
        }

        private static string ArmarRutaImagen(int Id_Imagen)
        {
            int Dir_Interno = 0;
            int Dir_Externo = 0;
            Dir_Interno = (Id_Imagen % 1048576) / 1024;
            Dir_Externo = (Id_Imagen / 1048576);
            string RutaImagen = "";
            RutaImagen = ObtenerRuta() + @"\" + Dir_Externo.ToString() + @"\" + Dir_Interno.ToString() + @"\" + Id_Imagen.ToString() + @".jpg";
            //RutaImagen = @"C:\RepositorioPruebasInternas" + @"\" + Dir_Externo.ToString() + @"\" + Dir_Interno.ToString() + @"\" + Id_Imagen.ToString() + @".jpg";
            return RutaImagen;
        }

      
        private static string ArmarRutaDestino(int Id_Imagen, string rutaserver="")
        {
            string rutapadre = rutaserver ;
            string ruta = "";
            int Dir_Interno = 0;
            int Dir_Externo = 0;
            Dir_Interno = (Id_Imagen % 1048576) / 1024;
            Dir_Externo = (Id_Imagen / 1048576);


            DirectoryInfo DirectoryInfo = new DirectoryInfo(rutaserver);
            if (Directory.Exists(DirectoryInfo.FullName + "\\" + Dir_Externo) == false)
            {
                Directory.CreateDirectory(DirectoryInfo.FullName + "\\" + Dir_Externo);
            }

            if (Directory.Exists(DirectoryInfo.FullName + "\\" + Dir_Externo + "\\" + Dir_Interno) == false)
            {
                Directory.CreateDirectory(DirectoryInfo.FullName + "\\" + Dir_Externo + "\\" + Dir_Interno);
            }

            ruta = rutapadre + @"\" + Dir_Externo.ToString() + @"\" + Dir_Interno.ToString() + @"\" + Id_Imagen.ToString() + @".jpg";
            return ruta;
        }




    }
}
