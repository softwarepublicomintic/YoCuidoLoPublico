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
import co.gov.mintic.util.MyReportsUtil;
import co.gov.mintic.util.dto.MyLocalReportDTO;
import co.gov.presidencia.yocuidolopublico.adapter.MiReporteAdapter;
import co.gov.presidencia.yocuidolopublico.enumeration.Desde;
import co.gov.presidencia.yocuidolopublico.service.Server;
import co.gov.presidencia.yocuidolopublico.service.client.CuidoLoPublicoClient;
import co.gov.presidencia.yocuidolopublico.service.client.dto.DetalleBasicoCuidoLoPublicoDTO;
import co.gov.presidencia.yocuidolopublico.service.client.interceptor.AuthInterceptor;

import com.googlecode.androidannotations.annotations.Background;
import com.googlecode.androidannotations.annotations.EActivity;
import com.googlecode.androidannotations.annotations.UiThread;
import com.googlecode.androidannotations.annotations.ViewById;
import com.googlecode.androidannotations.annotations.rest.RestService;

@EActivity(R.layout.activity_mis_reportes)
public class MisReportesActivity extends Activity {
	
	private MyReportsUtil myReports;
	private List<DetalleBasicoCuidoLoPublicoDTO> reportes = new ArrayList<DetalleBasicoCuidoLoPublicoDTO>();
	private MiReporteAdapter adapter;
	
	@ViewById
	ListView misReportes;
	
	@RestService
	CuidoLoPublicoClient reportesClient;
	
	@Override
	protected void onResume() {
		
		if (adapter !=  null){
			adapter.clear();
		}
		
		myReports = MyReportsUtil.getInstance(getApplicationContext());
		
		adapter = new MiReporteAdapter(this, R.layout.mi_reporte_item, reportes);
		misReportes.setAdapter(adapter);
					
		obtenerReporte(myReports.getList());
			
		misReportes.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view, int position,
					long id) {
				Log.i("MisReportes", "Reporte seleccionado: " + position);
				irAlDetalle(reportes.get(position).getId());
			}
		});
		
		super.onResume();
	}
			
	private void irAlDetalle(Long idReporte){
		Intent intent = new Intent(this, DetalleActivity_.class);
		intent.putExtra(DetalleActivity.EXTRA_ID, idReporte);
		intent.putExtra(DetalleActivity.EXTRA_FROM_WHERE, Desde.MIS_REPORTES.getId());
		
		startActivity(intent);
	}
	
	@Background
	void obtenerReporte(List<MyLocalReportDTO> misReportes){
		
		for (MyLocalReportDTO report: myReports.getList()){
		
			AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
			List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
			interceptors.add(interceptor);
			reportesClient.getRestTemplate().setInterceptors(interceptors);
			
			try {						
				reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
				mostrarResultado(reportesClient.obtenerMiReporte(report.getId()));
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
		
	}
	
	@UiThread
	void mostrarResultado(DetalleBasicoCuidoLoPublicoDTO reporte){
		reportes.add(reporte);
		adapter.notifyDataSetChanged();
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
