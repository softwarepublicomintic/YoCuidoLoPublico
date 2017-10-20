/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dto;

/**
 *
 * @author farevalo
 */
public class ImageneMiniaturaDto {
    
    private long id;
    private String miniatura;
    private long idImagenGrande;

    public ImageneMiniaturaDto(long id, long idImagenGrande) {
        this.id = id;
        this.idImagenGrande = idImagenGrande;
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
     * @return the miniatura
     */
    public String getMiniatura() {
        return miniatura;
    }

    /**
     * @param miniatura the miniatura to set
     */
    public void setMiniatura(String miniatura) {
        this.miniatura = miniatura;
    }

    /**
     * @return the idImagenGrande
     */
    public long getIdImagenGrande() {
        return idImagenGrande;
    }

    /**
     * @param idImagenGrande the idImagenGrande to set
     */
    public void setIdImagenGrande(long idImagenGrande) {
        this.idImagenGrande = idImagenGrande;
    }
    
    
    
}
