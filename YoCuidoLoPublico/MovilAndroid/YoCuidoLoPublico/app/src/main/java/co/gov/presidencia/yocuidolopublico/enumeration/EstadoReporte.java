package co.gov.presidencia.yocuidolopublico.enumeration;


import co.gov.presidencia.yocuidolopublico.R;

public enum EstadoReporte {

	PENDIENTE(1L, R.string.estado_pendiente, R.drawable.icono_pendiente_peque), VALIDADO(2L, R.string.estado_validado, R.drawable.icono_aprobado_peque), RECHAZADO(3L, R.string.estado_rechazado, R.drawable.icono_rechazado_peque);
	
	private Long id;
	private Integer texto;
	private Integer idImagen;
	
	private EstadoReporte(Long id, Integer texto, Integer idImagen){
		this.id = id;
		this.texto = texto;
		this.idImagen = idImagen;
	}
	
	public Long getId(){
		return id;
	}
	
	public Integer getTexto(){
		return texto;
	}
	
	public Integer getIdImagen(){
		return idImagen;
	}
}
