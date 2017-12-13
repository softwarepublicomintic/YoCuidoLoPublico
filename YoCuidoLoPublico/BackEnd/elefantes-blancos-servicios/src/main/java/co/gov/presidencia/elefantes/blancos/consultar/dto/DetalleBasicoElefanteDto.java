/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dto;

import java.sql.Date;
import java.util.List;

/**
 *
 * @author farevalo
 */
public class DetalleBasicoElefanteDto {

    private long id;
    private String titulo;
    private String imagenPrincipal;
    private long estado;
    private long rechazos;

    public DetalleBasicoElefanteDto(long id, String titulo, String imagenPrincipal, long estado, long rechazos) {
        this.id = id;
        this.titulo = titulo;
        this.imagenPrincipal = imagenPrincipal;
        this.estado = estado;
        this.rechazos = rechazos;
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

    /**
     * @return the estado
     */
    public long getEstado() {
        return estado;
    }

    /**
     * @param estado the estado to set
     */
    public void setEstado(long estado) {
        this.estado = estado;
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
    
}
