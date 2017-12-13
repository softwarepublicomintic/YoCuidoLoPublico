package co.gov.presidencia.yocuidolopublico.service.client.dto;

import java.util.ArrayList;

public class DetalleCuidoLoPublicoDTO {
	private Long id;
	private String titulo;
	private String departamento;
	private String municipio;
	private Long idRazonRechazo;
	private String razon;
	private ArrayList<MiniaturaDTO> miniaturas;
	private Long estado;
	private Integer rechazos;
	private String entidad;
	private Long idMotivo;
	private Long idRangoTiempo;
	private Long costo;
	private String contratista;
	private Long idMiniaturaPrincipal;
	private String fechaReporte;
	private String comentario;
	private Long rangoTiempoEstado;
	private Long costoEstado;
	private PosicionDTO posicion;
	private Long contratistaEstado;
	private Boolean noEsUnReporte;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getDepartamento() {
		return departamento;
	}
	public void setDepartamento(String departamento) {
		this.departamento = departamento;
	}
	public String getMunicipio() {
		return municipio;
	}
	public void setMunicipio(String municipio) {
		this.municipio = municipio;
	}
	public ArrayList<MiniaturaDTO> getMiniaturas() {
		return miniaturas;
	}
	public void setMiniaturas(ArrayList<MiniaturaDTO> miniaturas) {
		this.miniaturas = miniaturas;
	}
	public Long getEstado() {
		return estado;
	}
	public void setEstado(Long estado) {
		this.estado = estado;
	}
	public Integer getRechazos() {
		return rechazos;
	}
	public void setRechazos(Integer rechazos) {
		this.rechazos = rechazos;
	}
	public String getEntidad() {
		return entidad;
	}
	public void setEntidad(String entidad) {
		this.entidad = entidad;
	}
	public Long getIdMotivo() {
		return idMotivo;
	}
	public void setIdMotivo(Long idMotivo) {
		this.idMotivo = idMotivo;
	}
	public Long getIdRangoTiempo() {
		return idRangoTiempo;
	}
	public void setIdRangoTiempo(Long idRangoTiempo) {
		this.idRangoTiempo = idRangoTiempo;
	}
	public Long getCosto() {
		return costo;
	}
	public void setCosto(Long costo) {
		this.costo = costo;
	}
	public String getContratista() {
		return contratista;
	}
	public void setContratista(String contratista) {
		this.contratista = contratista;
	}
	public Long getIdMiniaturaPrincipal() {
		return idMiniaturaPrincipal;
	}
	public void setIdMiniaturaPrincipal(Long idMiniaturaPrincipal) {
		this.idMiniaturaPrincipal = idMiniaturaPrincipal;
	}
	public String getFechaReporte() {
		return fechaReporte;
	}
	public void setFechaReporte(String fechaReporte) {
		this.fechaReporte = fechaReporte;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public Long getRangoTiempoEstado() {
		return rangoTiempoEstado;
	}
	public void setRangoTiempoEstado(Long rangoTiempoEstado) {
		this.rangoTiempoEstado = rangoTiempoEstado;
	}
	public Long getCostoEstado() {
		return costoEstado;
	}
	public void setCostoEstado(Long costoEstado) {
		this.costoEstado = costoEstado;
	}
	public PosicionDTO getPosicion() {
		return posicion;
	}
	public void setPosicion(PosicionDTO posicion) {
		this.posicion = posicion;
	}
	public Long getContratistaEstado() {
		return contratistaEstado;
	}
	public void setContratistaEstado(Long contratistaEstado) {
		this.contratistaEstado = contratistaEstado;
	}
	public Boolean getNoEsUnReporte() {
		return noEsUnReporte;
	}
	public void setNoEsUnReporte(Boolean noEsUnReporte) {
		this.noEsUnReporte = noEsUnReporte;
	}
	public Long getIdRazonRechazo() {
		return idRazonRechazo;
	}
	public void setIdRazonRechazo(Long idRazonRechazo) {
		this.idRazonRechazo = idRazonRechazo;
	}
	public String getRazon() {
		return razon;
	}
	public void setRazon(String razon) {
		this.razon = razon;
	}
}
