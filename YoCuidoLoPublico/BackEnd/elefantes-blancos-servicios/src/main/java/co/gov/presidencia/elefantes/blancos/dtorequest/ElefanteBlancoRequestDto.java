package co.gov.presidencia.elefantes.blancos.dtorequest;

import co.gov.presidencia.elefantes.blancos.dto.Posicion;

/**
 *
 * @author Anibal Parra
 */
public class ElefanteBlancoRequestDto {
    
    private String departamento;
    private String municipio;
    private String direccion;
    private Posicion posicion;
    private String imagen;
    private String entidad;
    private long rangoTiempo;
    private String titulo;
    private long motivo;
    private long costo;
    private String contratista;

    public ElefanteBlancoRequestDto(String departamento, String municipio, String direccion, Posicion posicion, String imagen, String entidad, long rangoTiempo, String titulo, long motivo, long costo, String contratista) {
        this.departamento = departamento;
        this.municipio = municipio;
        this.direccion = direccion;
        this.posicion = posicion;
        this.imagen = imagen;
        this.entidad = entidad;
        this.rangoTiempo = rangoTiempo;
        this.titulo = titulo;
        this.motivo = motivo;
        this.costo = costo;
        this.contratista = contratista;
    }
    
    public ElefanteBlancoRequestDto() {
        
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

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public Posicion getPosicion() {
        return posicion;
    }

    public void setPosicion(Posicion posicion) {
        this.posicion = posicion;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getEntidad() {
        return entidad;
    }

    public void setEntidad(String entidad) {
        this.entidad = entidad;
    }

    public long getRangoTiempo() {
        return rangoTiempo;
    }

    public void setRangoTiempo(long rangoTiempo) {
        this.rangoTiempo = rangoTiempo;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public long getMotivo() {
        return motivo;
    }

    public void setMotivo(long motivo) {
        this.motivo = motivo;
    }

    public long getCosto() {
        return costo;
    }

    public void setCosto(long costo) {
        this.costo = costo;
    }

    public String getContratista() {
        return contratista;
    }

    public void setContratista(String contratista) {
        this.contratista = contratista;
    }
    
    
}
