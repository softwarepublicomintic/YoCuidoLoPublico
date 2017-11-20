/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dto;

/**
 *
 * @author farevalo
 */
public class MunicipioMapa {
    
    private String municipio;
    private PosicionDto posicion ;

    public MunicipioMapa(String municipio) {
        this.municipio = municipio;
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
     * @return the posicion
     */
    public PosicionDto getPosicion() {
        return posicion;
    }

    /**
     * @param posicion the posicion to set
     */
    public void setPosicion(PosicionDto posicion) {
        this.posicion = posicion;
    }
    
}
