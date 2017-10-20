/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.actualizacion.dtoresponse;

/**
 *
 * @author farevalo
 */
public class RegistrarVotoResponseDto {
    
    private Integer cantidadVotos = 0;

    public RegistrarVotoResponseDto(Integer cantidadVotos) {
        this.cantidadVotos = cantidadVotos;
    }
    
    

    /**
     * @return the cantidadVotos
     */
    public Integer getCantidadVotos() {
        return cantidadVotos;
    }

    /**
     * @param cantidadVotos the cantidadVotos to set
     */
    public void setCantidadVotos(Integer cantidadVotos) {
        this.cantidadVotos = cantidadVotos;
    }
    
}
