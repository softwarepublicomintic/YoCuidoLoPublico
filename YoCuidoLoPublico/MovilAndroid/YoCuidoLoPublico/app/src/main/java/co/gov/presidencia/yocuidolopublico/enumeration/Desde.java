package co.gov.presidencia.yocuidolopublico.enumeration;

public enum Desde {
	REPORTAR(0), MAPA_MUNICIPIO(1), TOP_CINCO(2), MIS_REPORTES(3);
	
	private int id;
	
	private Desde(int id) {
		this.id = id;
	}
	
	public int getId() {
		return id;
	}
}
