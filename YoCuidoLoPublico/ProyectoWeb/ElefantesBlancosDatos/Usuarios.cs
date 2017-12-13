using ElefantesBlancosDatos.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos
{
    public class Usuarios
    {
        public List<stra_usuarios> ConsultaUsuario(string correo_electronico)
        {
            List<stra_usuarios> list = new List<stra_usuarios>();
            using (moviles4Entities moviles = new moviles4Entities())
            {


                list = (from i in moviles.stra_usuarios
                        where (i.correo_electronico == correo_electronico)
                        select i).ToList();
            }
            return list;
        }

        public List<stra_usuarios> ConsultarUsuarioValido(string usuario, string password)
        {
            List<stra_usuarios> list = new List<stra_usuarios>();


#if DEBUG
            if (usuario.Contains("Admin"))
            {
                password = "z??Z?*Z??xR9?";
                usuario = "admin@elefantes.com";
            }else if (usuario.Contains("Gestor"))
            {
                password = "?VD/?&L?~?U?F?";
                usuario = "gestor@elefantes.com";
            }
            
#endif

            using (moviles4Entities moviles = new moviles4Entities())
            {


                list = (from i in moviles.stra_usuarios
                        where (i.usuario == usuario)
                        where (i.contrasena == password)
                        select i).ToList();
            }
            return list;
        }

        public static string encryptar(string x)
        {
            System.Security.Cryptography.MD5CryptoServiceProvider test123 = new System.Security.Cryptography.MD5CryptoServiceProvider();
            byte[] data = System.Text.Encoding.ASCII.GetBytes(x);
            data = test123.ComputeHash(data);
            String md5Hash = System.Text.Encoding.ASCII.GetString(data);

            return md5Hash;
        }
        public static List<ListUsuarios> ConsultarUsuariosActivos()
        {
            List<ListUsuarios> listUsuarios = new List<ListUsuarios>();
            using (moviles4Entities moviles = new moviles4Entities())
            {
                listUsuarios = (from i in moviles.stra_usuarios
                                select new ListUsuarios
                                {
                                    value = i.id_stra_usuario,
                                    text = i.nombres + " " + i.apellidos,
                                }).ToList();
            }
            return listUsuarios;
        }
        public static string contraseñadefecto()
        {
            //string defecto = Properties.Settings.Default.DefectoClave;
            string defecto = Parametros.recuperarparametro("DefectoClave");
            return encryptar(defecto);
        }


        public void CrearUsuario(string primernombre,
                                 string segundonombre,
                                 string primerapellido,
                                 string segundoapellido,
                                 string correoelectronico,
                                 string cargo)
        {
            using (moviles4Entities moviles = new moviles4Entities())
            {
                stra_usuarios usuarios = new stra_usuarios();
                string contrasena = Usuarios.contraseñadefecto();
                usuarios.nombres = primernombre;
                usuarios.apellidos = primerapellido;
                usuarios.usuario = correoelectronico;
                usuarios.correo_electronico = correoelectronico;
                usuarios.cargo = cargo;
                usuarios.contrasena = contrasena;
                usuarios.entidad =  "No Definida";
                usuarios.primera_vez = 1;
                usuarios.estado = 1;
                usuarios.id_stra_grupo = 2;
                usuarios.ViejaClave = contrasena;
                usuarios.NuevaClave = contrasena;
                usuarios.ConfirmarClave = contrasena;
                if (segundonombre != "")
                    usuarios.segundo_nombre = segundonombre;
                if (segundoapellido != "")
                    usuarios.segundo_apellido = segundoapellido;

                moviles.stra_usuarios.Add(usuarios);
                moviles.SaveChanges();
            }
        }

        public void EditarUsuario(int Id,
                                string primernombre,
                                string segundonombre,
                                string primerapellido,
                                string segundoapellido,
                                string cargo,
                                sbyte estado)
        {
            using (moviles4Entities moviles = new moviles4Entities())
            {
                stra_usuarios usuarios = (from e in moviles.stra_usuarios
                                           where e.id_stra_usuario == Id
                                           select e).First();

                usuarios.nombres = primernombre;
                usuarios.apellidos = primerapellido;
                usuarios.cargo = cargo;
                usuarios.estado = estado;
                usuarios.ViejaClave = usuarios.contrasena;
                usuarios.NuevaClave = usuarios.contrasena;
                usuarios.ConfirmarClave = usuarios.contrasena;

                if (segundonombre != "")
                    usuarios.segundo_nombre = segundonombre;
                if (segundoapellido != "")
                    usuarios.segundo_apellido = segundoapellido;
                               
                moviles.SaveChanges();
            }
        }

        public void CambiarContrasena(int Id,
                                string contrasena)
                                
        {
            using (moviles4Entities moviles = new moviles4Entities())
            {
                stra_usuarios usuarios = (from e in moviles.stra_usuarios
                                          where e.id_stra_usuario == Id
                                          select e).First();

                usuarios.contrasena = encryptar(contrasena);
                usuarios.primera_vez = 0;
                usuarios.ViejaClave = usuarios.contrasena;
                usuarios.NuevaClave = usuarios.contrasena;
                usuarios.ConfirmarClave = usuarios.contrasena;
             
                moviles.SaveChanges();
            }
        }

        public void ResetearContrasena(string username)
        {
            using (moviles4Entities moviles = new moviles4Entities())
            {
                stra_usuarios usuarios = (from e in moviles.stra_usuarios
                                          where e.usuario == username
                                          select e).First();

                usuarios.contrasena = contraseñadefecto();
                usuarios.primera_vez = 1;
                usuarios.ViejaClave = usuarios.contrasena;
                usuarios.NuevaClave = usuarios.contrasena;
                usuarios.ConfirmarClave = usuarios.contrasena;

                moviles.SaveChanges();
            }
        }
    }
}
