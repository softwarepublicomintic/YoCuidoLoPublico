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

import co.gov.presidencia.yocuidolopublico.R;

import java.util.List;

import co.gov.presidencia.yocuidolopublico.enumeration.EstadoReporte;
import co.gov.presidencia.yocuidolopublico.service.client.dto.DetalleBasicoCuidoLoPublicoDTO;

public class MiReporteAdapter extends ArrayAdapter<DetalleBasicoCuidoLoPublicoDTO> {

	private Context context;
	private int resource;

	public MiReporteAdapter(Context context, int resource,
							List<DetalleBasicoCuidoLoPublicoDTO> objects) {
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

		DetalleBasicoCuidoLoPublicoDTO item = getItem(position);
		TextView label = (TextView) view.findViewById(R.id.nombre_reporte);
		TextView votos = (TextView) view.findViewById(R.id.cantidad_manitas_abajo);
		TextView estado = (TextView) view.findViewById(R.id.estado_texto);
		ImageView imagenPrincipal = (ImageView) view.findViewById(R.id.imagen_principal);

		try {
			byte[] decodedString = Base64.decode(item.getImagenPrincipal(), Base64.DEFAULT);
			Bitmap decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);

			for (EstadoReporte estadoEnum: EstadoReporte.values()){
                if (estadoEnum.getId() == item.getEstado()){
                    estado.setText(estadoEnum.getTexto());
                    estado.setCompoundDrawablesWithIntrinsicBounds(0, estadoEnum.getIdImagen(), 0, 0);
                }
            }

			imagenPrincipal.setImageBitmap(decodedByte);
			label.setText(item.getTitulo());
			votos.setText(item.getRechazos().toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return view;
	}

}
