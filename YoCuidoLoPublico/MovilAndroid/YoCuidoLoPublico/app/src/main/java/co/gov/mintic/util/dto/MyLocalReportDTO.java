package co.gov.mintic.util.dto;

public class MyLocalReportDTO {
	private Long id;
	private String nombre;
	private Double lat;
	private Double lng;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombreInstitucion(String nombre) {
		this.nombre = nombre;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
	}
	public Double getLng() {
		return lng;
	}
	public void setLng(Double lng) {
		this.lng = lng;
	}
	
	
}
