package co.gov.presidencia.yocuidolopublico;

import android.app.Activity;
import android.widget.EditText;
import android.widget.TextView;

import com.googlecode.androidannotations.annotations.Click;
import com.googlecode.androidannotations.annotations.EActivity;
import com.googlecode.androidannotations.annotations.ViewById;

@EActivity(R.layout.activity_main)
public class MainActivity extends Activity {

    @ViewById(R.id.myInput)
    EditText myInput;

    @ViewById(R.id.myTextView)
    TextView textView;

    @Click
    void myButton() {
         String name = myInput.getText().toString();
         textView.setText("Hello "+name);
    }
}