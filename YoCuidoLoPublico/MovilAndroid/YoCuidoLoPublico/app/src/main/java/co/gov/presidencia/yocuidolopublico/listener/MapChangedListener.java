package co.gov.presidencia.yocuidolopublico.listener;

import co.gov.presidencia.yocuidolopublico.event.CameraUpdatedEvent;

import com.google.android.gms.maps.GoogleMap.OnCameraChangeListener;
import com.google.android.gms.maps.model.CameraPosition;

import de.greenrobot.event.EventBus;

public class MapChangedListener implements OnCameraChangeListener {

	@Override
	public void onCameraChange(CameraPosition position) {
		CameraUpdatedEvent event = new CameraUpdatedEvent(position.target);
		
		EventBus.getDefault().post(event);
		
	}

}
