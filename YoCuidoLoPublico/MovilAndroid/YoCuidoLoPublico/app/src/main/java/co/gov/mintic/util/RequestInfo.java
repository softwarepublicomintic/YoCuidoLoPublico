package co.gov.mintic.util;

import android.content.Context;

public class RequestInfo {

	private String url;
	private String usuario;
	private String clave;
	private Context context;
	private String rutaArchivo;

	public RequestInfo() {

	}

	public RequestInfo(String url, String usuario, String clave) {
		super();
		this.url = url;
		this.usuario = usuario;
		this.clave = clave;
	}

	public RequestInfo(Context context, String rutaArchivo) {
		super();
		this.context = context;
		this.rutaArchivo = rutaArchivo;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

	public Context getContext() {
		return context;
	}

	public void setContext(Context context) {
		this.context = context;
	}

	public String getRutaArchivo() {
		return rutaArchivo;
	}

	public void setRutaArchivo(String rutaArchivo) {
		this.rutaArchivo = rutaArchivo;
	}

}
