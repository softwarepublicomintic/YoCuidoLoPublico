package co.gov.presidencia.yocuidolopublico.menu;

import android.app.Activity;
import android.content.Intent;
import android.view.MenuItem;
import co.gov.presidencia.yocuidolopublico.AcercaDeActivity_;
import co.gov.presidencia.yocuidolopublico.AvisoLegalActivity_;
import co.gov.presidencia.yocuidolopublico.ComoUsarActivity_;

import co.gov.presidencia.yocuidolopublico.R;

public class MenuHandler {
	public static boolean onOptionsItemSelected(Activity activity, MenuItem item) {
		Intent intent;
		switch (item.getItemId()) {
		case R.id.id_guide:	        	
			intent = new Intent(activity, ComoUsarActivity_.class);
		    activity.startActivity(intent);
		    break;
        case R.id.id_about:
        	intent = new Intent(activity, AcercaDeActivity_.class);
		    activity.startActivity(intent);
		    break;
        case R.id.id_legal:
        	intent = new Intent(activity, AvisoLegalActivity_.class);
		    activity.startActivity(intent);
		    break;
        default:
            return activity.onOptionsItemSelected(item);
		}
		return true;
	}
}
