package co.gov.presidencia.yocuidolopublico.service.client;

import org.springframework.http.converter.json.MappingJacksonHttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import co.gov.presidencia.yocuidolopublico.service.client.dto.ActualizarReporteDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.AsociarImagenDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.DetalleBasicoCuidoLoPublicoDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.DetalleCuidoLoPublicoDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoMapaDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoMapaMunicipioDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoTop5;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoPorRegionDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoReportadoDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ElementoListaDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ImagenDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.MunicipioMapaDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ReportarCuidoLoPublicoDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.VotoRegistradoDTO;

import com.googlecode.androidannotations.annotations.rest.Get;
import com.googlecode.androidannotations.annotations.rest.Post;
import com.googlecode.androidannotations.annotations.rest.Put;
import com.googlecode.androidannotations.annotations.rest.Rest;

@Rest(rootUrl = "http://104.197.123.208:80/cuidolopublico/Servicios", converters = {MappingJacksonHttpMessageConverter.class})
public interface CuidoLoPublicoClient {
	
	@Get("/Consultar/CuidoLoPublicoPorPosicion?latitud={lat}&longitud={lng}")//test
	CuidoLoPublicoMapaDTO[] obtenerPorPosicion(Double lat, Double lng);
	
	@Get("/Consultar/CuidoLoPublicoMasVotados")
	CuidoLoPublicoTop5[] obtenerMasVotados();
	
	@Get("/Consultar/DetalleBasicoCuidoLoPublico/{id}")//test
	DetalleBasicoCuidoLoPublicoDTO obtenerMiReporte(Long id);
	
	@Get("/Consultar/DetalleCuidoLoPublico/{id}")//test
	DetalleCuidoLoPublicoDTO obtenerDetalle(Long id);
	
	@Get("/Consultar/RangosDeTiempo")
	ElementoListaDTO[] consultarRangos();
	
	@Get("/Consultar/MotivosCuidoLoPublico")
	ElementoListaDTO[] consultarMotivos();
	
	@Get("/Consultar/ImagenCuidoLoPublico/{id}")//test
	ImagenDTO obtenerImagen(Long id);

	@Post("YoCuidoLoPublico/Reportar")
	CuidoLoPublicoReportadoDTO reportar(ReportarCuidoLoPublicoDTO reporte);
	
	@Put("/Actualizar/ModificarReporte/{idReporte}")
	void actualizarReporte(Long idReporte, ActualizarReporteDTO actualizacion);
	
	@Get("/Consultar/CuidoLoPublicoPorRegion")
	CuidoLoPublicoPorRegionDTO[] obtenerCuidoLoPublicoPorRegion();
	
	@Get("/Consultar/DepartamentosPorRegion/{idRegion}")
	String[] obtenerDepartamentosPorRegion(String idRegion);
	
	@Get("/Consultar/MunicipiosPorDepartamento/{idMunicipio}")
	MunicipioMapaDTO[] obtenerMunicipiosPorDepartamento(String idMunicipio);
	
	@Get("/Actualizar/RegistrarVoto/{idReporte}")
	VotoRegistradoDTO registrarVoto(Long idReporte);
	
	@Post("/Actualizar/AsociarImagen/")
	void asociarImagen(AsociarImagenDTO imagen);
	
	@Get("/Consultar/CuidoLoPublicoPorMunicipio/{idMunicipio}")
	CuidoLoPublicoMapaMunicipioDTO[] obtenerPorMunicipio(String idMunicipio);
	
	RestTemplate getRestTemplate();
}
