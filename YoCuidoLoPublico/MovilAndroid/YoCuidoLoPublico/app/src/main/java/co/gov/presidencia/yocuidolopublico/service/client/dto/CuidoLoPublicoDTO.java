package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class CuidoLoPublicoDTO {

	private Long idReporte;
	private String titulo;
	private String idDepartamento;
	private String idMunicipio;
	private Long estado;
	private PosicionDTO posicion;
	
	public Long getIdReporte() {
		return idReporte;
	}
	public void setIdReporte(Long idReporte) {
		this.idReporte = idReporte;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
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
	public Long getEstado() {
		return estado;
	}
	public void setEstado(Long estado) {
		this.estado = estado;
	}
	public PosicionDTO getPosicion() {
		return posicion;
	}
	public void setPosicion(PosicionDTO posicion) {
		this.posicion = posicion;
	}
	
}
