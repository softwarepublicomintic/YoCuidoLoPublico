package co.gov.mintic.util.dto;

public class TextValueDTO extends TextValueParseableDTO {
	private Long codigo;
	private String nombre;

	public TextValueDTO() {
	}
	
	public TextValueDTO(Long codigo, String nombre) {
		this.codigo = codigo;
		this.nombre = nombre;
	}
	
	@Override
	public Long getId() {
		return codigo;
	}

	@Override
	public void setId(Long id) {
		this.codigo = id;
	}

	@Override
	public String getNombre() {
		return nombre;
	}

	@Override
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	@Override
	public String toString() {
		return nombre;
	}

}
