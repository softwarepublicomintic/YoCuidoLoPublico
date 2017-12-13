package co.gov.presidencia.elefantes.blancos.dtoresponse;

import java.io.Serializable;

/**
 *
 * @author Anibal Parra
 */
public class MiElefanteResponseDto implements Serializable{
    
    private String titulo;
    private String imagenPrincipal;
    private int rechazos;
    private long estado;
    private Long id;

    public MiElefanteResponseDto(String titulo, String imagenPrincipal, int rechazos, long estado, Long id) {
        this.titulo = titulo;
        this.imagenPrincipal = imagenPrincipal;
        this.rechazos = rechazos;
        this.estado = estado;
        this.id = id;
    }
    
    public MiElefanteResponseDto() {
        
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getImagenPrincipal() {
        return imagenPrincipal;
    }

    public void setImagenPrincipal(String imagenPrincipal) {
        this.imagenPrincipal = imagenPrincipal;
    }

    public int getRechazos() {
        return rechazos;
    }

    public void setRechazos(int rechazos) {
        this.rechazos = rechazos;
    }

    public long getEstado() {
        return estado;
    }

    public void setEstado(long estado) {
        this.estado = estado;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    
}
