package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class ReportarCuidoLoPublicoDTO {
	private String idDepartamento;
	private String idMunicipio;
	private String direccion;
	private PosicionDTO posicion;
	private String imagen;
	private String entidad;
	private Long idRangoTiempo;
	private String titulo;
	private Long idMotivo;
	private Long costo;
	private String contratista;
	
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
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public PosicionDTO getPosicion() {
		return posicion;
	}
	public void setPosicion(PosicionDTO posicion) {
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
