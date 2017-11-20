package co.gov.presidencia.elefantes.blancos.dto;

/**
 *
 * @author Anibal Parra
 */
public class Motivo {

    private String id;
    private String texto;

    public Motivo(String id, String texto) {
        this.id = id;
        this.texto = texto;
    }

    public Motivo() {
        
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }
    
    
}
