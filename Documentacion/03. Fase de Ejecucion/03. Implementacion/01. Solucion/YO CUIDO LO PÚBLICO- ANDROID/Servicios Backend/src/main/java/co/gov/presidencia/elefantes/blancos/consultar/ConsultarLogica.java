/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar;

import co.gov.presidencia.elefantes.blancos.actualizacion.ReportarLogica;
import co.gov.presidencia.elefantes.blancos.conexion.ConexionBD;
import co.gov.presidencia.elefantes.blancos.consultar.dto.DetalleBasicoElefanteDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.DetalleElefanteDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.ElefanteMapaDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.ElefanteMasVotadoDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.ElefanteMunicipioDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.GestionImagen;
import co.gov.presidencia.elefantes.blancos.consultar.dto.ImageneMiniaturaDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.MotivoDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.MunicipioMapa;
import co.gov.presidencia.elefantes.blancos.consultar.dto.PosicionDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.RangoTiempoDto;
import co.gov.presidencia.elefantes.blancos.consultar.dto.RegionDto;
import co.gov.presidencia.elefantes.blancos.consultar.dtoresponse.ImagenReponseDto;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author farevalo
 */
public class ConsultarLogica {

    public DetalleElefanteDto detalleLoPublico(long idElefante) throws Exception {
        DetalleElefanteDto detalleElefanteDto = null;
        ResultSet rs = null;
        CallableStatement callableStatement = null;
        String sql = "SELECT id_stra_elefante, titulo, id_stra_departamento, id_stra_municipio, id_stra_estado_elefante, cantidad_rechazos,  "
                + "entidad_responsable, id_stra_motivo_elefante, id_stra_rango_tiempo, costo, contratista, id_stra_imagen_principal_pequena, "
                + "fecha_creacion, comentario_rechazo, estado_id_rango_tiempo, estado_costo,  estado_contratista, latitud, longitud, no_es_un_elefante , stra_elefantes.id_stra_razon_rechazo as id_stra_razon_rechazo, razon  "
                + "FROM stra_elefantes LEFT JOIN  stra_razones_rechazo ON (stra_elefantes.id_stra_razon_rechazo=stra_razones_rechazo.id_stra_razon_rechazo) "
                + "WHERE id_stra_elefante= ?";

        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            callableStatement = con.prepareCall(sql);
            callableStatement.setLong(1, idElefante);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                detalleElefanteDto = new DetalleElefanteDto(rs.getLong(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getLong(5),
                        rs.getLong(6), rs.getString(7), rs.getLong(8), rs.getLong(9), rs.getLong(10), rs.getString(11), rs.getLong(12), rs.getDate(13),
                        rs.getString(14), rs.getLong(15), rs.getLong(16), rs.getLong(17), rs.getDouble(18), rs.getDouble(19), (rs.getLong(20) != 0),
                        rs.getLong(21), rs.getString(22));
                break;
            }

            con.close();

            if (detalleElefanteDto.getEstado() == 2) {
                detalleElefanteDto.setMiniaturas(listaMiniaturasAprobado(idElefante));
            } else {
                detalleElefanteDto.setMiniaturas(listaMiniaturasRechazadosPendientes(idElefante));
            }



            return detalleElefanteDto;
        } catch (Exception ex) {
            if (callableStatement != null) {
                Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, new Exception(ex.getMessage() 
                        + ". Query:" + callableStatement.toString()));
            } else {
                Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public DetalleBasicoElefanteDto detalleBasicoLoPublico(long idElefante) throws Exception {
        DetalleBasicoElefanteDto detalleBasicoElefanteDto = null;
        ResultSet rs = null;
        /*String sql = "SELECT id_stra_elefante, titulo, id_stra_estado_elefante, cantidad_rechazos, id_stra_imagen_principal_pequena FROM stra_elefantes "
                + "WHERE id_stra_elefante= ?";*/
        String sql = "SELECT id_stra_elefante, titulo, id_stra_estado_elefante, cantidad_rechazos, id_stra_imagen_principal_grande FROM stra_elefantes "
                + "WHERE id_stra_elefante= ?";
        Connection con = null;
        long idImagenPqna = 0;
        String imagen = null;
        CallableStatement callableStatement =  null;
        Integer idImagenPqnaRechazada = 0;
        String imagenPqnaRechazada = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            callableStatement = con.prepareCall(sql);
            callableStatement.setLong(1, idElefante);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                imagen = null;
                idImagenPqna = rs.getLong(5);
                if (idImagenPqna != 0) {
                    imagen = GestionImagen.imagenBase64ConId(idImagenPqna);
                }
                detalleBasicoElefanteDto = new DetalleBasicoElefanteDto(rs.getLong(1), rs.getString(2), imagen, rs.getLong(3), rs.getLong(4));
                break;
            }

            con.close();

            if (detalleBasicoElefanteDto.getImagenPrincipal() == null) {
                idImagenPqnaRechazada  = imagenPequenaPendientesRechazados(idElefante);
                imagenPqnaRechazada = GestionImagen.imagenBase64ConId(idImagenPqnaRechazada);
                detalleBasicoElefanteDto.setImagenPrincipal(imagenPqnaRechazada);
                if(imagenPqnaRechazada == null){
                    imagenPqnaRechazada = "NULL";
                }                
            }

            return detalleBasicoElefanteDto;
        } catch (Exception ex) {
            if (callableStatement != null) {
                Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, new Exception(ex.getMessage() 
                        + ". Query:" + callableStatement.toString() + ". idImagenPqnaRechazada:" + idImagenPqnaRechazada + ". imagenPqnaRechazada:" + imagenPqnaRechazada));
            } else {
                Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            }
            //Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public ImagenReponseDto consultarImagen(long idImagen) throws Exception {
        ImagenReponseDto imagenReponseDto = new ImagenReponseDto(null);
        try {
            imagenReponseDto = new ImagenReponseDto(GestionImagen.imagenBase64ConId(idImagen));
            return imagenReponseDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }

    public List<ElefanteMasVotadoDto> loPublicoMasVotados() throws Exception {
        List<ElefanteMasVotadoDto> listaElefanteMasVotadoDto = new ArrayList<ElefanteMasVotadoDto>();
        ResultSet rs = null;
        String sql = "SELECT id_stra_elefante, titulo, id_stra_departamento, id_stra_municipio, cantidad_rechazos, id_stra_imagen_principal_grande FROM stra_elefantes "
                + " WHERE id_stra_estado_elefante = 1 AND no_es_un_elefante = 0 ORDER BY cantidad_rechazos DESC "
                + "LIMIT 5";

        Connection con = null;
        long idImagenPqna = 0;
        String imagen = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                imagen = null;
                idImagenPqna = rs.getLong(6);
                if (idImagenPqna != 0) {
                    imagen = GestionImagen.imagenBase64ConId(idImagenPqna);
                }

                listaElefanteMasVotadoDto.add(new ElefanteMasVotadoDto(rs.getLong(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getLong(5), imagen));
            }

            con.close();

            return listaElefanteMasVotadoDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public List<RegionDto> loPublicoPorRegion() throws Exception {
        List<RegionDto> listaRegionDto = new ArrayList<RegionDto>();
        ResultSet rs = null;
        String sql = "SELECT id_stra_region, COUNT(id_stra_region) cantidad FROM stra_elefantes WHERE id_stra_estado_elefante = 1 AND no_es_un_elefante = 0 "
                + " AND id_stra_region IN (SELECT id_stra_region FROM stra_regiones) GROUP BY id_stra_region";

        Connection con = null;
        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                listaRegionDto.add(new RegionDto(rs.getLong(1), rs.getLong(2)));
            }

            con.close();

            return listaRegionDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public List<String> departamentosPorRegion(long region) throws Exception {
        List<String> listaRegionDto = new ArrayList<String>();
        ResultSet rs = null;
        String sql = "SELECT id_stra_departamento FROM stra_elefantes WHERE id_stra_estado_elefante = 1 AND no_es_un_elefante = 0 AND "
                + " id_stra_departamento IN (SELECT id_stra_departamento FROM stra_departamentos) AND id_stra_region=? GROUP BY id_stra_departamento";

        Connection con = null;
        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setLong(1, region);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                listaRegionDto.add(rs.getString(1));
            }

            con.close();

            return listaRegionDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public List<MunicipioMapa> municipiosPorDepartamento(String departamento) throws Exception {
        List<MunicipioMapa> listaDeptoDto = new ArrayList<MunicipioMapa>();
        ResultSet rs = null;
        String sql = "SELECT id_stra_municipio FROM stra_elefantes WHERE id_stra_estado_elefante = 1 AND no_es_un_elefante = 0 AND "
                + " id_stra_municipio IN (SELECT id_stra_municipio FROM stra_municipios) AND id_stra_departamento=? GROUP BY id_stra_municipio";

        Connection con = null;
        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setString(1, departamento);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                listaDeptoDto.add(new MunicipioMapa(rs.getString(1)));
            }

            con.close();

            for (MunicipioMapa municipioMapa : listaDeptoDto) {
                municipioMapa.setPosicion(ultimoElefanteMunicipio(municipioMapa.getMunicipio()));
            }

            return listaDeptoDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    private PosicionDto ultimoElefanteMunicipio(String municipio) throws Exception {
        PosicionDto posicion = new PosicionDto(0, 0);
        ResultSet rs = null;
        String sql = "SELECT latitud,longitud FROM stra_elefantes WHERE  id_stra_estado_elefante = 2 AND no_es_un_elefante = 0  AND id_stra_municipio=? ORDER BY id_stra_elefante DESC LIMIT 1";

        Connection con = null;
        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setString(1, municipio);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                posicion = new PosicionDto(rs.getDouble(1), rs.getDouble(2));
                break;
            }

            con.close();

            return posicion;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public List<ElefanteMunicipioDto> loPublicoPorMunicipio(String municipio) throws Exception {
        List<ElefanteMunicipioDto> listaElefanteMunicipioDto = new ArrayList<ElefanteMunicipioDto>();
        ResultSet rs = null;
        String sql = "SELECT id_stra_elefante, titulo, id_stra_estado_elefante, latitud, longitud, no_es_un_elefante  FROM stra_elefantes "
                + " WHERE id_stra_estado_elefante IN (1) AND id_stra_municipio=?";

        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setString(1, municipio);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                listaElefanteMunicipioDto.add(new ElefanteMunicipioDto(rs.getLong(1), rs.getString(2), rs.getLong(3), rs.getDouble(4), rs.getDouble(5), (rs.getLong(6) != 0)));
            }

            con.close();

            return listaElefanteMunicipioDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public List<RangoTiempoDto> rangosDeTiempo() throws Exception {
        List<RangoTiempoDto> listaRangoTiempoDto = new ArrayList<RangoTiempoDto>();
        ResultSet rs = null;
        String sql = "SELECT id_stra_rango_tiempo, rango_tiempo FROM stra_rango_tiempo";

        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                listaRangoTiempoDto.add(new RangoTiempoDto(rs.getLong(1), rs.getString(2)));
            }
            con.close();

            return listaRangoTiempoDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public List<MotivoDto> motivosCuidoLoPublico() throws Exception {
        List<MotivoDto> listaMotivoDto = new ArrayList<MotivoDto>();
        ResultSet rs = null;
        String sql = "SELECT id_stra_motivo_elefante, motivo FROM stra_motivos_elefante";

        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                listaMotivoDto.add(new MotivoDto(rs.getLong(1), rs.getString(2)));
            }
            con.close();

            return listaMotivoDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    private List<ImageneMiniaturaDto> listaMiniaturasAprobado(long idElefante) throws Exception {
        List<ImageneMiniaturaDto> listImageneMiniaturaDto = new ArrayList<ImageneMiniaturaDto>();
        ResultSet rs = null;

        String sql = "SELECT id_stra_imagen, id_stra_imagen_asociada FROM stra_imagenes where id_stra_elefante= ? and estado_imagen=? and tipo_imagen = ?";
        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setLong(1, idElefante);
            callableStatement.setLong(2, 1);
            callableStatement.setLong(3, 2);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            ImageneMiniaturaDto imagenesMiniaturasDto = null;
            while (rs.next()) {
                imagenesMiniaturasDto = new ImageneMiniaturaDto(rs.getLong(1), rs.getLong(2));
                imagenesMiniaturasDto.setMiniatura(GestionImagen.imagenBase64ConId(imagenesMiniaturasDto.getId()));
                listImageneMiniaturaDto.add(imagenesMiniaturasDto);
            }

            con.close();

            return listImageneMiniaturaDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    private List<ImageneMiniaturaDto> listaMiniaturasRechazadosPendientes(long idElefante) throws Exception {
        List<ImageneMiniaturaDto> listImageneMiniaturaDto = new ArrayList<ImageneMiniaturaDto>();
        ResultSet rs = null;

        String sql = "SELECT id_stra_imagen, id_stra_imagen_asociada FROM stra_imagenes where id_stra_elefante= ? and tipo_imagen = ?";

        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setLong(1, idElefante);
            callableStatement.setLong(2, 2);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            ImageneMiniaturaDto imagenesMiniaturasDto = null;
            while (rs.next()) {
                imagenesMiniaturasDto = new ImageneMiniaturaDto(rs.getLong(1), rs.getLong(2));
                imagenesMiniaturasDto.setMiniatura(GestionImagen.imagenBase64ConId(imagenesMiniaturasDto.getId()));
                listImageneMiniaturaDto.add(imagenesMiniaturasDto);
            }

            con.close();

            return listImageneMiniaturaDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    private Integer imagenPequenaPendientesRechazados(long idElefante) throws Exception {
        Integer value = 0;
        ResultSet rs = null;

        String sql = "SELECT id_stra_imagen FROM stra_imagenes where id_stra_elefante= ? and tipo_imagen = ?";
        CallableStatement callableStatement =  null;
        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            callableStatement = con.prepareCall(sql);
            callableStatement.setLong(1, idElefante);
            callableStatement.setLong(2, 2);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                value = Long.valueOf(rs.getLong(1)).intValue();
                break;
            }

            con.close();

            return value;
        } catch (Exception ex) {
            if (callableStatement != null) {
                Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, new Exception(ex.getMessage() + ". Query:" + callableStatement.toString()));
            } else {
                Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            }            
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public List<ElefanteMapaDto> loPublicoPorPosicion(Double latitud, Double longitud) throws Exception {
        List<ElefanteMapaDto> listElefanteMapaDto = new ArrayList<ElefanteMapaDto>();
        ResultSet rs = null;
        String sql = "SELECT id_stra_elefante, titulo, id_stra_estado_elefante, latitud, longitud, no_es_un_elefante  FROM stra_elefantes WHERE id_stra_estado_elefante in (1, 2, 3) "
                + " AND "
                + " MBRContains ( LineString( Point(? + 3 / 111.1, ? + 3 / ( 111.1 / COS(RADIANS(?)))), Point(? - 3 / 111.1, ? - 3 / ( 111.1 / COS(RADIANS(?))))), posicion)";

        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
//            callableStatement.setDouble(1, longitud);
//            callableStatement.setDouble(2, latitud);
//            callableStatement.setDouble(3, longitud);
//            callableStatement.setDouble(4, longitud);
//            callableStatement.setDouble(5, latitud);
//            callableStatement.setDouble(6, longitud);
            callableStatement.setDouble(1, latitud);
            callableStatement.setDouble(2, longitud);
            callableStatement.setDouble(3, latitud);
            callableStatement.setDouble(4, latitud);
            callableStatement.setDouble(5, longitud);
            callableStatement.setDouble(6, latitud);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            ElefanteMapaDto elefanteMapaDto = null;
            boolean swNoEsUnElefante = false;
            while (rs.next()) {
                elefanteMapaDto = new ElefanteMapaDto(rs.getLong(1), rs.getString(2), rs.getLong(3), rs.getDouble(4), rs.getDouble(5), (rs.getLong(6) != 0));
                listElefanteMapaDto.add(elefanteMapaDto);
            }

            con.close();

            return listElefanteMapaDto;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }

    public Integer cantidadRechazos(long idElefante) throws Exception {
        Integer value = 0;
        ResultSet rs = null;
        String sql = "SELECT cantidad_rechazos FROM stra_elefantes WHERE id_stra_elefante= ?";

        Connection con = null;

        try {
            con = ConexionBD.getDataSource().getConnection();

            CallableStatement callableStatement = con.prepareCall(sql);
            callableStatement.setLong(1, idElefante);
            callableStatement.execute();

            rs = callableStatement.getResultSet();

            while (rs.next()) {
                value = Long.valueOf(rs.getLong(1)).intValue();
                break;
            }

            con.close();

            return value;
        } catch (Exception ex) {
            Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex);
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConsultarLogica.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            throw ex;
        }
    }
}
