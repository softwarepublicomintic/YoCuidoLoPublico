package co.gov.presidencia.yocuidolopublico.service.client.interceptor;

import java.io.IOException;
import java.net.URI;
import java.util.Random;

import org.apache.commons.codec.binary.Hex;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRequest;
import org.springframework.http.client.ClientHttpRequestExecution;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.ClientHttpResponse;

import co.gov.presidencia.yocuidolopublico.service.Server;


public class AuthInterceptor implements ClientHttpRequestInterceptor {
	
	private final String RSEPARATOR = ":";
	private final String SEPARATOR = ", ";
	private final String QSEPARATOR = "?";
	private final String QUOTE = "\"";
	private String OPAQUE;
	private String NONCE;
	private String REALM;
	private String CNONCE;
	private String QOP;
	private String NONCE_COUNT = "00000001";
	
	private HttpHeaders headers;
 
	private String username;
	private String password;
	
	
	private static AuthInterceptor instance;
	
	private AuthInterceptor(String username, String password) {
		this.username = username;
		this.password = password;
	}
	
	public static AuthInterceptor getInstance(Server server){
		instance = new AuthInterceptor(server.getUserName(), server.getPassword());
		
		return instance;
	}
 
	@Override
	public ClientHttpResponse intercept(HttpRequest request, byte[] data, ClientHttpRequestExecution execution) throws IOException {		
		headers = request.getHeaders();
		setAuthorizationHeader(request.getMethod().name(), username, password, execution.execute(request, data), request.getURI());
		return execution.execute(request, data);
	}
 
	private void setAuthorizationHeader(String method, String username, String password, ClientHttpResponse firstResponse, URI uri) {
		Random r = new Random();
		byte[] bytes = new byte[16];
		r.nextBytes(bytes);
		
		String fullUri = (uri.getQuery() != null)? uri.getPath().concat(QSEPARATOR + uri.getQuery()) : uri.getPath() ;
		
		CNONCE = new String(Hex.encodeHex(bytes));
		
		OPAQUE = getValue(firstResponse.getHeaders().getFirst("WWW-Authenticate"), "opaque");
		NONCE = getValue(firstResponse.getHeaders().getFirst("WWW-Authenticate"), "nonce");
		REALM = getValue(firstResponse.getHeaders().getFirst("WWW-Authenticate"), "realm");
		QOP = getValue(firstResponse.getHeaders().getFirst("WWW-Authenticate"), "qop");
		
		String ha1 = new String(Hex.encodeHex(DigestUtils.md5(username + ":" + REALM + ":" + password)));				
		String ha2 = new String(Hex.encodeHex(DigestUtils.md5(method + ":" + fullUri)));

		String response = new String(Hex.encodeHex(DigestUtils.md5(ha1 + RSEPARATOR + NONCE + RSEPARATOR + NONCE_COUNT + RSEPARATOR + CNONCE + RSEPARATOR + QOP + RSEPARATOR + ha2)));
		
		String value = "Digest " //
				+ "username=" + QUOTE + username + QUOTE + SEPARATOR //
				+ "realm=" + QUOTE + REALM + QUOTE + SEPARATOR //
				+ "nonce=" + QUOTE + NONCE + QUOTE + SEPARATOR //
				+ "uri=" + QUOTE + fullUri + QUOTE + SEPARATOR //
				+ "response=" + QUOTE + response + QUOTE + SEPARATOR //
				+ "opaque=" + QUOTE + OPAQUE + QUOTE + SEPARATOR //
				+ "qop=" + QOP + SEPARATOR
				+ "nc=" + NONCE_COUNT + SEPARATOR
				+ "cnonce=" + QUOTE + CNONCE+ QUOTE;				
				
		headers.add("Authorization", value);
	}
	
	private String getValue(String header, String which){
		try {
			String bigPath = header.substring(header.indexOf(which));
			int finalPos =  bigPath.indexOf(",");
			
			if (finalPos == -1){finalPos = bigPath.length();}
			
			String res = bigPath.substring(bigPath.indexOf("=")+1, finalPos);
			res = res.replace("\"", "").trim();
			
			return res;
		} catch (Exception e) {
			return "";
		}
	}

}
