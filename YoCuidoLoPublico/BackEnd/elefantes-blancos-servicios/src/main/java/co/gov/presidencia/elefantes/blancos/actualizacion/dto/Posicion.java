/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.actualizacion.dto;

/**
 *
 * @author Anibal Parra
 */
public class Posicion {
    
    private double latitud;
    private double longitud;

    public Posicion(double latitud, double longitud) {
        this.latitud = latitud;
        this.longitud = longitud;
    }
    
    public Posicion() {
        
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
