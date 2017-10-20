package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class MunicipioMapaDTO {

	private String municipio;
	private PosicionDTO posicion;
	
	public String getMunicipio() {
		return municipio;
	}
	public void setMunicipio(String municipio) {
		this.municipio = municipio;
	}
	public PosicionDTO getPosicion() {
		return posicion;
	}
	public void setPosicion(PosicionDTO posicion) {
		this.posicion = posicion;
	}
	
}
