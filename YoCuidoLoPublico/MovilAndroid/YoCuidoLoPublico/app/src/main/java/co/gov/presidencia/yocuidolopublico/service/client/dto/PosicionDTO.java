package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class PosicionDTO {

	private double latitud;
	private double longitud;
	
	public PosicionDTO() {}
	
	public PosicionDTO(double latitud, double longitud) {
		this.latitud = latitud;
		this.longitud = longitud;
	}

	public double getLatitud() {
		return latitud;
	}

	public void setLatitud(double latitud) {
		this.latitud = latitud;
	}

	public double getLongitud() {
		return longitud;
	}

	public void setLongitud(double longitud) {
		this.longitud = longitud;
	}
	
	
	
}
