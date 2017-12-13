package co.gov.presidencia.yocuidolopublico.fragment;

import android.support.v4.app.Fragment;
import android.text.Html;
import android.widget.TextView;
import co.gov.presidencia.yocuidolopublico.R;

import com.googlecode.androidannotations.annotations.AfterViews;
import com.googlecode.androidannotations.annotations.EFragment;
import com.googlecode.androidannotations.annotations.ViewById;

@EFragment(R.layout.fragment_acercade)
public class AcercaDeFragment extends Fragment {

	@ViewById
	TextView contenido_acerca_de;
	
	@AfterViews
	void init(){
		contenido_acerca_de.setText(Html.fromHtml(getResources().getString(R.string.acerca_de_contenido)));
	}
}
