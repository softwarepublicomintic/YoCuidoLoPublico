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
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import co.gov.mintic.util.ProgressDialogManager;
import co.gov.presidencia.yocuidolopublico.adapter.TopCincoAdapter;
import co.gov.presidencia.yocuidolopublico.enumeration.Desde;
import co.gov.presidencia.yocuidolopublico.service.Server;
import co.gov.presidencia.yocuidolopublico.service.client.CuidoLoPublicoClient;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoTop5;
import co.gov.presidencia.yocuidolopublico.service.client.interceptor.AuthInterceptor;

import com.googlecode.androidannotations.annotations.Background;
import com.googlecode.androidannotations.annotations.Bean;
import com.googlecode.androidannotations.annotations.EActivity;
import com.googlecode.androidannotations.annotations.UiThread;
import com.googlecode.androidannotations.annotations.ViewById;
import com.googlecode.androidannotations.annotations.rest.RestService;

@EActivity(R.layout.activity_top_cinco_reportes)
public class TopCincoReportesActivity extends Activity {
	
	@ViewById
	ListView topCinco;
	
	@RestService
	CuidoLoPublicoClient reportesClient;
	
	@Bean
	ProgressDialogManager dialog;
	
	@Override
	protected void onResume() {
		obtenerReportes();
		super.onResume();
	}
	
	private CuidoLoPublicoTop5[] topCintoReportes;
	
	@Background
	void obtenerReportes(){
		dialog.show();
		AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
		List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
		interceptors.add(interceptor);
		reportesClient.getRestTemplate().setInterceptors(interceptors);
		
		try {						
			reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
			mostrarResultado(reportesClient.obtenerMasVotados());
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
	void mostrarResultado(CuidoLoPublicoTop5[] reportes){
		TopCincoAdapter adapter = new TopCincoAdapter(this, R.layout.top_cinco_item, reportes);
		topCinco.setAdapter(adapter);
		
		topCintoReportes = reportes;
		
		topCinco.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view, int position,
					long id) {
				Log.i("MisReporte", "Reporte seleccionado: " + position);
				irAlDetalle(topCintoReportes[position].getId());
			}
		});
	}
	
	private void irAlDetalle(Long idReporte){
		Intent intent = new Intent(this, DetalleActivity_.class);
		intent.putExtra(DetalleActivity.EXTRA_ID, idReporte);
		intent.putExtra(DetalleActivity.EXTRA_FROM_WHERE, Desde.TOP_CINCO.getId());
		
		startActivity(intent);
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
