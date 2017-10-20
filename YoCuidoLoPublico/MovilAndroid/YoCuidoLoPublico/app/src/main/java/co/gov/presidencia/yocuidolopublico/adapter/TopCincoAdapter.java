package co.gov.presidencia.yocuidolopublico.adapter;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import co.gov.mintic.util.JsonHandler;

import co.gov.presidencia.yocuidolopublico.R;
import co.gov.presidencia.yocuidolopublico.enumeration.Json;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoTop5;

public class TopCincoAdapter extends ArrayAdapter<CuidoLoPublicoTop5> {

	private Context context;
	private int resource;

	public TopCincoAdapter(Context context, int resource,
			CuidoLoPublicoTop5[] objects) {
		super(context, resource, objects);
		this.context = context;
		this.resource = resource;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = convertView;

		if (view == null) {
			LayoutInflater inflater = (LayoutInflater) context
					.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
			view = inflater.inflate(resource, parent, false);
		}

		CuidoLoPublicoTop5 item = getItem(position);
		TextView label = (TextView) view.findViewById(R.id.nombre_reporte);
		TextView votos = (TextView) view.findViewById(R.id.cantidad_manitas_abajo);
		TextView depto = (TextView) view.findViewById(R.id.depto);
		TextView municipio = (TextView) view.findViewById(R.id.municipio);
		ImageView imagenPrincipal = (ImageView) view.findViewById(R.id.imagen_principal);
		
		String dptoText = JsonHandler.getValueById(view.getContext(), Json.DEPARTAMENTOS, item.getDepartamento());		
		String municipioText = JsonHandler.getValueById(view.getContext(), Json.MUNICIPIOS, item.getMunicipio());

		String foto =item.getImagenPrincipal();
		
		byte[] decodedString = Base64.decode(item.getImagenPrincipal(), Base64.DEFAULT);
		Bitmap decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
		
		imagenPrincipal.setImageBitmap(decodedByte);
		label.setText(item.getTitulo());
		votos.setText(item.getRechazos().toString());
		depto.setText(dptoText);
		municipio.setText(municipioText);
		
		return view;
	}

}
