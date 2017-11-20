/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.consultar.dto;

/**
 *
 * @author farevalo
 */
public class PosicionDto {
    
    private double latitud;
    private double longitud;

    public PosicionDto(double latitud, double longitud) {
        this.latitud = latitud;
        this.longitud = longitud;
    }


    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }    
    
}
