package co.gov.mintic.util;

import android.app.Activity;
import android.app.ProgressDialog;

import co.gov.presidencia.yocuidolopublico.R;
import com.googlecode.androidannotations.annotations.EBean;
import com.googlecode.androidannotations.annotations.RootContext;
import com.googlecode.androidannotations.annotations.UiThread;

@EBean
public class ProgressDialogManager {

	private ProgressDialog dialog;

	@RootContext
	Activity activity;

	@UiThread
	public void show() {
		if (dialog == null || !dialog.isShowing()){			
			dialog = ProgressDialog.show(activity, "", activity.getResources().getString(R.string.loading), true);
			dialog.setCancelable(false);
		}
	}

	@UiThread
	public void dismiss() {
		if (dialog != null && dialog.isShowing())
			dialog.dismiss();
	}

}
