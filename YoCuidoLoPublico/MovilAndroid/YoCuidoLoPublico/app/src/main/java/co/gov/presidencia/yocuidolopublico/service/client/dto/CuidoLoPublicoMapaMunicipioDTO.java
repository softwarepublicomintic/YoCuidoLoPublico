package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class CuidoLoPublicoMapaMunicipioDTO {

	private Long id;
	private String titulo;
	private Long estado;
	private PosicionDTO posicion;
	private Boolean noEsUnReporte;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public Long getEstado() {
		return estado;
	}
	public void setEstado(Long idEstado) {
		this.estado = idEstado;
	}
	public PosicionDTO getPosicion() {
		return posicion;
	}
	public void setPosicion(PosicionDTO posicion) {
		this.posicion = posicion;
	}
	public Boolean getNoEsUnReporte() {
		return noEsUnReporte;
	}
	public void setNoEsUnReporte(Boolean noEsUnReporte) {
		this.noEsUnReporte = noEsUnReporte;
	}
	
}
