package co.gov.presidencia.elefantes.blancos.dtoresponse;

/**
 *
 * @author Anibal Parra
 */
public class ConsultarImagenResponseDto {

    private String imagen;

    public ConsultarImagenResponseDto(String imagen) {
        this.imagen = imagen;
    }
    
    public ConsultarImagenResponseDto() {
        
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }
    
    
}
