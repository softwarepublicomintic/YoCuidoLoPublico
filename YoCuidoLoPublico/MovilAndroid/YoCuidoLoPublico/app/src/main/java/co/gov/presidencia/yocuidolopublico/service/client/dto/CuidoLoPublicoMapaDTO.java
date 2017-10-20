package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class CuidoLoPublicoMapaDTO {

	private Long id;
	private String titulo;
	private Long idEstado;
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
	public Long getIdEstado() {
		return idEstado;
	}
	public void setIdEstado(Long idEstado) {
		this.idEstado = idEstado;
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
