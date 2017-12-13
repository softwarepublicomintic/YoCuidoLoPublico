package co.gov.presidencia.yocuidolopublico;


import com.googlecode.androidannotations.annotations.EActivity;
import com.googlecode.androidannotations.annotations.ViewById;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.view.ContextMenu;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ImageView;

import com.googlecode.androidannotations.annotations.AfterViews;
import com.googlecode.androidannotations.annotations.Click;
import com.googlecode.androidannotations.annotations.Touch;

import co.gov.presidencia.yocuidolopublico.menu.MenuHandler;
import co.gov.mintic.util.MyReportsUtil;
import co.gov.mintic.util.PreferencesHandler;


@EActivity(R.layout.activity_home)
public class HomeActivity extends Activity {
	
	private MyReportsUtil myElephants;
	private boolean isRegisteredForMenu = false;
	
	PreferencesHandler handler;
	
	@ViewById
	ImageView botonAyuda;

	@AfterViews
	void init(){
		myElephants = MyReportsUtil.getInstance(getApplicationContext());
		handler = PreferencesHandler.getInstance(this);
		
		if (handler.firstUsage()){
			Intent intent = new Intent(getApplicationContext(), ComoUsarActivity_.class);
			startActivity(intent);
		}
	}
	
	@Click
	void btn_reportar(){
		Intent intent = new Intent(getApplicationContext(), MapaActivity_.class);
		startActivity(intent);
	}
	
	@Click
	void btn_consultar_reportes(){
		Intent intent = new Intent(getApplicationContext(), ConsultarCuidoLoPublicoActivity_.class);
		startActivity(intent);
	}
	
	@Click
	void btn_consultar_mis_reportes(){
		
		if (myElephants.getList().size()>0){
			Intent intent = new Intent(getApplicationContext(), MisReportesActivity_.class);
			startActivity(intent);
		} else {
			final AlertDialog.Builder builder = new AlertDialog.Builder(this);
		    builder.setMessage(R.string.home_no_tiene_reportes)
		           .setCancelable(false)
		           .setPositiveButton(R.string.terminar, new DialogInterface.OnClickListener() {
		               public void onClick(final DialogInterface dialog, final int id) {
		            	   dialog.dismiss();
		               }
		           });
		    final AlertDialog alert = builder.create();
		    alert.show();
		}
	}
	
	@Touch
	void botonAyuda(MotionEvent m) {
		int eventPadTouch = m.getAction();
		switch (eventPadTouch) {
		case MotionEvent.ACTION_DOWN: {
			if (!this.isRegisteredForMenu) {
				registerForContextMenu(botonAyuda);
				this.isRegisteredForMenu = true;
			}
			this.openContextMenu(botonAyuda);
		}
		}
	}
	
	@Override
	public void onCreateContextMenu(ContextMenu menu, View v,
			ContextMenuInfo info) {
		menu.setHeaderTitle(R.string.acerca_de);
		
		menu.add(ContextMenu.NONE, R.id.id_guide, ContextMenu.NONE, getString(R.string.como_usar));
		menu.add(ContextMenu.NONE, R.id.id_legal, ContextMenu.NONE, getString(R.string.aviso_legal));
		menu.add(ContextMenu.NONE, R.id.id_about, ContextMenu.NONE, getString(R.string.sobre_esta_aplicacion));
	}
	
	@Override
	public boolean onContextItemSelected(MenuItem item) {
		MenuHandler.onOptionsItemSelected(this, item);
		return true;
	}
}
