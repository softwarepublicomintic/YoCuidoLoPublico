/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dto;

/**
 *
 * @author farevalo
 */
public class RegionDto {
    
    private long idRegion;
    private long cantidad;

    public RegionDto(long idRegion, long cantidad) {
        this.idRegion = idRegion;
        this.cantidad = cantidad;
    }

    /**
     * @return the ig
     */
    public long getIdRegion() {
        return idRegion;
    }

    /**
     * @param ig the ig to set
     */
    public void setIdRegion(long ig) {
        this.idRegion = idRegion;
    }

    /**
     * @return the cantidad
     */
    public long getCantidad() {
        return cantidad;
    }

    /**
     * @param cantidad the cantidad to set
     */
    public void setCantidad(long cantidad) {
        this.cantidad = cantidad;
    }
    
    
}
