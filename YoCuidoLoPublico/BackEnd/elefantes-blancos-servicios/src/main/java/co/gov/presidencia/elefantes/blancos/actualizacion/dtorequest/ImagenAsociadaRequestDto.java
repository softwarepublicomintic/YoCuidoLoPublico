/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.actualizacion.dtorequest;

/**
 *
 * @author farevalo
 */
public class ImagenAsociadaRequestDto {
    
    private long idElefante;
    private String imagen;;

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
