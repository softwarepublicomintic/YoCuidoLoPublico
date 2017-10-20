package co.gov.presidencia.yocuidolopublico.listener;

import java.util.HashMap;

import co.gov.presidencia.yocuidolopublico.event.ReporteSeleccionadoEvent;

import com.google.android.gms.maps.GoogleMap.OnInfoWindowClickListener;
import com.google.android.gms.maps.model.Marker;

import de.greenrobot.event.EventBus;

public class ReporteSeleccionadoListener implements OnInfoWindowClickListener {
	private HashMap<String, Long> markers= new HashMap<String, Long>();
	
	public ReporteSeleccionadoListener(HashMap<String, Long> markers) {
		this.markers = markers;
	}
	
	@Override
	public void onInfoWindowClick(Marker marker) {
		EventBus.getDefault().post(new ReporteSeleccionadoEvent(getId(marker)));
	}
	
	private Long getId(Marker marker){		
		return markers.get(marker.getId());		
	}

}
