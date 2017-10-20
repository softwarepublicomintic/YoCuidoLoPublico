package co.gov.presidencia.elefantes.blancos.actualizacion.dtorequest;

import co.gov.presidencia.elefantes.blancos.actualizacion.dto.Posicion;




/**
 *
 * @author Anibal Parra
 */
public class ElefanteBlancoRequestDto {
    
    private String idDepartamento;
    private String idMunicipio;
    private String direccion;
    private Posicion posicion;
    private String imagen;
    private String entidad;
    private Long idRangoTiempo ;
    private String titulo;
    private long idMotivo;
    private long costo;
    private String contratista;

    public String getString() {
        String value = "";
        value += " Departamento : " + idDepartamento + " //";
        value += " Municipio : " + idMunicipio + " //";
        value += " Dirección : " + direccion + " //";
        value += " Latitud : " + posicion.getLatitud() + " //";
        value += " Longitud : " + posicion.getLongitud()+ " //";
        value += " Entidad : " + entidad + " //";
        value += " Rango de Tiempo : " + idRangoTiempo + " //";
        value += " Título : " + titulo + " //";
        value += " Motivo : " + idMotivo + " //";
        value += " Costo : " + costo + " //";
        value += " Contratista : " + contratista + " //";
        return value;
    }
    
    
    /**
     * @return the idDepartamento
     */
    public String getIdDepartamento() {
        return idDepartamento;
    }

    /**
     * @param idDepartamento the idDepartamento to set
     */
    public void setIdDepartamento(String idDepartamento) {
        this.idDepartamento = idDepartamento;
    }

    /**
     * @return the idMunicipio
     */
    public String getIdMunicipio() {
        return idMunicipio;
    }

    /**
     * @param idMunicipio the idMunicipio to set
     */
    public void setIdMunicipio(String idMunicipio) {
        this.idMunicipio = idMunicipio;
    }

    /**
     * @return the direccion
     */
    public String getDireccion() {
        return direccion;
    }

    /**
     * @param direccion the direccion to set
     */
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    /**
     * @return the posicion
     */
    public Posicion getPosicion() {
        return posicion;
    }

    /**
     * @param posicion the posicion to set
     */
    public void setPosicion(Posicion posicion) {
        this.posicion = posicion;
    }

    /**
     * @return the imagen
     */
    public String getImagen() {
        return imagen;
    }

    /**
     * @param imagen the imagen to set
     */
    public void setImagen(String imagen) {
        this.imagen = imagen;
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
     * @return the idRangoTiempo
     */
    public Long getIdRangoTiempo() {
        return idRangoTiempo;
    }

    /**
     * @param idRangoTiempo the idRangoTiempo to set
     */
    public void setIdRangoTiempo(Long idRangoTiempo) {
        this.idRangoTiempo = idRangoTiempo;
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

    
    
}
