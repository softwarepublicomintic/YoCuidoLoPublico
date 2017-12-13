using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Net;
using System.Diagnostics;

namespace ElefantesBlancosDatos
{
    /// <summary>
    /// Clase  que nos provee el los metodos para el servicio para enviar mails.</summary>
    /// <remarks>
    /// Esta clase es abstracta y nos provee el servicio apra enviar mail solo tenemos que ajustar
    /// </remarks>
    public static class Mail
    {
        public static string BodyResetearContraseña() {
            return Parametros.recuperarparametro("HtmlRecuperarContraseña");
        }

        public static string usuarioSoporte()
        {
            return Parametros.recuperarparametro("usuarioCorreo");
            //return Properties.Settings.Default.usuarioCorreo;
        }
        
        
        //string static _serverMail;

         /// <summary>Metodo que envia mail</summary>
         /// <param name="usuario"> usuario  que envia el mail</param>
         /// <seealso cref="String">
         /// <param name="para"> Receptores del mail</param>
         /// <param name="asunto"> Asunto del mail</param>
         /// <param name="mensaje"> Mensaje del mail</param>
         /// <param name="prioridad"> Mensaje del mail</param>
         /// <param name="cc"> Receptores copia del mail</param>
         /// <param name="bcc"> Receptores copia oculta del mail</param>
         /// <returns>
         /// Devuelve Mensaje de "Mensaje enviado si fue enviado" o Mensaje de error si no se envio.
         /// </returns>
        public static string enviarmail(string usuario, string[] para, string asunto, string mensaje, MailPriority prioridad , string[] cc = null, string[] bcc = null, string[] adjuntos = null)
         {
             string retorno = string.Empty;
             MailMessage objcartero = default(MailMessage);

             try
             {
                 objcartero = new MailMessage();
                 objcartero.From = new MailAddress(usuario);
                 //Eventos("Correo 1");
                 for (int i = 0; i <= para.Length - 1; i += 1)
                 {
                     objcartero.To.Add(new MailAddress(para[i]));
                 }
                 //Eventos("Correo 2");
                 if ((cc != null))
                 {
                     for (int j = 0; j <= cc.Length - 1; j += 1)
                     {
                         objcartero.CC.Add(new MailAddress(cc[j]));
                     }
                 }
                 //Eventos("Correo 3");
                 if ((bcc != null))
                 {
                     for (int j = 0; j <= bcc.Length - 1; j += 1)
                     {
                         objcartero.Bcc.Add(new MailAddress(cc[j]));
                     }
                 }
                 //Eventos("Correo 4");
                 if ((adjuntos != null))
                 {
                     for (int k = 0; k <= adjuntos.Length - 1; k += 1)
                     {
                         //objcartero.CC.Add(new MailAddress(cc[k]));
                         objcartero.Attachments.Add(new Attachment(adjuntos[k]));
                     }
                 }
                 //Eventos("Correo 5");
                 objcartero.Subject = asunto;
                 objcartero.Body = mensaje;
                 objcartero.IsBodyHtml = Convert.ToBoolean(Parametros.recuperarparametro("correoIsBodyHtml"));
                 objcartero.Priority = prioridad;
                 SmtpClient mSmtpClient = new SmtpClient();
                 mSmtpClient.Credentials = new System.Net.NetworkCredential(Parametros.recuperarparametro("usuarioCorreo"), Parametros.recuperarparametro("DefectoClave"));
                 mSmtpClient.Port = Convert.ToInt16(Parametros.recuperarparametro("portMail"));
                 mSmtpClient.Host = Parametros.recuperarparametro("hostMail");
                 mSmtpClient.EnableSsl = Convert.ToBoolean(Parametros.recuperarparametro("hostEnableSsl"));
                 mSmtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                 mSmtpClient.Send(objcartero);

                 objcartero = null;
                 retorno = "Se ha enviado un mensaje al correo especificado, por favor revise su mail e ingrese con el usuario y la contraseña especificada en el correo.";
             }
             catch (Exception ex)
             {
                 retorno = "error al enviar el mensaje" + ex.Message;
                 //Eventos("Error : " + ex.Message);
             }
             return retorno;
         }


        public static string enviarmail(string usuario, string para, string asunto, string mensaje )
        {
            string retorno = string.Empty;



            MailMessage objcartero = default(MailMessage);

            try
            {
                MailAddress from = new MailAddress(usuario, "Soporte Administrador Reportes");
                MailAddress to = new MailAddress(para, para);

                objcartero = new MailMessage(from, to);

                objcartero.Subject = asunto;
                mensaje = mensaje.Replace("CAMBIARUSUARIO", para);
                mensaje = mensaje.Replace("CAMBIARCONTRASENA", Properties.Settings.Default.DefectoClave);

                objcartero.Body = mensaje;
                objcartero.IsBodyHtml = Convert.ToBoolean(Parametros.recuperarparametro("correoIsBodyHtml"));
                objcartero.Priority = MailPriority.Normal;
                SmtpClient mSmtpClient = new SmtpClient();
                mSmtpClient.Credentials = new System.Net.NetworkCredential(Parametros.recuperarparametro("usuarioCorreo"), Parametros.recuperarparametro("contrasenaCorreo"));
                mSmtpClient.Port = Convert.ToInt16(Parametros.recuperarparametro("portMail"));
                mSmtpClient.Host = Parametros.recuperarparametro("hostMail");
                mSmtpClient.EnableSsl = Convert.ToBoolean(Parametros.recuperarparametro("hostEnableSsl"));
                //mSmtpClient.EnableSsl = Properties.Settings.Default.hostEnableSsl;
                mSmtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;

                mSmtpClient.Send(objcartero);

                objcartero = null;
                retorno = "Se ha enviado un mensaje al correo especificado, por favor revise su mail e ingrese con el usuario y la contraseña especificada en el correo.";
            }
            catch (Exception ex)
            {
                retorno = "error al enviar el mensaje" + ex.Message;
            }
            return retorno;
        }
    }
}
