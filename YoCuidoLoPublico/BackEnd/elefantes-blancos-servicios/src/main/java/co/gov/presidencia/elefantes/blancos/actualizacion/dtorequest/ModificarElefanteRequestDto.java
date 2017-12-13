/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.actualizacion.dtorequest;

/**
 *
 * @author farevalo
 */
public class ModificarElefanteRequestDto {
    
    private long idElefante;
    private String titulo;
    private long idMotivo;
    private String entidad;
    private long costo;
    private String contratista;
    private long idRangoTiempo;

    public String getString() {
        String value = "";
        value += " Entidad : " + entidad + " //";
        value += " Rango de Tiempo : " + idRangoTiempo + " //";
        value += " Titulo : " + titulo + " //";
        value += " Motivo : " + idMotivo + " //";
        value += " Costo : " + costo + " //";
        value += " Contratista : " + contratista + " //";
        return value;
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
     * @return the idElefante
     */
    public long getIdElefante() {
        return idElefante;
    }

    /**
     * @param idElefante the idElefante to set
     */
    public void setIdElefante(long idElefante) {
        this.idElefante = idElefante;
    }
}
