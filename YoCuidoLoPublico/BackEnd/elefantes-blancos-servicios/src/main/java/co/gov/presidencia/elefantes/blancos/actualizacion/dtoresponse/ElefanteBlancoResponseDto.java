/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.actualizacion.dtoresponse;

/**
 *
 * @author farevalo
 */
public class ElefanteBlancoResponseDto {
    
    private Integer id;

    public ElefanteBlancoResponseDto() {
    }

    public ElefanteBlancoResponseDto(Integer id) {
        this.id = id;
    }
    
    public ElefanteBlancoResponseDto(int id) {
        this.id = id;
    }

    
    
    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }
    
}
