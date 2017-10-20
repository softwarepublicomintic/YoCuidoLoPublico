package co.gov.presidencia.yocuidolopublico.event;

public class ItemColegioSeleccionadoEvent {

	private Integer position;

	public ItemColegioSeleccionadoEvent(Integer position) {
		this.position = position;
	}

	public Integer getPosition() {
		return position;
	}

	public void setPosition(Integer position) {
		this.position = position;
	}
	
	
}
