package co.gov.presidencia.yocuidolopublico.fragment;

import android.support.v4.app.Fragment;
import android.text.Html;
import android.widget.TextView;
import co.gov.presidencia.yocuidolopublico.R;

import com.googlecode.androidannotations.annotations.AfterViews;
import com.googlecode.androidannotations.annotations.EFragment;
import com.googlecode.androidannotations.annotations.ViewById;

@EFragment(R.layout.fragment_avisolegal)
public class AvisoLegalFragment extends Fragment {
	
	@ViewById
	TextView contenido_aviso_legal;
	
	@AfterViews
	void init(){
		contenido_aviso_legal.setText(Html.fromHtml(getResources().getString(R.string.aviso_legal_contenido)));
	}
}
