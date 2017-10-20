package co.gov.mintic.util.dto;

public class StringTextValueDTO extends StringTextValueParseableDTO {
	private String codigo;
	private String nombre;

	public StringTextValueDTO() {
	}
	
	public StringTextValueDTO(String codigo, String nombre) {
		this.codigo = codigo;
		this.nombre = nombre;
	}
	
	@Override
	public String getId() {
		return codigo;
	}

	@Override
	public void setId(String id) {
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
