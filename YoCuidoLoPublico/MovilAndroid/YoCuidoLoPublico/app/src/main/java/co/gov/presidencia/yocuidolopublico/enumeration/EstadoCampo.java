package co.gov.presidencia.yocuidolopublico.enumeration;

public enum EstadoCampo {

	PENDIENTE(0L), VALIDADO(1L), RECHAZADO(2L);
	
	private Long id;
	
	private EstadoCampo(Long id) {
		this.id = id;
	}
	
	public Long getId() {
		return id;
	}
}
