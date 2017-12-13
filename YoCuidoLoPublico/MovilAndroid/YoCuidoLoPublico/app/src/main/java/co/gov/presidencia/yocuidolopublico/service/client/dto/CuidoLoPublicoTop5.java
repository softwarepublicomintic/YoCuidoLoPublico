package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class CuidoLoPublicoTop5 {
	private Long id;
	private String titulo;
	private String departamento;
	private String municipio;
	private Long rechazos;
	private String imagenPrincipal;
	
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
	public Long getRechazos() {
		return rechazos;
	}
	public void setRechazos(Long rechazos) {
		this.rechazos = rechazos;
	}
	public String getImagenPrincipal() {
		return imagenPrincipal;
	}
	public void setImagenPrincipal(String imagenPrincipal) {
		this.imagenPrincipal = imagenPrincipal;
	}
}
