package co.gov.presidencia.elefantes.blancos.dto;

import java.util.List;

/**
 *
 * @author Anibal Parra
 */
public class DetalleElefante {

    private String titulo;
    private String imagen;
    private String fechaReporte;
    private String idDepartamento;
    private String idMunicipio;
    private long idRangoTiempo;
    private List<Imagen> imagenesAsociadas;
    private String idMotivo;
    private int numVotos;
    private long estado;
    private String comentario;
    private String entidad;
    private double costo;
    private String contratista;

    public DetalleElefante(String titulo, String imagen, String fechaReporte, String idDepartamento, String idMunicipio, long idRangoTiempo, List<Imagen> imagenesAsociadas, String idMotivo, int numVotos, long estado, String comentario, String entidad, double costo, String contratista) {
        this.titulo = titulo;
        this.imagen = imagen;
        this.fechaReporte = fechaReporte;
        this.idDepartamento = idDepartamento;
        this.idMunicipio = idMunicipio;
        this.idRangoTiempo = idRangoTiempo;
        this.imagenesAsociadas = imagenesAsociadas;
        this.idMotivo = idMotivo;
        this.numVotos = numVotos;
        this.estado = estado;
        this.comentario = comentario;
        this.entidad = entidad;
        this.costo = costo;
        this.contratista = contratista;
    }

    public DetalleElefante() {
        
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getFechaReporte() {
        return fechaReporte;
    }

    public void setFechaReporte(String fechaReporte) {
        this.fechaReporte = fechaReporte;
    }

    public String getIdDepartamento() {
        return idDepartamento;
    }

    public void setIdDepartamento(String idDepartamento) {
        this.idDepartamento = idDepartamento;
    }

    public String getIdMunicipio() {
        return idMunicipio;
    }

    public void setIdMunicipio(String idMunicipio) {
        this.idMunicipio = idMunicipio;
    }

    public long getIdRangoTiempo() {
        return idRangoTiempo;
    }

    public void setIdRangoTiempo(long idRangoTiempo) {
        this.idRangoTiempo = idRangoTiempo;
    }

    public List<Imagen> getImagenesAsociadas() {
        return imagenesAsociadas;
    }

    public void setImagenesAsociadas(List<Imagen> imagenesAsociadas) {
        this.imagenesAsociadas = imagenesAsociadas;
    }

    public String getIdMotivo() {
        return idMotivo;
    }

    public void setIdMotivo(String idMotivo) {
        this.idMotivo = idMotivo;
    }

    public int getNumVotos() {
        return numVotos;
    }

    public void setNumVotos(int numVotos) {
        this.numVotos = numVotos;
    }

    public long getEstado() {
        return estado;
    }

    public void setEstado(long estado) {
        this.estado = estado;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
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
    
    
    
}
