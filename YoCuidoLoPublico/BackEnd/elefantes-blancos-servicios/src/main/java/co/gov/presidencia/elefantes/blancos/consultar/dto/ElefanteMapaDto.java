/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dto;



/**
 *
 * @author farevalo
 */
public class ElefanteMapaDto {
    
    private long id;
    private PosicionDto posicion;
    private String titulo;
    private boolean noEsUnReporte;
    private long idEstado;

    public ElefanteMapaDto(long id, String titulo, long idEstado, double latitud, double longitud, boolean noEsUnReporte) {
        this.id = id;
        this.titulo = titulo;
        this.idEstado = idEstado;
        posicion = new PosicionDto(latitud, longitud);
        this.noEsUnReporte = noEsUnReporte;
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
     * @return the idEstado
     */
    public long getIdEstado() {
        return idEstado;
    }

    /**
     * @param idEstado the idEstado to set
     */
    public void setIdEstado(long idEstado) {
        this.idEstado = idEstado;
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
    public void setNoEsUnReporte(boolean noEsUnElefante) {
        this.noEsUnReporte = noEsUnElefante;
    }
    
    
}
