 /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.actualizacion;

import co.gov.presidencia.elefantes.blancos.actualizacion.dto.Auditoria;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtorequest.ElefanteBlancoRequestDto;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtoresponse.ElefanteBlancoResponseDto;
import co.gov.presidencia.elefantes.blancos.conexion.ConexionBD;
import co.gov.presidencia.elefantes.blancos.consultar.dto.GestionImagen;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author farevalo
 */
public class ReportarLogica {

    public ElefanteBlancoResponseDto reportarElefante(ElefanteBlancoRequestDto input) throws Exception {
        Integer idElefante = 0;
        int numeroIntentos = 2;
        Boolean existeArchivo = false;
        try {
            
            if(input.getImagen() == null){
                throw new Exception("No se creo el Elefante la imagen asociada esta vacia");
            }
            
            idElefante = 1;
            idElefante = crearElefante(input);
            if (idElefante == 0) {
                throw new Exception("El identificador de la generación del elefantes es no valido (0)");
            }

            Integer idImagenGrande = 0;
            for (int i = 0; i <= numeroIntentos; i++) {
                idImagenGrande = 0;
                idImagenGrande = GestionImagen.crearRegistroImagen(idElefante, 1);
                System.out.println("idImagenGrande " +idImagenGrande);
                if (idImagenGrande != 0) {
                    break;
                }
            }

            if (idImagenGrande == 0) {
                throw new Exception("No se ha podido crear el registro de la imagen grande");
            }

            Integer idImagenTemporalGrande = 0;
            for (int i = 0; i <= numeroIntentos; i++) {
                idImagenTemporalGrande = 0;
                idImagenTemporalGrande = GestionImagen.crearImagenTemporal(idImagenGrande, 1, input.getImagen(), idElefante);
                if (idImagenTemporalGrande != 0) {
                    break;
                }
            }

            if (idImagenTemporalGrande == 0) {
                throw new Exception("No se ha podido crear el registro de la imagen temporal grande");
            }

            String rutaImagenGrande = null;
            for (int i = 0; i <= numeroIntentos; i++) {
                rutaImagenGrande = null;
                rutaImagenGrande = GestionImagen.rutaImagen(idImagenGrande);
                if (rutaImagenGrande != null) {
                    break;
                }
            }

            if (rutaImagenGrande == null) {
                throw new Exception("No se ha podido definir la ruta de la imagen grande");
            }

            //Boolean existeArchivo = false;
            for (int i = 0; i <= numeroIntentos; i++) {
                existeArchivo = false;
                System.out.println("\n  IMG GRANDE input.getImagen() " +input.getImagen()+ " rutaImagenGrande " +rutaImagenGrande);
                existeArchivo = GestionImagen.crearArchivoImagenGrande(input.getImagen(), rutaImagenGrande);
                System.out.println("\n  IMG GRANDE existeArchivo" +existeArchivo);
                if (existeArchivo) {
                    break;
                }else{
                	throw new Exception("No se creo la imagen grande en la ruta:*******" + input.getImagen()+" "+rutaImagenGrande);
                }
            }

            if (existeArchivo) {
                GestionImagen.borrarImagenTemporal(idImagenGrande);
            } else {
                throw new Exception("No se creo la imagen grande en la ruta:" + rutaImagenGrande);
            }

            Boolean actualizaElefanteImagenGrande = false;
            for (int i = 0; i <= numeroIntentos; i++) {
                actualizaElefanteImagenGrande = false;
                actualizaElefanteImagenGrande = updateElefanteImagenGrande(idElefante, idImagenGrande);
                if (actualizaElefanteImagenGrande) {
                    break;
                }
            }

            if (!(actualizaElefanteImagenGrande)) {
                throw new Exception("No se actualizo el elefante con la referencia de la imagen grande");
            }


            Integer idImagenPqna = 0;
            for (int i = 0; i <= numeroIntentos; i++) {
                idImagenPqna = 0;
                idImagenPqna = GestionImagen.crearRegistroImagen(idElefante, 2);
                System.out.println("El número idImagenPqna" +idImagenPqna);
                if (idImagenPqna != 0) {
                    break;
                }
            }

            if (idImagenPqna == 0) {
                throw new Exception("No se ha podido crear el registro de la imagen pequeña");
            }
            // Se quito el -1 que le restaba a 	idImagenPqna-1
            idImagenPqna = idImagenPqna;
            Integer idImagenTemporalPqna = 0;
            for (int i = 0; i <= numeroIntentos; i++) {
                idImagenTemporalPqna = 0;
                idImagenTemporalPqna = GestionImagen.crearImagenTemporal(idImagenPqna, 2, input.getImagen(), idElefante);
                if (idImagenTemporalPqna != 0) {
                    break;
                }
            }

            if (idImagenTemporalPqna == 0) {
                throw new Exception("No se ha podido crear el registro de la imagen temporal pequeña");
            }
            
            String rutaImagenPna = null;
            for (int i = 0; i <= numeroIntentos; i++) {
                rutaImagenPna = null;
                rutaImagenPna = GestionImagen.rutaImagen(idImagenPqna);
                if (rutaImagenPna != null) {
                    break;
                }
            }

            if (rutaImagenPna == null) {
                throw new Exception("No se ha podido definir la ruta de la imagen pequeña");
            }


            existeArchivo = false;
            for (int i = 0; i <= numeroIntentos; i++) {
            	System.out.println("\n  IMG PQÑ rutaImagenGrande " +rutaImagenGrande+ " rutaImagenPna " +rutaImagenPna);
                existeArchivo = false;
                existeArchivo = GestionImagen.crearArchivoImagenPqna(input.getImagen(), rutaImagenGrande, rutaImagenPna);
                if (existeArchivo) {
                    break;
                }else{
                	throw new Exception("No se creo la imagen pequeña en la ruta:*******" + rutaImagenPna+" "+input.getImagen()+" ***** "+rutaImagenGrande);
                }
                
            }
           /* Fin Inicio imagen pequeña */
            Logger.getLogger(ReportarLogica.class.getName()).log(Level.SEVERE, "existe file " + idImagenPqna);
            if (existeArchivo) {
            	
            	//throw new Exception("No existe la imagene en la ruta :" + rutaImagenPna);
                GestionImagen.borrarImagenTemporal(idImagenPqna);
            } else {
            	
                throw new Exception("No existe la imagene en la ruta :" + rutaImagenPna +"****"+idImagenPqna);
            }

            Boolean actualizaElefanteImagenPqna = false;
            for (int i = 0; i <= numeroIntentos; i++) {
                actualizaElefanteImagenPqna = false;
                actualizaElefanteImagenPqna = updateElefanteImagenPqna(idElefante, idImagenPqna);
                System.out.println("actualizaElefanteImagenPqna " +actualizaElefanteImagenPqna);
                if (actualizaElefanteImagenPqna) {
                    break;
                }else{
                	throw new Exception("Problemas a actualizar updateElefanteImagenPqna");
                }
            }

            if (!(actualizaElefanteImagenPqna)) {
                throw new Exception("No se actualizo el elefante con la referencia de la imagen pequeña");
            }


            Boolean updateRegistro = false;
            for (int i = 0; i <= numeroIntentos; i++) {
                updateRegistro = false;
                updateRegistro = GestionImagen.updateImagenes(idImagenPqna, idImagenGrande);
                if (updateRegistro) {
                    break;
                }
            }

            if (!(updateRegistro)) {
                throw new Exception("No se actualizado los registros de la tabla imagenes");
            }
/* Fin imagenpequeña */
            //.. registrar auditoria..
            Auditoria.registrarAuditoria(1, idElefante, 1, input.getString(), input.getTitulo());
            existeArchivo = null;
            return new ElefanteBlancoResponseDto(idElefante);
        } catch (Exception ex) {
            Logger.getLogger(ReportarLogica.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }

    private Integer crearElefante(ElefanteBlancoRequestDto input) throws Exception {
        Integer autoIncKeyFromApi = 0;
        Integer idRegion = 0;
        ResultSet rs = null;
        String sql = "INSERT INTO stra_elefantes (id_stra_departamento,id_stra_municipio,direccion,latitud,longitud,entidad_responsable,id_stra_rango_tiempo,titulo,"
                + "id_stra_motivo_elefante,costo,contratista,fecha_creacion,posicion,id_stra_region)";
        sql += " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,Point(?,?),?)";

        //sql = "INSERT INTO prueba (nombre) values (?)";

        Connection con = null;
        try {
            
            idRegion = regionDelDepartamento(input.getIdDepartamento());
            
            if(idRegion == 0){
                throw new Exception("No se ha identificado la region para el departamento: " + input.getIdDepartamento());
            }
            
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setString(1, input.getIdDepartamento());
            callableStatement.setString(2, input.getIdMunicipio());
            callableStatement.setString(3, input.getDireccion());
            callableStatement.setDouble(4, input.getPosicion().getLatitud());
            callableStatement.setDouble(5, input.getPosicion().getLongitud());
            callableStatement.setString(6, input.getEntidad());
            if(input.getIdRangoTiempo() == null || input.getIdRangoTiempo() == 0){
                callableStatement.setNull(7, Types.INTEGER);
                //callableStatement.setLong(7, Types.NULL);
            } else {
                callableStatement.setLong(7, input.getIdRangoTiempo());
            }
            
            callableStatement.setString(8, input.getTitulo());
            callableStatement.setLong(9, input.getIdMotivo());
            callableStatement.setLong(10, input.getCosto());
            callableStatement.setString(11, input.getContratista());

            SimpleDateFormat formatter  = new SimpleDateFormat("yyyy-MM-dd H:mm:ss");             
            callableStatement.setString(12, formatter.format(new java.sql.Date(new Timestamp(System.currentTimeMillis()).getTime())));
            callableStatement.setDouble(13, input.getPosicion().getLatitud());
            callableStatement.setDouble(14, input.getPosicion().getLongitud());
            callableStatement.setLong(15, idRegion);

            callableStatement.execute();
            rs = callableStatement.getGeneratedKeys();
            if (rs.next()) {
                autoIncKeyFromApi = rs.getInt(1);
            }

            con.close();
            return autoIncKeyFromApi;
        } catch (Exception ex) {
            Logger.getLogger(ReportarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ReportarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    private Integer regionDelDepartamento(String idDepartamento) throws Exception {
        Integer value = 0;
        ResultSet rs = null;
        String sql = "SELECT id_stra_region FROM stra_departamentos WHERE id_stra_departamento=?";
         Logger.getLogger(ReportarLogica.class.getName()).log(Level.INFO, null, sql);
        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setString(1, idDepartamento);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                value = rs.getInt(1);
                break;
            }

            con.close();

            return value;
        } catch (Exception ex) {
            Logger.getLogger(ReportarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ReportarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }    
    
    private Boolean updateElefanteImagenGrande(Integer idElefante, Integer imagenGrande) throws Exception {
        Boolean salida = false;
        ResultSet rs = null;
        String sql = "UPDATE stra_elefantes SET id_stra_imagen_principal_grande=? WHERE id_stra_elefante=?";

        Connection con = null;
        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setInt(1, imagenGrande);
            callableStatement.setInt(2, idElefante);

            callableStatement.execute();
            con.close();
            salida = true;
            return salida;
        } catch (Exception ex) {
            Logger.getLogger(ReportarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ReportarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            //throw ex;
            return false;
        }
    }

    private Boolean updateElefanteImagenPqna(Integer idElefante, Integer imagenPna) throws Exception {
        Boolean salida = false;
        ResultSet rs = null;
        String sql = "UPDATE stra_elefantes SET id_stra_imagen_principal_pequena=? WHERE id_stra_elefante=?";

        Connection con = null;
        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setInt(1, imagenPna);
            callableStatement.setInt(2, idElefante);

            callableStatement.execute();
            con.close();
            salida = true;
            return salida;
        } catch (Exception ex) {
            Logger.getLogger(ReportarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ReportarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            //throw ex;
            return false;
        }
    }



}
