package co.gov.mintic.graphic.utils;

import java.util.List;

import android.content.Context;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.ViewFlipper;

import co.gov.presidencia.yocuidolopublico.R;
public class GalleryOnTouchListener implements OnTouchListener {

	private float fromPosition;
	private boolean loop;
	private int count;

	private LayoutInflater inflater;

	private List<Integer> items;
	private ViewFlipper gallery;;
	private ImageView indicator;
	private TextView textImage;
	private TextView i;

	private static GalleryOnTouchListener instance;

	public static GalleryOnTouchListener getInstance(List<Integer> items,
			ViewFlipper gallery, ImageView indicator, TextView i, TextView textImage, boolean loop) {

		instance = new GalleryOnTouchListener(items, gallery, indicator, i, textImage, loop);

		return instance;
	}

	private GalleryOnTouchListener(List<Integer> items, ViewFlipper gallery,
			ImageView indicator, TextView i, TextView textImage, boolean loop) {
		this.items = items;
		this.gallery = gallery;
		this.indicator = indicator;
		this.loop = loop;
		this.textImage = textImage;
		this.i = i;

		inflater = (LayoutInflater) gallery.getContext().getSystemService(
				Context.LAYOUT_INFLATER_SERVICE);
		gallery.addView(addImage(items.get(0)));
		updateTextView(gallery);
	}

	@Override
	public boolean onTouch(View v, MotionEvent event) {
		switch (event.getAction()) {
		case MotionEvent.ACTION_DOWN:
			fromPosition = event.getX();
			break;
		case MotionEvent.ACTION_UP:
			float toPosition = event.getX();
			if (fromPosition > toPosition + 20) {
				next(v);
				return true;
			} else if (fromPosition < toPosition - 20) {
				previous(v);
				return true;
			}
		default:
			break;
		}
		return true;
	}

	public void next(View v) {
		if (count >= items.size() - 1 && !loop)
			return;
		else if (count >= items.size() - 1 && loop)
			count = -1;

		count++;
		addNextImage(count, false);
		gallery.setInAnimation(AnimationUtils.loadAnimation(v.getContext(),
				R.anim.go_next_in));
		gallery.setOutAnimation(AnimationUtils.loadAnimation(v.getContext(),
				R.anim.go_next_out));
		gallery.showNext();
		removeImages();
		updateTextView(v);
	}

	public void previous(View v) {
		if (count <= 0 && !loop)
			return;
		else if (count <= 0 && loop)
			count = items.size();

		count--;
		addNextImage(count, true);
		gallery.setInAnimation(AnimationUtils.loadAnimation(v.getContext(),
				R.anim.go_prev_in));
		gallery.setOutAnimation(AnimationUtils.loadAnimation(v.getContext(),
				R.anim.go_prev_out));
		gallery.showNext();
		removeImages();
		updateTextView(v);
	}

	private void addNextImage(int position, boolean isLeft) {
		if (isLeft) {
			if (position >= 0) {
				gallery.addView(addImage(items.get(position)));
			}
		} else {
			if (position < items.size())
				gallery.addView(addImage(items.get(position)));
		}
	}

	@SuppressWarnings("deprecation")
	private View addImage(Integer drawable) {
		ImageView view = (ImageView) inflater.inflate(R.layout.gallery_item,
				null);
		view.setAlpha(125);
		view.setImageBitmap(BitmapFactory.decodeResource(view.getResources(),
				drawable));

		return view;
	}

	private void removeImages() {
		if (gallery.getChildCount() > 2) {
			gallery.removeViewAt(0);
			System.gc();
		}
	}

	private void updateTextView(View v) {
		i.setText((count + 1) + "");
		
		switch (count) {
		case 0:
			indicator.setImageDrawable(v.getResources().getDrawable(R.drawable.indicador1));
			textImage.setText(v.getResources().getString(R.string.texto1));
			break;
		case 1:
			indicator.setImageDrawable(v.getResources().getDrawable(R.drawable.indicador2));
			textImage.setText(v.getResources().getString(R.string.texto2));
			break;
		case 2:
			indicator.setImageDrawable(v.getResources().getDrawable(R.drawable.indicador3));
			textImage.setText(v.getResources().getString(R.string.texto3));
			break;
		case 3:
			indicator.setImageDrawable(v.getResources().getDrawable(R.drawable.indicador4));
			textImage.setText(v.getResources().getString(R.string.texto4));
			break;
		case 4:
			indicator.setImageDrawable(v.getResources().getDrawable(R.drawable.indicador5));
			textImage.setText(v.getResources().getString(R.string.texto5));
			break;
		case 5:
			indicator.setImageDrawable(v.getResources().getDrawable(R.drawable.indicador6));
			textImage.setText(v.getResources().getString(R.string.texto6));
			break;
		}
	}

}
