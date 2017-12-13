package co.gov.mintic.util;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.content.SharedPreferences;
import co.gov.mintic.util.dto.ReportesRechazadosDTO;

import com.google.gson.Gson;

public class ReportesRechazadosUtil {

	private SharedPreferences mPrefs;
	private static final String RECHAZADOS = "rechazados";
	private static ReportesRechazadosUtil instance;
	private List<Long> lista = new ArrayList<Long>();
	
	private ReportesRechazadosUtil(Context context){
		mPrefs = context.getApplicationContext().getSharedPreferences(PreferencesHandler.SHARED_NAME, 0);
		lista = getList();
	}	
	
	public static ReportesRechazadosUtil getInstance(Context context){
		if (instance == null){
			instance = new ReportesRechazadosUtil(context);
		}
		return instance;
	}
	
	public void rechazar(Long id){
		if (!exists(id)){
			lista.add(id);
			commitList();
		}
	}
	
	
	private List<Long> getList(){
		String favs= mPrefs.getString(RECHAZADOS, "");
		
		if (favs.equals(""))
			return new ArrayList<Long>();
			
		Gson gson = new Gson();
		ReportesRechazadosDTO rechazados = gson.fromJson(favs, ReportesRechazadosDTO.class);
		
		return rechazados.getRechazados();
	}
	
	public boolean exists(Long id){
		
		for (Long rechazado: lista){
			if (rechazado.longValue() == id.longValue()) {
				return true;
			}
		}
		
		return false;
	}
	
	private void commitList(){
		
		ReportesRechazadosDTO dto = new ReportesRechazadosDTO();
		dto.setRechazados(lista);
		
		Gson gson = new Gson();
		SharedPreferences.Editor edit = mPrefs.edit();
		edit.putString(RECHAZADOS, gson.toJson(dto));
		edit.commit();
	}
}
