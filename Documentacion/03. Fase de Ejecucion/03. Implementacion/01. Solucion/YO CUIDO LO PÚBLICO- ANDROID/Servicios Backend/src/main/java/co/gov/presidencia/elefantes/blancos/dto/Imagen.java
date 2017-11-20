package co.gov.presidencia.elefantes.blancos.dto;

/**
 *
 * @author Anibal Parra
 */
public class Imagen {

    private long id;
    private String miniatura;
    private long imagenGrande;

    public Imagen(long id, String miniatura, long imagenGrande) {
        this.id = id;
        this.miniatura = miniatura;
        this.imagenGrande = imagenGrande;
    }
    
    public Imagen() {
        
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getMiniatura() {
        return miniatura;
    }

    public void setMiniatura(String miniatura) {
        this.miniatura = miniatura;
    }

    public long getImagenGrande() {
        return imagenGrande;
    }

    public void setImagenGrande(long imagenGrande) {
        this.imagenGrande = imagenGrande;
    }
    
    
}
