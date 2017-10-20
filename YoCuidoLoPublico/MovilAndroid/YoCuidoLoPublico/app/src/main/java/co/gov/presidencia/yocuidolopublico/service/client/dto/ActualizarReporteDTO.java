package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class ActualizarReporteDTO {
	
	private String titulo;
	private Long idMotivo;
	private String entidad;
	private Long costo;
	private String contratista;
	private Long idRangoTiempo;

	public String getEntidad() {
		return entidad;
	}
	public void setEntidad(String entidad) {
		this.entidad = entidad;
	}
	public Long getIdRangoTiempo() {
		return idRangoTiempo;
	}
	public void setIdRangoTiempo(Long idRangoTiempo) {
		this.idRangoTiempo = idRangoTiempo;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public Long getIdMotivo() {
		return idMotivo;
	}
	public void setIdMotivo(Long idMotivo) {
		this.idMotivo = idMotivo;
	}
	public Long getCosto() {
		return costo;
	}
	public void setCosto(Long costo) {
		this.costo = costo;
	}
	public String getContratista() {
		return contratista;
	}
	public void setContratista(String contratista) {
		this.contratista = contratista;
	}
}
