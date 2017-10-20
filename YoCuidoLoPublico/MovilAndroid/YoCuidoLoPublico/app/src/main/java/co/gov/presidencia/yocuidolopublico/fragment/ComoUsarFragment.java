package co.gov.presidencia.yocuidolopublico.fragment;

import java.util.ArrayList;
import java.util.List;

import android.support.v4.app.Fragment;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.ViewFlipper;
import co.gov.mintic.graphic.utils.GalleryOnTouchListener;
import co.gov.mintic.util.PreferencesHandler;
import co.gov.presidencia.yocuidolopublico.R;

import com.googlecode.androidannotations.annotations.AfterViews;
import com.googlecode.androidannotations.annotations.Click;
import com.googlecode.androidannotations.annotations.EFragment;
import com.googlecode.androidannotations.annotations.ViewById;

@EFragment(R.layout.fragment_comousar)
public class ComoUsarFragment extends Fragment {

	@ViewById(R.id.btn_ir)
	Button btnIr;

	PreferencesHandler handler;

	@ViewById(R.id.gallery)
	ViewFlipper gallery;

	@ViewById(R.id.indicator)
	ImageView indicator;
	
	@ViewById(R.id.i)
	TextView i;

	@ViewById(R.id.text_image)
	TextView textImage;
	
	private List<Integer> items;

	@AfterViews
	protected void loadAll() {
		initList();
		
		handler = PreferencesHandler.getInstance(getActivity());
		
		gallery.setOnTouchListener(GalleryOnTouchListener.getInstance(items,
				gallery, indicator, i, textImage, false));
	}

	private void initList() {
		items = new ArrayList<Integer>();
		items.add(R.drawable.sample_0);
		items.add(R.drawable.sample_1);
		items.add(R.drawable.sample_2);
		items.add(R.drawable.sample_3);
		items.add(R.drawable.sample_4);
		items.add(R.drawable.sample_5);
	}

	@Click
	void btn_ir() {
		handler.howToShowed();
		getActivity().finish();
	}
}
