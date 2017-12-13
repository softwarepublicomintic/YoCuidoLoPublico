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
import android.widget.ImageView;
import android.widget.TextView;
import co.gov.mintic.util.ProgressDialogManager;
import co.gov.presidencia.yocuidolopublico.enumeration.Region;
import co.gov.presidencia.yocuidolopublico.service.Server;
import co.gov.presidencia.yocuidolopublico.service.client.CuidoLoPublicoClient;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoPorRegionDTO;
import co.gov.presidencia.yocuidolopublico.service.client.interceptor.AuthInterceptor;

import com.googlecode.androidannotations.annotations.AfterViews;
import com.googlecode.androidannotations.annotations.Background;
import com.googlecode.androidannotations.annotations.Bean;
import com.googlecode.androidannotations.annotations.EActivity;
import com.googlecode.androidannotations.annotations.UiThread;
import com.googlecode.androidannotations.annotations.rest.RestService;

@EActivity(R.layout.activity_reportes_colombia_mapa)
public class CuidoLoPublicoEnColombiaMapaActivity extends Activity {

	@RestService
	CuidoLoPublicoClient reportesClient;

	@Bean
	ProgressDialogManager dialog;
	
	@AfterViews
	void init() {
		obtenerCantidadReportes();
	}

	@Background
	void obtenerCantidadReportes() {
		dialog.show();		
		AuthInterceptor interceptor = AuthInterceptor
				.getInstance(Server.SECRETARIA);
		List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
		interceptors.add(interceptor);
		reportesClient.getRestTemplate().setInterceptors(interceptors);

		try {
			reportesClient.getRestTemplate().setRequestFactory(
					new HttpComponentsClientHttpRequestFactory());
			mostrarResultado(reportesClient.obtenerCuidoLoPublicoPorRegion());

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
	void mostrarResultado(CuidoLoPublicoPorRegionDTO[] response) {

		for (CuidoLoPublicoPorRegionDTO regionConDatos: response){
			for (Region region: Region.values()){
				if (region.getId().equals(regionConDatos.getIdRegion().toString())){
					ImageView fondo = (ImageView) findViewById(region.getBackgroundResourceId());
					ImageView icono = (ImageView) findViewById(region.getIconResourceId());
					TextView texto = (TextView) findViewById(region.getTextViewResourceId());
					
					fondo.setImageDrawable(getResources().getDrawable(region.getEnabledDrawableResourceId()));
					icono.setVisibility(View.VISIBLE);
					
					String textoCantidad = regionConDatos.getCantidad();
					final String idRegion = regionConDatos.getIdRegion()+"";
					
					try {
						Long textoNum =  Long.parseLong(regionConDatos.getCantidad());
						if (textoNum > 99L){
							textoCantidad = "99+";
						}
					} catch (Exception e) {
						// Nothing to do
					}

					icono.setOnClickListener(new View.OnClickListener() {
						
						@Override
						public void onClick(View v) {
							Intent intent = new Intent(getApplicationContext(), CuidoLoPublicoEnColombiaSeleccionMunicipioActivity_.class);
							intent.putExtra(CuidoLoPublicoEnColombiaSeleccionMunicipioActivity.EXTRA_REGION_ID, idRegion);
							startActivity(intent);
						}
					});
					
					texto.setText(textoCantidad);
				}
			}
		}

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
