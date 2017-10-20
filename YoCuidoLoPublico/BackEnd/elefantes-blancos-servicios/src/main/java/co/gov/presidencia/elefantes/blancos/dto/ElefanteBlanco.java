/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package co.gov.presidencia.elefantes.blancos.dto;

import java.io.Serializable;
import java.util.List;

/**
 *
 * @author Anibal Parra
 */
public class ElefanteBlanco implements Serializable{
    
    private long id;
    private String titulo;
    private String departamento;
    private String municipio;
    private List<Imagen> miniaturas;
    private long estado;
    private int rechazos;
    private String entidad;
    private long motivo;
    private long rangoTiempo;
    private long costo;
    private String contratista;
    private long miniaturaPrincipal;
    private String fechaReporte;
    private String comentario;
    private int rangoTiempoEstado;
    private int costoEstado;
    private int contratistaEstado;

    public ElefanteBlanco(long id, String titulo, String departamento, String municipio, List<Imagen> miniaturas, long estado, int rechazos, String entidad, long motivo, long rangoTiempo, long costo, String contratista, long miniaturaPrincipal, String fechaReporte, String comentario, int rangoTiempoEstado, int costoEstado, int contratistaEstado) {
        this.id = id;
        this.titulo = titulo;
        this.departamento = departamento;
        this.municipio = municipio;
        this.miniaturas = miniaturas;
        this.estado = estado;
        this.rechazos = rechazos;
        this.entidad = entidad;
        this.motivo = motivo;
        this.rangoTiempo = rangoTiempo;
        this.costo = costo;
        this.contratista = contratista;
        this.miniaturaPrincipal = miniaturaPrincipal;
        this.fechaReporte = fechaReporte;
        this.comentario = comentario;
        this.rangoTiempoEstado = rangoTiempoEstado;
        this.costoEstado = costoEstado;
        this.contratistaEstado = contratistaEstado;
    }

    public ElefanteBlanco() {
        
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
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

    public List<Imagen> getMiniaturas() {
        return miniaturas;
    }

    public void setMiniaturas(List<Imagen> miniaturas) {
        this.miniaturas = miniaturas;
    }

    public long getEstado() {
        return estado;
    }

    public void setEstado(long estado) {
        this.estado = estado;
    }

    public int getRechazos() {
        return rechazos;
    }

    public void setRechazos(int rechazos) {
        this.rechazos = rechazos;
    }

    public String getEntidad() {
        return entidad;
    }

    public void setEntidad(String entidad) {
        this.entidad = entidad;
    }

    public long getMotivo() {
        return motivo;
    }

    public void setMotivo(long motivo) {
        this.motivo = motivo;
    }

    public long getRangoTiempo() {
        return rangoTiempo;
    }

    public void setRangoTiempo(long rangoTiempo) {
        this.rangoTiempo = rangoTiempo;
    }

    public long getCosto() {
        return costo;
    }

    public void setCosto(long costo) {
        this.costo = costo;
    }

    public String getContratista() {
        return contratista;
    }

    public void setContratista(String contratista) {
        this.contratista = contratista;
    }

    public long getMiniaturaPrincipal() {
        return miniaturaPrincipal;
    }

    public void setMiniaturaPrincipal(long miniaturaPrincipal) {
        this.miniaturaPrincipal = miniaturaPrincipal;
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

    public int getRangoTiempoEstado() {
        return rangoTiempoEstado;
    }

    public void setRangoTiempoEstado(int rangoTiempoEstado) {
        this.rangoTiempoEstado = rangoTiempoEstado;
    }

    public int getCostoEstado() {
        return costoEstado;
    }

    public void setCostoEstado(int costoEstado) {
        this.costoEstado = costoEstado;
    }

    public int getContratistaEstado() {
        return contratistaEstado;
    }

    public void setContratistaEstado(int contratistaEstado) {
        this.contratistaEstado = contratistaEstado;
    }

    
}
