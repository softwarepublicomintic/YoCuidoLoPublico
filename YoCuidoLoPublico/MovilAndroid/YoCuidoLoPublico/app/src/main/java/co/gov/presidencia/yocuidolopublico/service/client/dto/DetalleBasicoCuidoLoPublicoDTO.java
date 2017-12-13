package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class DetalleBasicoCuidoLoPublicoDTO {
	private String titulo;
	private String imagenPrincipal;
	private Long rechazos;
	private Long estado;
	private Long id;
	
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getImagenPrincipal() {
		return imagenPrincipal;
	}
	public void setImagenPrincipal(String imagenPrincipal) {
		this.imagenPrincipal = imagenPrincipal;
	}
	public Long getRechazos() {
		return rechazos;
	}
	public void setRechazos(Long rechazos) {
		this.rechazos = rechazos;
	}
	public Long getEstado() {
		return estado;
	}
	public void setEstado(Long estado) {
		this.estado = estado;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
		
}
