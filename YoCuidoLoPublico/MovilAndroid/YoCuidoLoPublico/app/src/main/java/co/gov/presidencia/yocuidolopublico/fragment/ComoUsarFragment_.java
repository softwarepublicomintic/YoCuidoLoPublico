//
// DO NOT EDIT THIS FILE, IT HAS BEEN GENERATED USING AndroidAnnotations.
//


package co.gov.presidencia.yocuidolopublico.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.ViewFlipper;
import co.gov.presidencia.yocuidolopublico.R.layout;

public final class ComoUsarFragment_
    extends ComoUsarFragment
{

    private View contentView_;

    private void init_(Bundle savedInstanceState) {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        init_(savedInstanceState);
        super.onCreate(savedInstanceState);
    }

    private void afterSetContentView_() {
        gallery = ((ViewFlipper) findViewById(co.gov.presidencia.yocuidolopublico.R.id.gallery));
        textImage = ((TextView) findViewById(co.gov.presidencia.yocuidolopublico.R.id.text_image));
        indicator = ((ImageView) findViewById(co.gov.presidencia.yocuidolopublico.R.id.indicator));
        i = ((TextView) findViewById(co.gov.presidencia.yocuidolopublico.R.id.i));
        btnIr = ((Button) findViewById(co.gov.presidencia.yocuidolopublico.R.id.btn_ir));
        {
            View view = findViewById(co.gov.presidencia.yocuidolopublico.R.id.btn_ir);
            if (view!= null) {
                view.setOnClickListener(new OnClickListener() {


                    @Override
                    public void onClick(View view) {
                        ComoUsarFragment_.this.btn_ir();
                    }

                }
                );
            }
        }
        loadAll();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        contentView_ = super.onCreateView(inflater, container, savedInstanceState);
        if (contentView_ == null) {
            contentView_ = inflater.inflate(layout.fragment_comousar, container, false);
        }
        return contentView_;
    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        afterSetContentView_();
    }

    public View findViewById(int id) {
        if (contentView_ == null) {
            return null;
        }
        return contentView_.findViewById(id);
    }

    public static ComoUsarFragment_.FragmentBuilder_ builder() {
        return new ComoUsarFragment_.FragmentBuilder_();
    }

    public static class FragmentBuilder_ {

        private Bundle args_;

        private FragmentBuilder_() {
            args_ = new Bundle();
        }

        public ComoUsarFragment build() {
            ComoUsarFragment_ fragment_ = new ComoUsarFragment_();
            fragment_.setArguments(args_);
            return fragment_;
        }

    }

}
