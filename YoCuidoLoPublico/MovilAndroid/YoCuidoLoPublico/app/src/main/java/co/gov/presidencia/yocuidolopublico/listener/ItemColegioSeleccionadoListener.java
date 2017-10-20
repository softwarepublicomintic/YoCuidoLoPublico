package co.gov.presidencia.yocuidolopublico.listener;

import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import co.gov.presidencia.yocuidolopublico.event.ItemColegioSeleccionadoEvent;
import de.greenrobot.event.EventBus;

public class ItemColegioSeleccionadoListener implements OnItemClickListener {

	@Override
	public void onItemClick(AdapterView<?> arg0, View arg1, int arg2, long arg3) {
		EventBus.getDefault().post(new ItemColegioSeleccionadoEvent(arg2));
	}

}
