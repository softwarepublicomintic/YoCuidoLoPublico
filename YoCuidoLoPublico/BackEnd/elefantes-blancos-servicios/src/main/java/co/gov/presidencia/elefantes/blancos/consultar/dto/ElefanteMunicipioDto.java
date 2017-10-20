/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dto;

/**
 *
 * @author farevalo
 */
public class ElefanteMunicipioDto {
    
    private long id;
    private PosicionDto posicion;    
    private String titulo;
    private long estado;
    private boolean noEsUnReporte;

    public ElefanteMunicipioDto(long id, String titulo, long estado, double latitud, double longitud, boolean noEsUnReporte) {
        this.id = id;
        this.titulo = titulo;
        this.estado = estado;
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
     * @return the estado
     */
    public long getEstado() {
        return estado;
    }

    /**
     * @param estado the estado to set
     */
    public void setEstado(long estado) {
        this.estado = estado;
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
 
    
    
}
