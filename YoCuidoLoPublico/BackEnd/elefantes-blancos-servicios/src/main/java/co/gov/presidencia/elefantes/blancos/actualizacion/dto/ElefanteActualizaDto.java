/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.actualizacion.dto;

/**
 *
 * @author farevalo
 */
public class ElefanteActualizaDto {
    
    private long rangoTiempoEstado;
    private long costoEstado;
    private long contratistaEstado;    

    public ElefanteActualizaDto(long rangoTiempoEstado, long costoEstado, long contratistaEstado) {
        this.rangoTiempoEstado = rangoTiempoEstado;
        this.costoEstado = costoEstado;
        this.contratistaEstado = contratistaEstado;
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
    
}
