/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dto;

/**
 *
 * @author farevalo
 */
public class ElefanteMasVotadoDto {
    
    private long id;
    private String titulo;
    private String departamento;
    private String municipio;
    private long rechazos;
    private String imagenPrincipal;

    public ElefanteMasVotadoDto(long id, String titulo, String departamento, String municipio, long rechazos, String imagenPrincipal) {
        this.id = id;
        this.titulo = titulo;
        this.departamento = departamento;
        this.municipio = municipio;
        this.rechazos = rechazos;
        this.imagenPrincipal = imagenPrincipal;
    }

    
    
    /**
     * @return the id
     */
    public long getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(long id) {
        this.id = id;
    }

    /**
     * @return the titulo
     */
    public String getTitulo() {
        return titulo;
    }

    /**
     * @param titulo the titulo to set
     */
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    /**
     * @return the departamento
     */
    public String getDepartamento() {
        return departamento;
    }

    /**
     * @param departamento the departamento to set
     */
    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    /**
     * @return the municipio
     */
    public String getMunicipio() {
        return municipio;
    }

    /**
     * @param municipio the municipio to set
     */
    public void setMunicipio(String municipio) {
        this.municipio = municipio;
    }

    /**
     * @return the rechazos
     */
    public long getRechazos() {
        return rechazos;
    }

    /**
     * @param rechazos the rechazos to set
     */
    public void setRechazos(long rechazos) {
        this.rechazos = rechazos;
    }

    /**
     * @return the imagenPrincipal
     */
    public String getImagenPrincipal() {
        return imagenPrincipal;
    }

    /**
     * @param imagenPrincipal the imagenPrincipal to set
     */
    public void setImagenPrincipal(String imagenPrincipal) {
        this.imagenPrincipal = imagenPrincipal;
    }
    
    
    
}
