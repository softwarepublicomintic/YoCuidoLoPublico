package co.gov.presidencia.elefantes.blancos.dto;

/**
 *
 * @author Anibal Parra
 */
public class ElefanteTop5 {

    private long id;
    private String titulo;
    private String departamento;
    private String municipio;
    private int rechazos;
    private String imagenPrincipal;

    public ElefanteTop5(long id, String titulo, String departamento, String municipio, int rechazos, String imagenPrincipal) {
        this.id = id;
        this.titulo = titulo;
        this.departamento = departamento;
        this.municipio = municipio;
        this.rechazos = rechazos;
        this.imagenPrincipal = imagenPrincipal;
    }

    public ElefanteTop5() {
        
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public String getMunicipio() {
        return municipio;
    }

    public void setMunicipio(String municipio) {
        this.municipio = municipio;
    }

    public int getRechazos() {
        return rechazos;
    }

    public void setRechazos(int rechazos) {
        this.rechazos = rechazos;
    }

    public String getImagenPrincipal() {
        return imagenPrincipal;
    }

    public void setImagenPrincipal(String imagenPrincipal) {
        this.imagenPrincipal = imagenPrincipal;
    }
    
}
