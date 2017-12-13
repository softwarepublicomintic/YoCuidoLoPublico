package co.gov.presidencia.elefantes.blancos.dtorequest;

/**
 *
 * @author Anibal Parra
 */
public class ImagenAsociadaRequestDto {

    private long elefante;
    private String imagen;

    public ImagenAsociadaRequestDto() {
        
    }
    public ImagenAsociadaRequestDto(long elefante, String imagen) {
        this.elefante = elefante;
        this.imagen = imagen;
    }

    public long getElefante() {
        return elefante;
    }

    public void setElefante(long elefante) {
        this.elefante = elefante;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

}
