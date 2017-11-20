package co.gov.presidencia.elefantes.blancos.dto;

/**
 *
 * @author Anibal Parra
 */
public class ElefanteMapa {

    private long id;
    private Posicion posicion;
    private String titulo;
    private long estado;

    public ElefanteMapa(long id, Posicion posicion, String titulo, long estado) {
        this.id = id;
        this.posicion = posicion;
        this.titulo = titulo;
        this.estado = estado;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Posicion getPosicion() {
        return posicion;
    }

    public void setPosicion(Posicion posicion) {
        this.posicion = posicion;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public long getEstado() {
        return estado;
    }

    public void setEstado(long estado) {
        this.estado = estado;
    }

    
}
