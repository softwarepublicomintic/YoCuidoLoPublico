/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dtoresponse;

/**
 *
 * @author farevalo
 */
public class ImagenReponseDto {
    
    private String imagen = null;

    public ImagenReponseDto(String imagen) {
        this.imagen = imagen;
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
    
    
    
}
