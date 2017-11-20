/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author farevalo
 */
public class DetalleElefanteDto {

    private long id;
    private String titulo;
    private String departamento;
    private String municipio;
    private List<ImageneMiniaturaDto> miniaturas;
    private Long estado;
    private long rechazos;
    private String entidad;
    private long idMotivo;
    private long idRangoTiempo;
    private long costo;
    private String contratista;
    private long idMiniaturaPrincipal;
    private Date fechaReporte;
    private String comentario;
    private long rangoTiempoEstado;
    private long costoEstado;
    private long contratistaEstado;
    private PosicionDto posicion;
   private boolean noEsUnReporte;
   private Long idRazonRechazo;
   private String razon;


    public DetalleElefanteDto(long id, String titulo, String departamento, String municipio, Long estado, long rechazos, String entidad, long idMotivo, long idRangoTiempo, long costo, String contratista, 
            long idMiniaturaPrincipal, Date fechaReporte, String comentario, long rangoTiempoEstado, long costoEstado, long contratistaEstado, Double latitud, Double longitud, boolean noEsUnReporte
            , Long idRazonRechazo, String razon) {
        this.id = id;
        this.titulo = titulo;
        this.departamento = departamento;
        this.municipio = municipio;
        this.estado = estado;
        this.rechazos = rechazos;
        this.entidad = entidad;
        this.idMotivo = idMotivo;
        this.idRangoTiempo = idRangoTiempo;
        this.costo = costo;
        this.contratista = contratista;
        this.idMiniaturaPrincipal = idMiniaturaPrincipal;
        this.fechaReporte = fechaReporte;
        this.comentario = comentario;
        this.rangoTiempoEstado = rangoTiempoEstado;
        this.costoEstado = costoEstado;
        this.contratistaEstado = contratistaEstado;
        this.posicion = new PosicionDto(latitud, longitud);
        this.noEsUnReporte = noEsUnReporte;
        this.idRazonRechazo = idRazonRechazo;
        this.razon = razon;        
    }
    
    /**
     * @return the id
     */
    public long getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(long id) {
        this.id = id;
    }

    /**
     * @return the titulo
     */
    public String getTitulo() {
        return titulo;
    }

    /**
     * @param titulo the titulo to set
     */
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    /**
     * @return the departamento
     */
    public String getDepartamento() {
        return departamento;
    }

    /**
     * @param departamento the departamento to set
     */
    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    /**
     * @return the municipio
     */
    public String getMunicipio() {
        return municipio;
    }

    /**
     * @param municipio the municipio to set
     */
    public void setMunicipio(String municipio) {
        this.municipio = municipio;
    }

    /**
     * @return the miniaturas
     */
    public List<ImageneMiniaturaDto> getMiniaturas() {
        return miniaturas;
    }

    /**
     * @param miniaturas the miniaturas to set
     */
    public void setMiniaturas(List<ImageneMiniaturaDto> miniaturas) {
        this.miniaturas = miniaturas;
    }

    /**
     * @return the estado
     */
    public Long getEstado() {
        return estado;
    }

    /**
     * @param estado the estado to set
     */
    public void setEstado(Long estado) {
        this.estado = estado;
    }

    /**
     * @return the rechazos
     */
    public long getRechazos() {
        return rechazos;
    }

    /**
     * @param rechazos the rechazos to set
     */
    public void setRechazos(long rechazos) {
        this.rechazos = rechazos;
    }

    /**
     * @return the entidad
     */
    public String getEntidad() {
        return entidad;
    }

    /**
     * @param entidad the entidad to set
     */
    public void setEntidad(String entidad) {
        this.entidad = entidad;
    }

    /**
     * @return the idMotivo
     */
    public long getIdMotivo() {
        return idMotivo;
    }

    /**
     * @param idMotivo the idMotivo to set
     */
    public void setIdMotivo(long idMotivo) {
        this.idMotivo = idMotivo;
    }

    /**
     * @return the idRangoTiempo
     */
    public long getIdRangoTiempo() {
        return idRangoTiempo;
    }

    /**
     * @param idRangoTiempo the idRangoTiempo to set
     */
    public void setIdRangoTiempo(long idRangoTiempo) {
        this.idRangoTiempo = idRangoTiempo;
    }

    /**
     * @return the costo
     */
    public long getCosto() {
        return costo;
    }

    /**
     * @param costo the costo to set
     */
    public void setCosto(long costo) {
        this.costo = costo;
    }

    /**
     * @return the contratista
     */
    public String getContratista() {
        return contratista;
    }

    /**
     * @param contratista the contratista to set
     */
    public void setContratista(String contratista) {
        this.contratista = contratista;
    }

    /**
     * @return the idMiniaturaPrincipal
     */
    public long getIdMiniaturaPrincipal() {
        return idMiniaturaPrincipal;
    }

    /**
     * @param idMiniaturaPrincipal the idMiniaturaPrincipal to set
     */
    public void setIdMiniaturaPrincipal(long idMiniaturaPrincipal) {
        this.idMiniaturaPrincipal = idMiniaturaPrincipal;
    }

    /**
     * @return the fechaReporte
     */
    public Date getFechaReporte() {
        return fechaReporte;
    }

    /**
     * @param fechaReporte the fechaReporte to set
     */
    public void setFechaReporte(Date fechaReporte) {
        this.fechaReporte = fechaReporte;
    }

    /**
     * @return the comentario
     */
    public String getComentario() {
        return comentario;
    }

    /**
     * @param comentario the comentario to set
     */
    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    /**
     * @return the rangoTiempoEstado
     */
    public long getRangoTiempoEstado() {
        return rangoTiempoEstado;
    }

    /**
     * @param rangoTiempoEstado the rangoTiempoEstado to set
     */
    public void setRangoTiempoEstado(long rangoTiempoEstado) {
        this.rangoTiempoEstado = rangoTiempoEstado;
    }

    /**
     * @return the costoEstado
     */
    public long getCostoEstado() {
        return costoEstado;
    }

    /**
     * @param costoEstado the costoEstado to set
     */
    public void setCostoEstado(long costoEstado) {
        this.costoEstado = costoEstado;
    }

    /**
     * @return the contratistaEstado
     */
    public long getContratistaEstado() {
        return contratistaEstado;
    }

    /**
     * @param contratistaEstado the contratistaEstado to set
     */
    public void setContratistaEstado(long contratistaEstado) {
        this.contratistaEstado = contratistaEstado;
    }

    /**
     * @return the posicion
     */
    public PosicionDto getPosicion() {
        return posicion;
    }

    /**
     * @param posicion the posicion to set
     */
    public void setPosicion(PosicionDto posicion) {
        this.posicion = posicion;
    }

    /**
     * @return the noEsUnElefante
     */
    public boolean isNoEsUnReporte() {
        return noEsUnReporte;
    }

    /**
     * @param noEsUnElefante the noEsUnElefante to set
     */
    public void setNoEsUnReporte(boolean noEsUnReporte) {
        this.noEsUnReporte = noEsUnReporte;
    }

    /**
     * @return the idRazonRechazo
     */
    public Long getIdRazonRechazo() {
        return idRazonRechazo;
    }

    /**
     * @param idRazonRechazo the idRazonRechazo to set
     */
    public void setIdRazonRechazo(Long idRazonRechazo) {
        this.idRazonRechazo = idRazonRechazo;
    }

    /**
     * @return the razon
     */
    public String getRazon() {
        return razon;
    }

    /**
     * @param razon the razon to set
     */
    public void setRazon(String razon) {
        this.razon = razon;
    }

    
}
