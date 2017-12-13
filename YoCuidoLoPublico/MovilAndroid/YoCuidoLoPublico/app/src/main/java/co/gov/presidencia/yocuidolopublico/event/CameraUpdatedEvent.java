package co.gov.presidencia.yocuidolopublico.event;

import com.google.android.gms.maps.model.LatLng;

public class CameraUpdatedEvent {

	private LatLng newPosition;

	public CameraUpdatedEvent(LatLng newPosition) {
		this.newPosition = newPosition;
	}

	public LatLng getNewPosition() {
		return newPosition;
	}

}
