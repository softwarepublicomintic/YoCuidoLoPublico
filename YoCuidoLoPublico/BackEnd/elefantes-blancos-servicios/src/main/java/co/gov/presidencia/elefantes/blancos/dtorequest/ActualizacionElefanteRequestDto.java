package co.gov.presidencia.elefantes.blancos.dtorequest;

/**
 *
 * @author Anibal Parra
 */
public class ActualizacionElefanteRequestDto {

    private long idElefante;
    private String titulo;
    private String motivo;
    private String entidad;
    private double costo;
    private String contratista;
    private long rangoTiempo;

    public ActualizacionElefanteRequestDto(long idElefante, String titulo, String motivo, String entidad, double costo, String contratista, long rangoTiempo) {
        this.idElefante = idElefante;
        this.titulo = titulo;
        this.motivo = motivo;
        this.entidad = entidad;
        this.costo = costo;
        this.contratista = contratista;
        this.rangoTiempo = rangoTiempo;
    }

    public ActualizacionElefanteRequestDto() {
        
    }

    public long getIdElefante() {
        return idElefante;
    }

    public void setIdElefante(long idElefante) {
        this.idElefante = idElefante;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public String getEntidad() {
        return entidad;
    }

    public void setEntidad(String entidad) {
        this.entidad = entidad;
    }

    public double getCosto() {
        return costo;
    }

    public void setCosto(double costo) {
        this.costo = costo;
    }

    public String getContratista() {
        return contratista;
    }

    public void setContratista(String contratista) {
        this.contratista = contratista;
    }

    public long getRangoTiempo() {
        return rangoTiempo;
    }

    public void setRangoTiempo(long rangoTiempo) {
        this.rangoTiempo = rangoTiempo;
    }
   
    
}
