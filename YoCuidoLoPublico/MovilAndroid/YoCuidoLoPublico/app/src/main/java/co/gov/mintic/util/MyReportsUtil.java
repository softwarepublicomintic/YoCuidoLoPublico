package co.gov.mintic.util;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.content.SharedPreferences;
import co.gov.mintic.util.dto.MyLocalReportDTO;
import co.gov.mintic.util.dto.MyLocalReportListDTO;

import com.google.gson.Gson;

public class MyReportsUtil {
	
	private SharedPreferences mPrefs;
	private static final String FAVORITES = "myElephants";
	private static MyReportsUtil instance;

	public static MyReportsUtil getInstance(Context context){
		if (instance == null){
			instance = new MyReportsUtil(context);
		}
		return instance;
	}
	
	private MyReportsUtil(Context context){
		mPrefs = context.getApplicationContext().getSharedPreferences(PreferencesHandler.SHARED_NAME, 0);
	}
	
	public List<MyLocalReportDTO> getList(){
		String favs= mPrefs.getString(FAVORITES, "");
		
		if (favs.equals(""))
			return new ArrayList<MyLocalReportDTO>();
			
		Gson gson = new Gson();
		MyLocalReportListDTO favoriteList = gson.fromJson(favs, MyLocalReportListDTO.class);
		
		return favoriteList.getFavorites();
	}
	
	public boolean addElephant(MyLocalReportDTO newElephant){
		List<MyLocalReportDTO> favorites = getList();
		
		if (favorites == null){
			favorites = new ArrayList<MyLocalReportDTO>();
		}
		
		for (MyLocalReportDTO favorite: favorites){
			if (favorite.getId().equals(newElephant.getId())) return true;
		}
		
		favorites.add(newElephant);
		
		MyLocalReportListDTO newList = new MyLocalReportListDTO();
		newList.setFavorites(favorites);
		
		commitList(newList);
		
		return true;
	}
	
	public boolean removeElephant(MyLocalReportDTO existing){
		List<MyLocalReportDTO> favorites = getList();
		
		if (favorites == null){
			favorites = new ArrayList<MyLocalReportDTO>();
		}
		
		int index = 0;
		for (MyLocalReportDTO favorite: favorites){
			if (favorite.getId().equals(existing.getId())) {
				break;
			}
			index++;
		}
		
		favorites.remove(index);
		
		MyLocalReportListDTO newList = new MyLocalReportListDTO();
		newList.setFavorites(favorites);
		
		commitList(newList);
		
		return true;
	}
	
	public boolean exists(MyLocalReportDTO element){
		List<MyLocalReportDTO> favorites = getList();
		
		for (MyLocalReportDTO favorite: favorites){
			if (favorite.getId().equals(element.getId())) {
				return true;
			}
		}
		
		return false;
	}
	
	public boolean exists(Long id){
		MyLocalReportDTO dto = new MyLocalReportDTO();
		dto.setId(id);
		
		return exists(dto);
	}
	
	public boolean removeElephant(Long id){
		MyLocalReportDTO dto = new MyLocalReportDTO();
		dto.setId(id);
		
		return removeElephant(dto);
	}
	
	private void commitList(MyLocalReportListDTO newList){
		Gson gson = new Gson();
		SharedPreferences.Editor edit = mPrefs.edit();
		edit.putString(FAVORITES, gson.toJson(newList));
		edit.commit();
	}
	
	public Integer getCurrentQuantity(){
		return getList().size();
	}
	
	public boolean removeOlder(){
		List<MyLocalReportDTO> favorites = getList();
		favorites.remove(0);
		
		MyLocalReportListDTO newList = new MyLocalReportListDTO();
		newList.setFavorites(favorites);
		
		commitList(newList);
		
		return true;
	}
	
}
