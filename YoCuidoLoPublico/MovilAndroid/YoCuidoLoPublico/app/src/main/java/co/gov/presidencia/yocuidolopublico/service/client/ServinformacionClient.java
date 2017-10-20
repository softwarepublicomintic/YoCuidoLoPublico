package co.gov.presidencia.yocuidolopublico.service.client;

import org.springframework.http.converter.json.MappingJacksonHttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import co.gov.presidencia.yocuidolopublico.service.ServiceConstants;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ServinformacionDTO;

import com.googlecode.androidannotations.annotations.rest.Get;
import com.googlecode.androidannotations.annotations.rest.Rest;

@Rest(rootUrl = ServiceConstants.SERVINFORMACION_SERVICES_URL, converters = {MappingJacksonHttpMessageConverter.class})
public interface ServinformacionClient {
	
	@Get("/geoinverse/latitudes/{lat}/longitude/{lng}/process")
	ServinformacionDTO obtenerPosicion(Double lat, Double lng);
	
	RestTemplate getRestTemplate();
}
