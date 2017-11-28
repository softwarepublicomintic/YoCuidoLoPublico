//
// DO NOT EDIT THIS FILE, IT HAS BEEN GENERATED USING AndroidAnnotations.
//


package co.gov.presidencia.yocuidolopublico.service.client;

import java.util.HashMap;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ServinformacionDTO;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.converter.json.MappingJacksonHttpMessageConverter;
import org.springframework.web.client.RestTemplate;

public class ServinformacionClient_
    implements ServinformacionClient
{

    private RestTemplate restTemplate;
    private String rootUrl;

    public ServinformacionClient_() {
        restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(new MappingJacksonHttpMessageConverter());
        rootUrl = "http://servidorweb2.sitimapa.com:8040/pec/api";
    }

    @Override
    public RestTemplate getRestTemplate() {
        return restTemplate;
    }

    @Override
    public ServinformacionDTO obtenerPosicion(Double lat, Double lng) {
        HashMap<String, Object> urlVariables = new HashMap<String, Object>();
        urlVariables.put("lat", lat);
        urlVariables.put("lng", lng);
        HttpHeaders httpHeaders = new HttpHeaders();
        HttpEntity<Object> requestEntity = new HttpEntity<Object>(httpHeaders);
        return restTemplate.exchange(rootUrl.concat("/geoinverse/latitude/{lat}/longitude/{lng}/process"), HttpMethod.GET, requestEntity, ServinformacionDTO.class, urlVariables).getBody();
    }

}