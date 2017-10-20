/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dto;

import co.gov.presidencia.elefantes.blancos.conexion.ConexionBD;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import org.springframework.webflow.util.Base64;

/**
 *
 * @author farevalo
 */
public class GestionImagen {

    public static String rutaRepositorioImagen(long idImagen) throws Exception {
        Integer Dir_Interno = -1;
        Integer Dir_Externo = -1;
        ResultSet rs = null;
        String rutaServidor = null;
        String sql = "select ruta from stra_rutas where id_stra_ruta=1";

        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                rutaServidor = rs.getString(1);
            }

            if (rutaServidor == null) {
                throw new Exception("La ruta del servidor de imagenes es invalida");
            }

            con.close();

            Dir_Interno = (Long.valueOf(idImagen).intValue() % 1048576) / 1024;
            Dir_Externo = (Long.valueOf(idImagen).intValue() / 1048576);

            if (Dir_Interno == (-1) || Dir_Externo == (-1)) {
                throw new Exception("La ruta interna del servidor de imagenes es invalida");
            }

            return "C:\\Users\\administrador\\Documents\\imagenes";
        } catch (Exception ex) {
            Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public static String imagenBase64(String rutaImagen) throws Exception {
        String imagen = null;
        FileInputStream fin = null;
        try {
            if ((new File(rutaImagen).exists())) {
                File archivo = new File(rutaImagen);
                fin = new FileInputStream(archivo);
                byte[] fileContent = new byte[(int) archivo.length()];
                fin.read(fileContent);
                imagen = new Base64().encodeToString(fileContent);
            }
            return imagen;
        } catch (Exception ex) {
            Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }

    public static String imagenBase64ConId(long idImagen) throws Exception {
        String imagen = "";
        try {
            imagen = imagenBase64(rutaRepositorioImagen(idImagen) + "\\" + idImagen + ".jpg");
            return imagen;
        } catch (Exception ex) {
            Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }

    public static Integer crearImagenTemporal(Integer idImagen, Integer tipo, String imagen, Integer idElefante) throws Exception {
        Integer autoIncKeyFromApi = 0;
        ResultSet rs = null;
        String sql = "INSERT INTO stra_imagenes_temporal (id_stra_imagen,imagen,id_stra_elefante,tipo_imagen)";
        sql += " VALUES (?,?, ?, ?)";
        byte[] imageBytes = new Base64().decodeFromString(imagen);

        Connection con = null;
        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setInt(1, idImagen);
            callableStatement.setBytes(2, imageBytes);
            callableStatement.setInt(3, idElefante);
            callableStatement.setInt(4, tipo);

            callableStatement.execute();

            rs = callableStatement.getGeneratedKeys();
            if (rs.next()) {
                autoIncKeyFromApi = rs.getInt(1);
            }

            con.close();
            return autoIncKeyFromApi;
        } catch (Exception ex) {
            Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public static Integer crearRegistroImagen(Integer idElefante, Integer tipoImagen) throws Exception {
        Integer autoIncKeyFromApi = 0;
        ResultSet rs = null;
        String sql = "INSERT INTO stra_imagenes (tipo_imagen,id_stra_elefante)";
        sql += " VALUES (?,?)";

        Connection con = null;
        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setInt(1, tipoImagen);
            callableStatement.setInt(2, idElefante);

            callableStatement.execute();
            rs = callableStatement.getGeneratedKeys();
            if (rs.next()) {
                autoIncKeyFromApi = rs.getInt(1);
            }

            con.close();
            return autoIncKeyFromApi;
        } catch (Exception ex) {
            Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public static Boolean crearArchivoImagenGrande(String imagen, String rutaArchivo) throws Exception {
        try {
            byte[] imageBytes = new Base64().decodeFromString(imagen);

            OutputStream out = new FileOutputStream(new File(rutaArchivo));
            out.write(imageBytes);
            out.close();

            return (new File(rutaArchivo).exists());
        } catch (Exception ex) {
            Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }

    public static Boolean updateImagenes(Integer imagenPqna, Integer imagenGrande) throws Exception {
        ResultSet rs = null;
        String sql = "UPDATE stra_imagenes SET id_stra_imagen_asociada =? WHERE id_stra_imagen=?";

        Connection con = null;
        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setInt(1, imagenPqna);
            callableStatement.setInt(2, imagenGrande);
            callableStatement.execute();

            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatementPqna = con.prepareCall(sql);
            callableStatementPqna.setInt(1, imagenGrande);
            callableStatementPqna.setInt(2, imagenPqna);
            callableStatementPqna.execute();

            con.close();
            return true;
        } catch (Exception ex) {
            Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public static Boolean crearArchivoImagenPqna(String imagen, String rutaArchivoGrande, String ruraArchivoPqna) throws Exception {
        try {

            byte[] imageBytes = imagen.getBytes();

            BufferedImage img = new BufferedImage(2048, 1535, BufferedImage.TYPE_INT_RGB);
            img.createGraphics().drawImage(ImageIO.read(new File(rutaArchivoGrande)).getScaledInstance(2048, 1535, Image.SCALE_SMOOTH), 0, 0, null);
            ImageIO.write(img, "jpg", new File(ruraArchivoPqna));

            return (new File(ruraArchivoPqna).exists());
        } catch (Exception ex) {
            Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static String rutaImagen(Integer idImagen) throws Exception {
        String rutaServidor = null;
        try {

            rutaServidor = GestionImagen.rutaRepositorioImagen(idImagen);

            File folder = new File(rutaServidor);
            folder.mkdirs();

            rutaServidor += "\\" + idImagen + ".jpg";

            return rutaServidor;
        } catch (Exception ex) {
            Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }

    public static Boolean borrarImagenTemporal(Integer idImagen) throws Exception {
        ResultSet rs = null;
        String sql = "DELETE FROM stra_imagenes_temporal WHERE id_stra_imagen =?";
        
        //sql = "INSERT INTO prueba (nombre) values (?)";

        Connection con = null;
        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setInt(1, idImagen);
            callableStatement.execute();

            con = ConexionBD.getDataSource().getConnection();
            con.close();
            return true;
        } catch (Exception ex) {
            Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(GestionImagen.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            return false;
        }
    }
}
