package co.gov.mintic.util;

import android.content.Context;
import android.content.SharedPreferences;

public class PreferencesHandler {

	private SharedPreferences mPrefs;
	private String FIRST_USE = "first_use";
	private static PreferencesHandler instance;
	public static final String SHARED_NAME = "buscaColegioPrefs";
	
	public static PreferencesHandler getInstance(Context context){
		if (instance == null){
			instance = new PreferencesHandler(context);
		}
		return instance;
	}

	private PreferencesHandler(Context context){
		mPrefs = context.getApplicationContext().getSharedPreferences(SHARED_NAME, 0);
	}

	public boolean firstUsage() {
		return mPrefs.getBoolean(FIRST_USE, true);
	}
	
	public void howToShowed() {
		SharedPreferences.Editor edit = mPrefs.edit();
		edit.putBoolean(FIRST_USE, false);
		edit.commit();
	}

}
