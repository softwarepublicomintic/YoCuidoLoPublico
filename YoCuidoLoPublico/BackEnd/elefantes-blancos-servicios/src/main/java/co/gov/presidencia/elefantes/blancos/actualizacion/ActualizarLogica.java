/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.actualizacion;

import co.gov.presidencia.elefantes.blancos.actualizacion.dto.Auditoria;
import co.gov.presidencia.elefantes.blancos.actualizacion.dto.ElefanteActualizaDto;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtorequest.ImagenAsociadaRequestDto;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtorequest.ModificarElefanteRequestDto;
import co.gov.presidencia.elefantes.blancos.actualizacion.dtoresponse.RegistrarVotoResponseDto;
import co.gov.presidencia.elefantes.blancos.conexion.ConexionBD;
import co.gov.presidencia.elefantes.blancos.consultar.ConsultarLogica;
import co.gov.presidencia.elefantes.blancos.consultar.dto.GestionImagen;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author farevalo
 */
public class ActualizarLogica {

    public RegistrarVotoResponseDto registrarVoto(long idElefante) throws Exception {
        Integer value = 0;
        String sql = "update stra_elefantes set cantidad_rechazos = cantidad_rechazos + 1 WHERE id_stra_elefante=?";

        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setLong(1, idElefante);
            callableStatement.execute();

            con.close();

            value = new ConsultarLogica().cantidadRechazos(idElefante);

            return new RegistrarVotoResponseDto(value);
        } catch (Exception ex) {
            Logger.getLogger(ActualizarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ActualizarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public void actualizarElefante(ModificarElefanteRequestDto input) throws Exception {
        String sql = "update stra_elefantes set titulo = ?, id_stra_motivo_elefante=?, entidad_responsable=?, costo = ?,  "
                + "contratista=?,  id_stra_rango_tiempo=?, estado_id_rango_tiempo=?, estado_costo=?, estado_contratista=? WHERE id_stra_elefante=?";

        String sqlError = sql;

        Connection con = null;

        CallableStatement callableStatement = null;
        try {
     
            ElefanteActualizaDto elefanteActualizaDto = detalleElefante(input.getIdElefante());
     
            con = ConexionBD.getDataSource().getConnection();

            callableStatement = con.prepareCall(sql);
            callableStatement.setString(1, input.getTitulo());
            callableStatement.setLong(2, input.getIdMotivo());
            callableStatement.setString(3, input.getEntidad());
            callableStatement.setLong(4, input.getCosto());
            callableStatement.setString(5, input.getContratista());
            if (input.getIdRangoTiempo() == 0) {
                callableStatement.setNull(6, Types.INTEGER);
            } else {
                callableStatement.setLong(6, input.getIdRangoTiempo());
            }
            
            if(elefanteActualizaDto.getRangoTiempoEstado()==2){
                callableStatement.setLong(7, 0);
            } else {
                callableStatement.setLong(7, elefanteActualizaDto.getRangoTiempoEstado());
            }
            
            if(elefanteActualizaDto.getCostoEstado()==2){
                callableStatement.setLong(8, 0);
            } else {
                callableStatement.setLong(8, elefanteActualizaDto.getCostoEstado());
            }            
            
            if(elefanteActualizaDto.getContratistaEstado()==2){
                callableStatement.setLong(9, 0);
            } else {
                callableStatement.setLong(9, elefanteActualizaDto.getContratistaEstado());
            }                 
            
            callableStatement.setLong(10, input.getIdElefante());

            callableStatement.execute();

            con.close();
            
            //.. registrar auditoria..
            Auditoria.registrarAuditoria(5, Long.valueOf(input.getIdElefante()).intValue() , 2, input.getString(), input.getTitulo());
        } catch (Exception ex) {
            if (callableStatement != null) {
                Logger.getLogger(ActualizarLogica.class.getName()).log(Level.SEVERE, null, new Exception(ex.getMessage() + ". Query:" + callableStatement.toString()));
            } else {
                Logger.getLogger(ActualizarLogica.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ActualizarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public ElefanteActualizaDto detalleElefante(long idElefante) throws Exception {
        ElefanteActualizaDto detalleElefanteDto = null;
        ResultSet rs = null;
        String sql = "SELECT estado_id_rango_tiempo, estado_costo,  estado_contratista  FROM stra_elefantes "
                + "WHERE id_stra_elefante= ?";

        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setLong(1, idElefante);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                detalleElefanteDto = new ElefanteActualizaDto(rs.getLong(1), rs.getLong(2), rs.getLong(3));
                break;
            }

            con.close();


            return detalleElefanteDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ActualizarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }    
    
    public boolean asociarImagen(ImagenAsociadaRequestDto input) throws Exception {
        int numeroIntentos = 2;
        try {

            Integer idImagenGrande = 0;
            for (int i = 0; i <= numeroIntentos; i++) {
                idImagenGrande = 0;
                idImagenGrande = GestionImagen.crearRegistroImagen(Long.valueOf(input.getIdElefante()).intValue(), 1);
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
                idImagenTemporalGrande = GestionImagen.crearImagenTemporal(idImagenGrande, 1, input.getImagen(), Long.valueOf(input.getIdElefante()).intValue());
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

            Boolean existeArchivo = false;
            for (int i = 0; i <= numeroIntentos; i++) {
                existeArchivo = false;
                existeArchivo = GestionImagen.crearArchivoImagenGrande(input.getImagen(), rutaImagenGrande);
                if (existeArchivo) {
                    break;
                }
            }

            if (existeArchivo) {
                GestionImagen.borrarImagenTemporal(idImagenGrande);
            } else {
                throw new Exception("No se creo la imagen grande en la ruta:" + rutaImagenGrande);
            }


            //... ´pequeña..


            Integer idImagenPqna = 0;
            for (int i = 0; i <= numeroIntentos; i++) {
                idImagenPqna = 0;
                idImagenPqna = GestionImagen.crearRegistroImagen(Long.valueOf(input.getIdElefante()).intValue(), 2);
                if (idImagenPqna != 0) {
                    break;
                }
            }

            if (idImagenPqna == 0) {
                throw new Exception("No se ha podido crear el registro de la imagen pequeña");
            }


            Integer idImagenTemporalPqna = 0;
            for (int i = 0; i <= numeroIntentos; i++) {
                idImagenTemporalPqna = 0;
                idImagenTemporalPqna = GestionImagen.crearImagenTemporal(idImagenPqna, 2, input.getImagen(), Long.valueOf(input.getIdElefante()).intValue());
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
                existeArchivo = false;
                existeArchivo = GestionImagen.crearArchivoImagenPqna(input.getImagen(), rutaImagenGrande, rutaImagenPna);
                if (existeArchivo) {
                    break;
                }
            }

            if (existeArchivo) {
                GestionImagen.borrarImagenTemporal(idImagenPqna);
            } else {
                throw new Exception("No se creo la imagen pequeña en la ruta:" + rutaImagenPna);
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

            //.. registrar auditoria..
            Auditoria.registrarAuditoria(8, Long.valueOf(input.getIdElefante()).intValue(), 2, "Se adicionó la foto: "  + idImagenGrande + " y la: " + idImagenPqna, "");
            
            return true;
        } catch (Exception ex) {
            Logger.getLogger(ActualizarLogica.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }
}
