package co.gov.presidencia.yocuidolopublico;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.provider.MediaStore;
import android.util.Base64;
import android.util.Log;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
import com.google.android.gms.maps.model.LatLng;
import com.googlecode.androidannotations.annotations.AfterViews;
import com.googlecode.androidannotations.annotations.Background;
import com.googlecode.androidannotations.annotations.Bean;
import com.googlecode.androidannotations.annotations.Click;
import com.googlecode.androidannotations.annotations.EActivity;
import com.googlecode.androidannotations.annotations.UiThread;
import com.googlecode.androidannotations.annotations.ViewById;
import com.googlecode.androidannotations.annotations.rest.RestService;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.ResourceAccessException;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import co.gov.mintic.util.JsonHandler;
import co.gov.mintic.util.ProgressDialogManager;
import co.gov.mintic.util.dto.TextValueDTO;
import co.gov.presidencia.yocuidolopublico.enumeration.Json;
import co.gov.presidencia.yocuidolopublico.service.Server;
import co.gov.presidencia.yocuidolopublico.service.client.CuidoLoPublicoClient;
import co.gov.presidencia.yocuidolopublico.service.client.ServinformacionClient;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoReportadoDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ElementoListaDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.PosicionDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ReportarCuidoLoPublicoDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ServinformacionDTO;
import co.gov.presidencia.yocuidolopublico.service.client.interceptor.AuthInterceptor;

@EActivity(R.layout.activity_reportar)
public class ReportarActivity extends Activity {

	private List<TextValueDTO> razones = new ArrayList<TextValueDTO>(), rangos = new ArrayList<TextValueDTO>();	
	public static final String LAT="lat";
	public static final String LNG="lng";
	public static final String IMG="img";
	
	public static final String RETURN_ID="elephantId";
	public static final String RETURN_NAME="elephantName";
	
	private static final Integer CAMERA_INTENT=1111;
	
	private LatLng position;
	private String deptoCode="11";
	private String muniCode="11001";
	private String direccion;
	
	@Bean
	ProgressDialogManager dialog;
	
	@ViewById(R.id.titulo)
	EditText titulo;
	
	@ViewById(R.id.posible_entidad)
	EditText posibleEntidad;
	
	@ViewById(R.id.contratista)
	EditText contratista;
	
	@ViewById(R.id.costo)
	EditText costo;
	
	@ViewById(R.id.spinnerPorQue)
	Spinner spinnerRazon;
	
	@ViewById(R.id.spinnerTiempo)
	Spinner spinnerTiempo;
	
	@ViewById(R.id.deptoMunicipio)
	TextView deptoMunicipio;
	
	@RestService
	ServinformacionClient serviClient;	
	
	@RestService
	CuidoLoPublicoClient reportesClient;
	
	@AfterViews
	void init(){
		Intent photoIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
		startActivityForResult(photoIntent, CAMERA_INTENT);
		
		
		obtenerMotivos();
		loadDivipola();
	}
	
	@Click
	void btnReportar(){		
		if (titulo.getText().toString().isEmpty() || posibleEntidad.getText().toString().isEmpty() || spinnerRazon.getSelectedItemPosition() == 0){
			buildAlert(R.string.diligenciar_todos);
		} else {
			if (titulo.getText().toString().length() > 80){
				buildAlert(R.string.tamanio_maximo_titulo);
			} else if (posibleEntidad.getText().toString().length() > 80){			
				buildAlert(R.string.tamanio_maximo_entidad);
			} else if (!costo.getText().toString().isEmpty() && costo.getText().toString().length() > 18){			
				buildAlert(R.string.tamanio_maximo_costo);
			} else if (!contratista.getText().toString().isEmpty() && contratista.getText().toString().length() > 80){			
				buildAlert(R.string.tamanio_maximo_contratista);
			} else {
				buildAlertSuccess();
			}
		}
	}
	
	private void buildAlert(int resId) {
	    final AlertDialog.Builder builder = new AlertDialog.Builder(this);
	    builder.setMessage(resId)
	           .setCancelable(false)
	           .setPositiveButton(R.string.ok, new DialogInterface.OnClickListener() {
	               public void onClick(final DialogInterface dialog, final int id) {
	            	   dialog.cancel();	            	   
	               }
	           });
	    final AlertDialog alert = builder.create();
	    alert.show();
	}
	
	void loadDivipola(){
		position = new LatLng(getIntent().getExtras().getDouble(LAT), getIntent().getExtras().getDouble(LNG));
		obtenerPosicion();
	}
	
	@Background
	void obtenerPosicion(){
		
		AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SERVINFORMACION);
		List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
		interceptors.add(interceptor);
		serviClient.getRestTemplate().setInterceptors(interceptors);
		
		try {						
			serviClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
			ServinformacionDTO resultado=serviClient.obtenerPosicion(position.latitude, position.longitude);
			mostrarResultado(resultado);
		} catch (HttpServerErrorException e) {
			e.printStackTrace();
//			showServerError();
		} catch (HttpClientErrorException e) {
			e.printStackTrace();
//			if (e.getStatusCode().ordinal() != 24)
//				showServerError();
		} catch (ResourceAccessException e) {
			e.printStackTrace();
//			showConnectionError();
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}
	
	@Background
	void obtenerMotivos(){
		
		AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
		List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
		interceptors.add(interceptor);
		reportesClient.getRestTemplate().setInterceptors(interceptors);
		
		try {						
			reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
			loadLista_motivos(reportesClient.consultarMotivos());
			
		} catch (HttpServerErrorException e) {
			e.printStackTrace();
			showServerError();
		} catch (HttpClientErrorException e) {
			e.printStackTrace();
			if (e.getStatusCode().ordinal() != 24) 
				showServerError();
		} catch (ResourceAccessException e) {
			e.printStackTrace();
			showConnectionError();
		}
		
	}
	
	@Background
	void obtenerRangos(){
		
		AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
		List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
		interceptors.add(interceptor);
		reportesClient.getRestTemplate().setInterceptors(interceptors);
		
		try {						
			reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
			loadLista_rangos(reportesClient.consultarRangos());
			
		} catch (HttpServerErrorException e) {
			e.printStackTrace();
			showServerError();
		} catch (HttpClientErrorException e) {
			e.printStackTrace();
			if (e.getStatusCode().ordinal() != 24) 
				showServerError();
		} catch (ResourceAccessException e) {
			e.printStackTrace();
			showConnectionError();
		}
		
	}
	
	@UiThread
	void loadLista_motivos(ElementoListaDTO[] motivosLista) {
		razones.clear();
		TextValueDTO defaultElement = new TextValueDTO();
		defaultElement.setId(0l);
		defaultElement.setNombre(getString(R.string.campo_por_que));
		razones.add(defaultElement);

		for (ElementoListaDTO elemento : motivosLista){
			razones.add(new TextValueDTO(elemento.getId(), elemento.getTexto()));
		}
		
		ArrayAdapter<TextValueDTO> dataAdapter = new ArrayAdapter<TextValueDTO> (this, R.layout.simple_spinner_item, razones);

		spinnerRazon.setAdapter(dataAdapter);
		
		obtenerRangos();
	}
	
	@UiThread
	void loadLista_rangos(ElementoListaDTO[] rangosLista) {
		rangos.clear();
		TextValueDTO defaultElement = new TextValueDTO();
		defaultElement.setId(0l);
		defaultElement.setNombre(getString(R.string.campo_tiempo_existencia));
		rangos.add(defaultElement);

		for (ElementoListaDTO elemento : rangosLista){
			rangos.add(new TextValueDTO(elemento.getId(), elemento.getTexto()));
		}
		
		ArrayAdapter<TextValueDTO> dataAdapter = new ArrayAdapter<TextValueDTO> (this, R.layout.simple_spinner_item, rangos);

		spinnerTiempo.setAdapter(dataAdapter);
	}
	
	private void buildAlertSuccess() {
	    final AlertDialog.Builder builder = new AlertDialog.Builder(this);
	    builder.setMessage(R.string.reporte_exitoso)
	           .setCancelable(false)
	           .setPositiveButton(R.string.terminar, new DialogInterface.OnClickListener() {
	               public void onClick(final DialogInterface dialog, final int id) {
	            	   
	            	   dialog.cancel();	            	   
	            	   	  
	            	   PosicionDTO posicion = new PosicionDTO(position.latitude, position.longitude);
	            	   
	            	   ReportarCuidoLoPublicoDTO nuevoReporte = new ReportarCuidoLoPublicoDTO();
	            	   
	            	   if (!contratista.getText().toString().isEmpty())	
	            		   nuevoReporte.setContratista(contratista.getText().toString());
	            	   if (!costo.getText().toString().isEmpty())	            	   
	            		   nuevoReporte.setCosto(Long.parseLong(costo.getText().toString()));
	            	   if (((TextValueDTO) spinnerTiempo.getSelectedItem()).getId() != 0l)
	            		   nuevoReporte.setIdRangoTiempo(((TextValueDTO) spinnerTiempo.getSelectedItem()).getId());
	            	   
	            	   nuevoReporte.setDireccion(direccion);
	            	   nuevoReporte.setEntidad(posibleEntidad.getText().toString());
	            	   nuevoReporte.setIdDepartamento(deptoCode);
	            	   nuevoReporte.setIdMotivo(((TextValueDTO) spinnerRazon.getSelectedItem()).getId());
	            	   nuevoReporte.setIdMunicipio(muniCode);
	            	   nuevoReporte.setImagen(image);
	            	   nuevoReporte.setPosicion(posicion);
	            	   nuevoReporte.setTitulo(titulo.getText().toString());
	            	   
	            	   reportar(nuevoReporte);
	               }
	           });
	    final AlertDialog alert = builder.create();
	    alert.show();
	}
	
	@Background
	void reportar(ReportarCuidoLoPublicoDTO reporte){
		dialog.show();

		try {
			reportarRequest(reporte);

		} catch (HttpServerErrorException e) {
			e.printStackTrace();
			showServerError();
		} catch (HttpClientErrorException e) {
			e.printStackTrace();
			if (e.getStatusCode().ordinal() != 24)
				showServerError();
		} catch (ResourceAccessException e) {
			e.printStackTrace();
			showConnectionError();
		} finally {
			//dialog.dismiss();
		}
		
	}


	public CuidoLoPublicoReportadoDTO reportarRequest(ReportarCuidoLoPublicoDTO reporte) {
		final CuidoLoPublicoReportadoDTO resultado = new CuidoLoPublicoReportadoDTO();
		JSONObject params = new JSONObject();
		JSONObject paramsPos = new JSONObject();
		try {
			params.put("contratista",reporte.getContratista());
			params.put("costo",reporte.getCosto());
			params.put("direccion",reporte.getDireccion());
			params.put("entidad",reporte.getEntidad());
			params.put("idDepartamento",reporte.getIdDepartamento());
			params.put("idMotivo",reporte.getIdMotivo());
			params.put("idMunicipio",reporte.getIdMunicipio());
			params.put("idRangoTiempo",reporte.getIdRangoTiempo());
			params.put("imagen",reporte.getImagen());

			paramsPos.put("latitud",reporte.getPosicion().getLatitud());
			paramsPos.put("longitud",reporte.getPosicion().getLongitud());
			params.put("posicion",paramsPos);

			params.put("titulo",reporte.getTitulo());

		} catch (JSONException e) {
			e.printStackTrace();
		}

		RequestQueue requestQueue = Volley.newRequestQueue(this);
		JsonObjectRequest postRequest = new JsonObjectRequest(Request.Method.POST, "http://104.197.123.208:80/cuidolopublico/Servicios/YoCuidoLoPublico/Reportar",params,
				new Response.Listener<JSONObject>() {
					@Override
					public void onResponse(JSONObject response) {
						try {
							resultado.setId(response.getLong("id"));
						} catch (JSONException e) {
							e.printStackTrace();
						}
						Log.i("response", response.toString());

						String title = titulo.getText().toString();
						Intent i = new Intent();

						i.putExtra(RETURN_NAME, title);
						i.putExtra(RETURN_ID, resultado.getId());
						setResult(RESULT_OK, i);

						finish();
						dialog.dismiss();

					}

				},new Response.ErrorListener() {
			@Override
			public void onErrorResponse(VolleyError error) {
				showServerError();
				Log.i("response", error.toString());
			}
		}
		){

			@Override
			public Map<String, String> getHeaders() throws AuthFailureError {
				Map<String, String> headers = new HashMap<String, String>();
				headers.put("Content-Type", "application/json");
				return headers;
			}


		};
		requestQueue.add(postRequest);

		return resultado;
	}

	
	@UiThread
	void mostrarResultado(CuidoLoPublicoReportadoDTO resultado){
		
		String title = titulo.getText().toString();
 	   	Intent i = new Intent();	            	
 	   
 	   	i.putExtra(RETURN_NAME, title);
 	   	i.putExtra(RETURN_ID, resultado.getId());
 	   	setResult(RESULT_OK, i);
 	   
 	   	finish();
	}

	@Background
	void mostrarResultado(ServinformacionDTO response){
		
		String rtaServinformacion = response.getObject().getCode();
		deptoCode = rtaServinformacion.substring(0, 2);
		muniCode = rtaServinformacion.substring(0, 5);
		direccion = response.getObject().getAddress();
		
		String dptoText = JsonHandler.getValueById(this, Json.DEPARTAMENTOS, deptoCode);		
		String municipioText = JsonHandler.getValueById(this, Json.MUNICIPIOS, muniCode);
		
		deptoMunicipio.setText(dptoText + " / " + municipioText);
	}
	
	@UiThread
	void showServerError() {

		dialog.dismiss();
		new AlertDialog.Builder(this)
				.setMessage(R.string.server_error_message)
				.setTitle(R.string.server_error_title)
				.setPositiveButton(R.string.ok,
						new DialogInterface.OnClickListener() {

							@Override
							public void onClick(DialogInterface dialog,
									int which) {
								dialog.dismiss();
							}
						}).create().show();

	}
	
	@UiThread
	void showConnectionError() {
		new AlertDialog.Builder(this)
				.setMessage(R.string.conection_error_message)
				.setTitle(R.string.conection_error_title)
				.setPositiveButton(R.string.ok,
						new DialogInterface.OnClickListener() {

							@Override
							public void onClick(DialogInterface dialog,
									int which) {
								dialog.dismiss();
							}
						}).create().show();

	}
	
	String image;
	
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		System.gc();
		if (requestCode == CAMERA_INTENT) {
			if (resultCode == Activity.RESULT_OK) {
				
				if(data.hasExtra("data")){
					Bitmap bitmapT = (Bitmap) data.getParcelableExtra("data");
					
					int w=680, h = 380;
					
					if (bitmapT.getWidth() < bitmapT.getHeight()){
						h = 680;
						w = 380;
					}
					
					Bitmap bitmap = Bitmap.createScaledBitmap(bitmapT, w, h, false);
	                
					Log.i("TAG", "Imagen redimensionada");
	                ByteArrayOutputStream baos = new ByteArrayOutputStream();
	                bitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
	                byte[] imgBytes = baos.toByteArray();
	                
					image = Base64.encodeToString(imgBytes, Base64.DEFAULT);

				}
				
				
			} else {
				finish();
			}
		}
	}
	
	/*@TextChange(R.id.costo)
	void method(TextView myCostoTV, CharSequence text){
		Log.i("ReportarActivity.java", "Text: [" + text + "]");
		NumberFormat baseFormat = NumberFormat.getCurrencyInstance(Locale.US);
		String moneyString = baseFormat.format(text.toString());
		
		myCostoTV.setText(moneyString);
	}*/
	
}
