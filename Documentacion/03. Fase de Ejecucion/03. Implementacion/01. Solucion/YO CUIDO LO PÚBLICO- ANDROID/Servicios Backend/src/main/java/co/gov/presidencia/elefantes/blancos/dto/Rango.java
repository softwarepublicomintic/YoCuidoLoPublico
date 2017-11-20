package co.gov.presidencia.elefantes.blancos.dto;

/**
 *
 * @author Anibal Parra
 */
public class Rango {

    private String id;
    private String texto;

    public Rango(String id, String texto) {
        this.id = id;
        this.texto = texto;
    }

    public Rango() {
        
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

