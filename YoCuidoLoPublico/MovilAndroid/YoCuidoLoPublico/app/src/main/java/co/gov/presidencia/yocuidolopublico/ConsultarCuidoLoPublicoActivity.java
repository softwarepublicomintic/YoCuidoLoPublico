package co.gov.presidencia.yocuidolopublico;

import com.googlecode.androidannotations.annotations.Click;
import com.googlecode.androidannotations.annotations.EActivity;

import android.app.Activity;
import android.content.Intent;


@EActivity(R.layout.activity_consultar_reportes)
public class ConsultarCuidoLoPublicoActivity extends Activity {

	@Click
	void btnVerEnColombia(){		
		Intent intent = new Intent(getApplicationContext(), CuidoLoPublicoEnColombiaMapaActivity_.class);
		startActivity(intent);
	}
	
	@Click
	void btnVerTopCinco(){
		Intent intent = new Intent(getApplicationContext(), TopCincoReportesActivity_.class);
		startActivity(intent);
	}
}
