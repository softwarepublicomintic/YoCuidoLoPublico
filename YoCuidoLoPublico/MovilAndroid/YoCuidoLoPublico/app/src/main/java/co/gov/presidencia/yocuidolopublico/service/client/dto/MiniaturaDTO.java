package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class MiniaturaDTO {
	private Long id;
	private String miniatura;
	private Long idImagenGrande;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getMiniatura() {
		return miniatura;
	}
	public void setMiniatura(String miniatura) {
		this.miniatura = miniatura;
	}
	public Long getIdImagenGrande() {
		return idImagenGrande;
	}
	public void setIdImagenGrande(Long idImagenGrande) {
		this.idImagenGrande = idImagenGrande;
	}
}
