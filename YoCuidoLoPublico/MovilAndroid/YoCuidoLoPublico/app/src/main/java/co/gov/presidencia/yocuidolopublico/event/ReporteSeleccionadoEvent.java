package co.gov.presidencia.yocuidolopublico.event;

public class ReporteSeleccionadoEvent {

	private Long id;

	public ReporteSeleccionadoEvent(Long id) {
		this.id = id;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
}
