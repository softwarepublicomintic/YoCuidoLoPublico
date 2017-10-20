package co.gov.presidencia.yocuidolopublico;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.ResourceAccessException;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;
import co.gov.mintic.util.JsonHandler;
import co.gov.mintic.util.ProgressDialogManager;
import co.gov.mintic.util.dto.StringTextValueDTO;
import co.gov.presidencia.yocuidolopublico.enumeration.Json;
import co.gov.presidencia.yocuidolopublico.service.Server;
import co.gov.presidencia.yocuidolopublico.service.client.CuidoLoPublicoClient;
import co.gov.presidencia.yocuidolopublico.service.client.dto.MunicipioMapaDTO;
import co.gov.presidencia.yocuidolopublico.service.client.interceptor.AuthInterceptor;

import com.googlecode.androidannotations.annotations.AfterViews;
import com.googlecode.androidannotations.annotations.Background;
import com.googlecode.androidannotations.annotations.Bean;
import com.googlecode.androidannotations.annotations.Click;
import com.googlecode.androidannotations.annotations.EActivity;
import com.googlecode.androidannotations.annotations.UiThread;
import com.googlecode.androidannotations.annotations.ViewById;
import com.googlecode.androidannotations.annotations.rest.RestService;

@EActivity(R.layout.activity_reportes_municipio)
public class CuidoLoPublicoEnColombiaSeleccionMunicipioActivity extends Activity {

	public static final String EXTRA_REGION_ID = "RegionId";
	private List<StringTextValueDTO> deptos = new ArrayList<StringTextValueDTO>(), municipios = new ArrayList<StringTextValueDTO>();	
	private MunicipioMapaDTO[] municipiosServicio;
	
	@ViewById
	TextView title;
	
	@RestService
	CuidoLoPublicoClient reportesClient;
	
	@ViewById
	Spinner spinnerDeptos;
	
	@ViewById
	Spinner spinnerMunicipios;
	
	@Bean
	ProgressDialogManager dialog;
	
	@AfterViews
	void init(){
		String idRegion = getIntent().getStringExtra(EXTRA_REGION_ID);		
		String labelRegion = JsonHandler.getValueById(getApplicationContext(), Json.REGIONES, idRegion);
		
		title.setText(title.getText() + " " + labelRegion);
		obtenerDepartamentos(idRegion);
	}
	
	@Click
	void btnVerEnMapa(){
		Double lat =0d;
		Double lng =0d;
		for (MunicipioMapaDTO municipio: municipiosServicio){
			if (municipio.getMunicipio().equals(((StringTextValueDTO)spinnerMunicipios.getSelectedItem()).getId())){
				lat = municipio.getPosicion().getLatitud();
				lng = municipio.getPosicion().getLongitud();
			}			
		}
		if (spinnerMunicipios.getSelectedItemPosition()>0){
			Intent intent = new Intent(getApplicationContext(), MapaMunicipioActivity_.class);
			intent.putExtra(MapaMunicipioActivity.REQUESTED_CODE, ((StringTextValueDTO)spinnerMunicipios.getSelectedItem()).getId());
			intent.putExtra(MapaMunicipioActivity.REQUESTED_LATITUDE, lat);
			intent.putExtra(MapaMunicipioActivity.REQUESTED_LONGITUDE, lng);
					
			startActivity(intent);
		}
	}
	
	@Background
	void obtenerDepartamentos(String idRegion) {
		dialog.show();
		AuthInterceptor interceptor = AuthInterceptor
				.getInstance(Server.SECRETARIA);
		List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
		interceptors.add(interceptor);
		reportesClient.getRestTemplate().setInterceptors(interceptors);

		try {
			reportesClient.getRestTemplate().setRequestFactory(
					new HttpComponentsClientHttpRequestFactory());
			loadLista_deptos(reportesClient.obtenerDepartamentosPorRegion(idRegion));

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
			dialog.dismiss();
		}

	}
	
	@Background
	void obtenerMunicipios(String idDepartamento) {
		dialog.show();
		AuthInterceptor interceptor = AuthInterceptor
				.getInstance(Server.SECRETARIA);
		List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
		interceptors.add(interceptor);
		reportesClient.getRestTemplate().setInterceptors(interceptors);

		try {
			reportesClient.getRestTemplate().setRequestFactory(
					new HttpComponentsClientHttpRequestFactory());
			loadLista_municipios(reportesClient.obtenerMunicipiosPorDepartamento(idDepartamento));

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
			dialog.dismiss();
		}

	}
	
	@UiThread
	void loadLista_deptos(String[] codigos) {
		deptos.clear();
		StringTextValueDTO defaultElement = new StringTextValueDTO();
		defaultElement.setId("0");
		defaultElement.setNombre(getString(R.string.colombia_municipio_depto_hint));
		deptos.add(defaultElement);

		for (String codigo : codigos){
			deptos.add(new StringTextValueDTO(codigo, JsonHandler.getValueById(getApplicationContext(), Json.DEPARTAMENTOS, codigo)));
		}
		
		ArrayAdapter<StringTextValueDTO> dataAdapter = new ArrayAdapter<StringTextValueDTO> (this, R.layout.simple_spinner_item, deptos);

		spinnerDeptos.setAdapter(dataAdapter);
		
		spinnerDeptos.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

			@Override
			public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
				departamentoSeleccionado(position);
			}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) {
				// Nothing to do
			}
		});
	}
	
	void departamentoSeleccionado(int position){
		String id = deptos.get(position).getId();
		obtenerMunicipios(id);		
	}
	
	@UiThread
	void loadLista_municipios(MunicipioMapaDTO[] muniServicio) {
		municipios.clear();
		StringTextValueDTO defaultElement = new StringTextValueDTO();
		defaultElement.setId("0");
		defaultElement.setNombre(getString(R.string.colombia_municipio_municipio_hint));
		municipios.add(defaultElement);

		municipiosServicio = muniServicio;
		
		for (MunicipioMapaDTO municipio : muniServicio){
			municipios.add(new StringTextValueDTO(municipio.getMunicipio(), JsonHandler.getValueById(getApplicationContext(), Json.MUNICIPIOS, municipio.getMunicipio())));
		}
		
		ArrayAdapter<StringTextValueDTO> dataAdapter = new ArrayAdapter<StringTextValueDTO> (this, R.layout.simple_spinner_item, municipios	);

		spinnerMunicipios.setAdapter(dataAdapter);
	}
	
	@UiThread
	void showServerError() {

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
	
}
