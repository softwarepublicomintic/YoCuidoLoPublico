package co.gov.mintic.util.dto;

import java.io.InputStream;

public class FormatoDTO {

	public enum Type{JSON}
	
	private Type type;
	private InputStream contenido;
	
	public FormatoDTO(Type type, InputStream contenido) {
		super();
		this.type = type;
		this.contenido = contenido;
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public InputStream getContenido() {
		return contenido;
	}

	public void setContenido(InputStream contenido) {
		this.contenido = contenido;
	}
	
	
	
}
