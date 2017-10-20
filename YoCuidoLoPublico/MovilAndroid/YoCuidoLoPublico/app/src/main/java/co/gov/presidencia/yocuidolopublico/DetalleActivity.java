package co.gov.presidencia.yocuidolopublico;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.ResourceAccessException;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.location.Location;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.text.Editable;
import android.util.Base64;
import android.util.Log;
import android.view.Display;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;

import co.gov.mintic.util.ReportesRechazadosUtil;
import co.gov.mintic.util.JsonHandler;
import co.gov.mintic.util.MyReportsUtil;
import co.gov.mintic.util.ProgressDialogManager;
import co.gov.mintic.util.dto.MyLocalReportDTO;
import co.gov.mintic.util.dto.TextValueDTO;
import co.gov.presidencia.yocuidolopublico.enumeration.Desde;
import co.gov.presidencia.yocuidolopublico.enumeration.EstadoCampo;
import co.gov.presidencia.yocuidolopublico.enumeration.EstadoReporte;
import co.gov.presidencia.yocuidolopublico.enumeration.Json;
import co.gov.presidencia.yocuidolopublico.service.Server;
import co.gov.presidencia.yocuidolopublico.service.client.CuidoLoPublicoClient;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ActualizarReporteDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.AsociarImagenDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoMapaMunicipioDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.DetalleCuidoLoPublicoDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ElementoListaDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.ImagenDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.MiniaturaDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.PosicionDTO;
import co.gov.presidencia.yocuidolopublico.service.client.dto.VotoRegistradoDTO;
import co.gov.presidencia.yocuidolopublico.service.client.interceptor.AuthInterceptor;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesClient;
import com.google.android.gms.location.LocationClient;
import com.googlecode.androidannotations.annotations.AfterTextChange;
import com.googlecode.androidannotations.annotations.AfterViews;
import com.googlecode.androidannotations.annotations.Background;
import com.googlecode.androidannotations.annotations.Bean;
import com.googlecode.androidannotations.annotations.Click;
import com.googlecode.androidannotations.annotations.EActivity;
import com.googlecode.androidannotations.annotations.UiThread;
import com.googlecode.androidannotations.annotations.ViewById;
import com.googlecode.androidannotations.annotations.rest.RestService;

@EActivity(R.layout.activity_detalle)
public class DetalleActivity extends Activity implements
        GooglePlayServicesClient.ConnectionCallbacks,
        GooglePlayServicesClient.OnConnectionFailedListener {

    private LocationClient mLocationClient;

    private DetalleCuidoLoPublicoDTO detalleReporte = new DetalleCuidoLoPublicoDTO();
    public static final String EXTRA_ID = "ID_EXTRA";
    public static final String EXTRA_FROM_WHERE = "WHERE_EXTRA";
    private static final String TEMP_PHOTO_FILE = "temporary_holder.jpg";

    private List<TextValueDTO> rangos = new ArrayList<TextValueDTO>();

    private static final Integer CAMERA_INTENT = 1111;
    private static final Integer MAX_PHOTOS = 10;

    ReportesRechazadosUtil eru;

    private Desde desdeDondeViene = null;
    private boolean allLoaded = false;
    private boolean estaPendiente = false;
    private boolean estaRechazado = false;

    @ViewById(R.id.detalle_title)
    EditText tituloEdit;

    @ViewById(R.id.detalle_title_txt)
    TextView titulo;

    @ViewById(R.id.myGallery)
    LinearLayout gallery;

    @ViewById(R.id.detalle_deptoMunicipio)
    TextView deptoMunicipio;

    @ViewById(R.id.detalle_fecha_reporte)
    TextView fechaReporte;

    @ViewById(R.id.entidad)
    EditText entidadEdit;

    @ViewById(R.id.detalle_entidad_txt)
    TextView entidad;

    @ViewById(R.id.detalle_tiempo_txt)
    TextView tiempo;

    @ViewById(R.id.detalle_costo_txt)
    TextView costo;

    @ViewById(R.id.detalle_contratista_txt)
    TextView contratista;

    @ViewById(R.id.detalle_notificacion_txt)
    TextView notificacion;

    @ViewById(R.id.detalle_cantidad_rechazos)
    TextView cantidad_rechazos;

    @ViewById(R.id.detalle_cantidad_fotos)
    TextView cantidad_fotos;

    @ViewById(R.id.detalle_estado_texto)
    TextView detalle_estado_texto;

    @ViewById(R.id.btnRechazar)
    Button btnRechazar;

    @ViewById(R.id.btnAgregarFoto)
    Button btnAgregarFoto;

    @ViewById(R.id.costo)
    EditText costoEdit;

    @ViewById(R.id.spinnerTiempo)
    Spinner spinnerTiempo;

    @ViewById(R.id.detalle_razon_txt)
    TextView razon;

    @ViewById(R.id.contratista)
    EditText contratistaEdit;

    @ViewById(R.id.panelBotonActualizar)
    LinearLayout panelBotonActualizar;

    @ViewById(R.id.panelNotificacion)
    LinearLayout panelNotificacion;

    @ViewById(R.id.detalle_razon_spinner)
    Spinner spinnerRazon;

    @ViewById(R.id.txtTituloReporte)
    TextView txtTitulo;

    @RestService
    CuidoLoPublicoClient reportesClient;

    @Bean
    ProgressDialogManager dialog;

    private Long idRangoInicial, idMotivoInicial, costoInicial;
    private String contratistaInicial, tituloInicial, entidadInicial;

    @AfterViews
    void init() {
        int i = getIntent().getExtras().getInt(EXTRA_FROM_WHERE);

        mLocationClient = new LocationClient(this, this, this);
        mLocationClient.connect();

        for (Desde desde : Desde.values()) {
            if (desde.getId() == i) {
                desdeDondeViene = desde;
            }
        }

        eru = ReportesRechazadosUtil.getInstance(this);

        obtenerReporte(getIntent().getExtras().getLong(EXTRA_ID));

    }

    @Click
    void btnRechazar() {
        registrarVoto(getIntent().getExtras().getLong(EXTRA_ID));
    }

    @Click
    void btnAgregarFoto() {

        float[] results = new float[1];
        Location location = mLocationClient.getLastLocation();

        Location.distanceBetween(location.getLatitude(), location.getLongitude(), posicion.getLatitud(), posicion.getLongitud(), results);

        if (results != null && results.length > 0 && results[0] < 501f) {

            Intent photoIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
            startActivityForResult(photoIntent, CAMERA_INTENT);

        } else {
            new AlertDialog.Builder(this)
                    .setMessage(R.string.distancia_maxima_excedida)
                    .setPositiveButton(R.string.ok,
                            new DialogInterface.OnClickListener() {

                                @Override
                                public void onClick(DialogInterface dialog,
                                                    int which) {
                                    dialog.dismiss();
                                }
                            }).create().show();
        }
    }

    void configurarInterfaz() {
        btnRechazar.setVisibility(View.GONE);
        boolean rechazado = false;

        if (eru.exists(getIntent().getExtras().getLong(EXTRA_ID))) {
            rechazado = true;
        }

        if (!estaPendiente && Desde.REPORTAR == desdeDondeViene) {
            btnAgregarFoto.setVisibility(View.VISIBLE);

            btnRechazar.setVisibility(View.VISIBLE);
            btnRechazar.setEnabled(!rechazado);

        } else if (Desde.MAPA_MUNICIPIO == desdeDondeViene) {

            btnRechazar.setVisibility(View.VISIBLE);
            btnRechazar.setEnabled(!rechazado);
        } else if (Desde.MIS_REPORTES == desdeDondeViene || esMiReporte) {
            detalle_estado_texto.setVisibility(View.VISIBLE);
        } else if (Desde.TOP_CINCO == desdeDondeViene) {

            btnRechazar.setVisibility(View.VISIBLE);
            btnRechazar.setEnabled(!rechazado);
        }

    }

    @Background
    void obtenerReporte(Long id) {
        dialog.show();
        AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
        List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
        interceptors.add(interceptor);
        reportesClient.getRestTemplate().setInterceptors(interceptors);
        //obtenerDetalleRequest(id);
        try {
            reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
            detalleReporte = reportesClient.obtenerDetalle(id);
            mostrarResultado(detalleReporte);
        } catch (HttpServerErrorException e) {
            e.printStackTrace();
            showServerError();
        } catch (HttpClientErrorException e) {
            e.printStackTrace();
            if (e.getStatusCode().ordinal() != 24)
                showServerError();
        } catch (ResourceAccessException e) {
            e.printStackTrace();
            showConnectionError();
        } finally {
            dialog.dismiss();
        }

    }

    @Background
    void registrarVoto(Long id) {

        AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
        List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
        interceptors.add(interceptor);
        reportesClient.getRestTemplate().setInterceptors(interceptors);

        try {
            reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
            mostrarResultado(reportesClient.registrarVoto(id), id);
        } catch (HttpServerErrorException e) {
            e.printStackTrace();
            showServerError();
        } catch (HttpClientErrorException e) {
            e.printStackTrace();
            if (e.getStatusCode().ordinal() != 24)
                showServerError();
        } catch (ResourceAccessException e) {
            e.printStackTrace();
            showConnectionError();
        }

    }

	/*@UiThread
	void cargarSpinner(){
		obtenerMotivos();
	}*/

    @Background
    void obtenerMotivos() {
        dialog.show();
        AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
        List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
        interceptors.add(interceptor);
        reportesClient.getRestTemplate().setInterceptors(interceptors);

        try {
            reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
            ElementoListaDTO[] elementoLista = reportesClient.consultarMotivos();
            loadLista_motivos(elementoLista);

            obtenerMotivo();
        } catch (HttpServerErrorException e) {
            e.printStackTrace();
            showServerError();
        } catch (HttpClientErrorException e) {
            e.printStackTrace();
            if (e.getStatusCode().ordinal() != 24)
                showServerError();
        } catch (ResourceAccessException e) {
            e.printStackTrace();
            showConnectionError();
        } finally {
            dialog.dismiss();
        }

    }

    @Background
    void obtenerMotivo() {
        if (spinnerRazon.getVisibility() == View.GONE) {
            dialog.show();
            AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
            List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
            interceptors.add(interceptor);
            reportesClient.getRestTemplate().setInterceptors(interceptors);

            try {
                reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
                ElementoListaDTO[] elementoLista = reportesClient.consultarMotivos();

                List<TextValueDTO> razones = new ArrayList<TextValueDTO>();
                for (ElementoListaDTO elemento : elementoLista) {
                    razones.add(new TextValueDTO(elemento.getId(), elemento.getTexto()));
                }

                for (TextValueDTO t : razones) {
                    if (t.getId().longValue() == detalleReporte.getIdMotivo().longValue()) {
                        colocarMotivo(t.getNombre());
                    }
                }

            } catch (HttpServerErrorException e) {
                e.printStackTrace();
                showServerError();
            } catch (HttpClientErrorException e) {
                e.printStackTrace();
                if (e.getStatusCode().ordinal() != 24)
                    showServerError();
            } catch (ResourceAccessException e) {
                e.printStackTrace();
                showConnectionError();
            } finally {
                dialog.dismiss();
            }
        }
    }

    @UiThread
    void colocarMotivo(String motivo) {
        razon.setText(motivo);
    }

    @UiThread
    void loadLista_motivos(ElementoListaDTO[] motivosLista) {
        TextValueDTO defaultElement = new TextValueDTO();
        defaultElement.setId(0l);
        defaultElement.setNombre(getString(R.string.campo_por_que));
        List<TextValueDTO> razones = new ArrayList<TextValueDTO>();
        razones.add(defaultElement);

        for (ElementoListaDTO elemento : motivosLista) {
            razones.add(new TextValueDTO(elemento.getId(), elemento.getTexto()));
        }

        ArrayAdapter<TextValueDTO> dataAdapter = new ArrayAdapter<TextValueDTO>(this, R.layout.simple_spinner_item, razones);

        spinnerRazon.setAdapter(dataAdapter);
        seleccionarMotivo(razones, detalleReporte.getIdMotivo());
    }

    @Background
    void obtenerRangos(Long idRango, Long idMotivo) {

        AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
        List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
        interceptors.add(interceptor);
        reportesClient.getRestTemplate().setInterceptors(interceptors);

        try {
            reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
            loadLista_rangos(reportesClient.consultarRangos(), idRango, idMotivo);

        } catch (HttpServerErrorException e) {
            e.printStackTrace();
            showServerError();
        } catch (HttpClientErrorException e) {
            e.printStackTrace();
            if (e.getStatusCode().ordinal() != 24)
                showServerError();
        } catch (ResourceAccessException e) {
            e.printStackTrace();
            showConnectionError();
        }

    }

    void seleccionarMotivo(List<TextValueDTO> motivosLista, Long idMotivo) {
        int i = 0;
        for (TextValueDTO t : motivosLista) {
            if (t.getId() == idMotivo) {
                spinnerRazon.setSelection(i);
            }
            i++;
        }

    }

    @UiThread
    void loadLista_rangos(ElementoListaDTO[] rangosLista, Long idRango, Long idMotivo) {

        if (tiempoEstadoValidado)
            for (ElementoListaDTO elemento : rangosLista) {
                if (elemento.getId() == idRango) {
                    tiempo.setText(elemento.getTexto());
                }
            }
        obtenerMotivos();
    }

    @UiThread
    void mostrarResultado(VotoRegistradoDTO votoRegistrado, Long id) {
        btnRechazar.setVisibility(View.GONE);
        cantidad_rechazos.setText(votoRegistrado.getCantidadVotos() + "");
        eru.rechazar(id);
        configurarInterfaz();

        final AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage(R.string.detalle_voto_registrado)
                .setCancelable(false)
                .setPositiveButton(R.string.terminar, new DialogInterface.OnClickListener() {
                    public void onClick(final DialogInterface dialog, final int id) {
                        dialog.cancel();
                    }
                });
        final AlertDialog alert = builder.create();
        alert.show();
    }

    private Boolean tiempoEstadoValidado = true;
    boolean esMiReporte = false;
    private MyReportsUtil myElephants;
    private PosicionDTO posicion;

    @UiThread
    void mostrarResultado(DetalleCuidoLoPublicoDTO reporte) {
        String dptoText = JsonHandler.getValueById(this, Json.DEPARTAMENTOS, reporte.getDepartamento());
        String municipioText = JsonHandler.getValueById(this, Json.MUNICIPIOS, reporte.getMunicipio());
        String cantidadMiniaturas = "0";

        // L&oacute;gica para mostrar o no los campos de edici&oacute;n

        posicion = reporte.getPosicion();

        for (EstadoReporte estadoEnum : EstadoReporte.values()) {
            if (estadoEnum.getId() == reporte.getEstado()) {

                if (estadoEnum.getId().longValue() == EstadoReporte.PENDIENTE.getId().longValue()) {
                    estaPendiente = true;
                }

                if (estadoEnum.getId().longValue() == EstadoReporte.RECHAZADO.getId().longValue()) {
                    estaRechazado = true;
                }

                detalle_estado_texto.setText(estadoEnum.getTexto());
                detalle_estado_texto.setCompoundDrawablesWithIntrinsicBounds(0, estadoEnum.getIdImagen(), 0, 0);
            }
        }

        boolean mostrarBotonActualizar = false;
        myElephants = MyReportsUtil.getInstance(getApplicationContext());

        for (MyLocalReportDTO miReporte : myElephants.getList()) {
            if (miReporte.getId().longValue() == reporte.getId().longValue()) {
                esMiReporte = true;
            }
        }

        costoInicial = reporte.getCosto();
        contratistaInicial = reporte.getContratista();
        tituloInicial = reporte.getTitulo();
        entidadInicial = reporte.getEntidad();

        if (!estaRechazado && reporte.getCostoEstado() != EstadoCampo.VALIDADO.getId()) {
            mostrarBotonActualizar = true;
            costoEdit.setVisibility(View.VISIBLE);

            if (esMiReporte)
                costoEdit.setText(reporte.getCosto() + "");
        } else {
            NumberFormat baseFormat = NumberFormat.getCurrencyInstance(Locale.US);
            String moneyString = baseFormat.format(reporte.getCosto());

            costo.setText(moneyString);
        }

        if (!estaRechazado && reporte.getContratistaEstado() != EstadoCampo.VALIDADO.getId()) {
            mostrarBotonActualizar = true;
            contratistaEdit.setVisibility(View.VISIBLE);
            if (esMiReporte)
                contratistaEdit.setText(reporte.getContratista());
        } else {
            contratista.setText(reporte.getContratista());
        }

        if (!estaRechazado && reporte.getRangoTiempoEstado() != EstadoCampo.VALIDADO.getId()) {
            tiempoEstadoValidado = false;
            mostrarBotonActualizar = true;
            spinnerTiempo.setVisibility(View.VISIBLE);
            obtenerRangos();
        }

        if (mostrarBotonActualizar) {
            panelBotonActualizar.setVisibility(View.VISIBLE);
            ((Button) findViewById(R.id.btnActualizar)).setEnabled(false);
        }

        if (esMiReporte) {

            if ((reporte.getComentario() != null && !reporte.getComentario().isEmpty()) || (reporte.getRazon() != null && !reporte.getRazon().isEmpty()))
                panelNotificacion.setVisibility(View.VISIBLE);

            String texto = "";

            if (reporte.getRazon() != null && !reporte.getRazon().isEmpty())
                texto = reporte.getRazon() + "\n";

            if (reporte.getComentario() != null && !reporte.getComentario().isEmpty())
                texto += reporte.getComentario();

            notificacion.setText(texto);
        }

        configurarInterfaz();

        // Otros datos

   /*     if (reporte.getMiniaturas() != null) {
            if (reporte.getMiniaturas().length >= MAX_PHOTOS) {
                btnAgregarFoto.setVisibility(View.GONE);
            }
            cantidadMiniaturas = reporte.getMiniaturas().length + "";
        }*/

        deptoMunicipio.setText(dptoText + " " + getResources().getString(R.string.detalle_slash) + " " + municipioText);
        fechaReporte.setText(reporte.getFechaReporte());
        cantidad_rechazos.setText(reporte.getRechazos() + "");
        cantidad_fotos.setText(cantidadMiniaturas);
        txtTitulo.setText(reporte.getTitulo());

        if (reporte.getEstado() == EstadoCampo.VALIDADO.getId()) {
            mostrarBotonActualizar = true;
            tituloEdit.setVisibility(View.VISIBLE);
            tituloEdit.setText(reporte.getTitulo());
            entidadEdit.setVisibility(View.VISIBLE);
            entidadEdit.setText(reporte.getEntidad());
            spinnerRazon.setVisibility(View.VISIBLE);
            //cargarSpinner();
        } else {
            titulo.setText(reporte.getTitulo());
            entidad.setText(reporte.getEntidad());

        }


        gallery.removeAllViews();

        int i = 0;

        for (MiniaturaDTO miniatura : reporte.getMiniaturas()) {
            Log.i("DetalleActivity", miniatura.getIdImagenGrande() + "");

            gallery.addView(addThumbnail(miniatura.getMiniatura(), miniatura.getIdImagenGrande(), i == 0));
            i++;
        }

        idRangoInicial = reporte.getIdRangoTiempo();
        idMotivoInicial = reporte.getIdMotivo();

        obtenerRangos(idRangoInicial, idMotivoInicial);

        allLoaded = true;
    }

    private View addThumbnail(String image64, Long id, boolean firstImage) {

        final Long idTemporal = id;

        LinearLayout layout = new LinearLayout(getApplicationContext());

        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT);

        layout.setLayoutParams(layoutParams);
        layout.setGravity(Gravity.CENTER);

        if (image64 != null && !image64.isEmpty()) {
            byte[] decodedString = Base64.decode(image64, Base64.DEFAULT);
            Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0,
                    decodedString.length);

            Bitmap decodedByte = Bitmap.createScaledBitmap(bitmap,
                    bitmap.getWidth() * 2, bitmap.getHeight() * 2, false);

            if (firstImage) {
                Display display = getWindowManager().getDefaultDisplay();
                @SuppressWarnings("deprecation")
                int width = display.getWidth();
                width = (width / 2) - (bitmap.getWidth());

                layoutParams.setMargins(width, 10, 10, 10);
            } else {
                layoutParams.setMargins(10, 10, 10, 10);
            }

            ImageView imageView = new ImageView(getApplicationContext());
            imageView.setLayoutParams(new LayoutParams(decodedByte.getWidth(),
                    decodedByte.getHeight()));
            imageView.setScaleType(ImageView.ScaleType.CENTER);
            imageView.setImageBitmap(decodedByte);

            imageView.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View view) {
                    mostrarImagenGrande(idTemporal);
                }
            });

            layout.addView(imageView);
        }

        return layout;
    }

    @Background
    void mostrarImagenGrande(Long idImagenGrande) {
        dialog.show();
        AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
        List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
        interceptors.add(interceptor);
        reportesClient.getRestTemplate().setInterceptors(interceptors);

        try {
            reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
            mostrarResultado(reportesClient.obtenerImagen(idImagenGrande));

        } catch (HttpServerErrorException e) {
            e.printStackTrace();
            showServerError();
        } catch (HttpClientErrorException e) {
            e.printStackTrace();
            if (e.getStatusCode().ordinal() != 24)
                showServerError();
        } catch (ResourceAccessException e) {
            e.printStackTrace();
            showConnectionError();
        } finally {
            dialog.dismiss();
        }
    }

    @UiThread
    void mostrarResultado(ImagenDTO imagenDTO) {
        byte[] decodedString = Base64.decode(imagenDTO.getImagen(), Base64.DEFAULT);
        Bitmap bmp = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);

        File f = getTempFile();

        savePicture(f, bmp, this);

        Intent intent = new Intent();
        intent.setAction(android.content.Intent.ACTION_VIEW);
        intent.setDataAndType(Uri.fromFile(f), "image/jpeg");

        dialog.dismiss();
        startActivity(intent);

    }

    private void buildAlert(int resId) {
        final AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage(resId)
                .setCancelable(false)
                .setPositiveButton(R.string.ok, new DialogInterface.OnClickListener() {
                    public void onClick(final DialogInterface dialog, final int id) {
                        dialog.cancel();
                    }
                });
        final AlertDialog alert = builder.create();
        alert.show();
    }

    @Click
    void btnActualizar() {

        if (estaPendiente && (tituloEdit.getText().toString().isEmpty() || entidadEdit.getText().toString().isEmpty() || spinnerRazon.getSelectedItemPosition() == 0)) {
            buildAlert(R.string.diligenciar_todos);

        } else {
            if (tituloEdit.getVisibility() == View.VISIBLE && tituloEdit.getText().toString().length() > 80) {
                buildAlert(R.string.tamanio_maximo_titulo);
            } else if (entidadEdit.getVisibility() == View.VISIBLE && entidadEdit.getText().toString().length() > 80) {
                buildAlert(R.string.tamanio_maximo_entidad);
            } else if (costoEdit.getVisibility() == View.VISIBLE && !costoEdit.getText().toString().isEmpty() && costoEdit.getText().toString().length() > 18) {
                buildAlert(R.string.tamanio_maximo_costo);
            } else if (contratistaEdit.getVisibility() == View.VISIBLE && !contratistaEdit.getText().toString().isEmpty() && contratistaEdit.getText().toString().length() > 80) {
                buildAlert(R.string.tamanio_maximo_contratista);
            } else {
                ActualizarReporteDTO reporte = new ActualizarReporteDTO();

                reporte.setIdMotivo(idMotivoInicial);
                if (spinnerRazon != null && spinnerRazon.getSelectedItem() != null)
                    reporte.setIdMotivo(((TextValueDTO) spinnerRazon.getSelectedItem()).getId());

                if (spinnerTiempo.getVisibility() == View.VISIBLE)
                    if (spinnerTiempo.getSelectedItemPosition() != 0)
                        reporte.setIdRangoTiempo(((TextValueDTO) spinnerTiempo.getSelectedItem()).getId());
                    else
                        reporte.setIdRangoTiempo(idRangoInicial);

                if (costoEdit.getVisibility() == View.VISIBLE)
                    if (!costoEdit.getText().toString().isEmpty())
                        reporte.setCosto(Long.parseLong(costoEdit.getText().toString()));
                    else
                        reporte.setCosto(costoInicial);

                if (contratistaEdit.getVisibility() == View.VISIBLE)
                    reporte.setContratista(contratistaEdit.getText().toString());
                else
                    reporte.setContratista(contratistaInicial);

                if (tituloEdit.getVisibility() == View.VISIBLE)
                    reporte.setTitulo(tituloEdit.getText().toString());
                else
                    reporte.setTitulo(tituloInicial);

                if (entidadEdit.getVisibility() == View.VISIBLE)
                    reporte.setEntidad(entidadEdit.getText().toString());
                else
                    reporte.setEntidad(entidadInicial);

                if (spinnerRazon.getVisibility() == View.VISIBLE)
                    if (spinnerRazon.getSelectedItemPosition() != 0)
                        reporte.setIdMotivo(((TextValueDTO) spinnerRazon.getSelectedItem()).getId());

                actualizar(reporte);
            }
        }

    }

    @Background
    void actualizar(ActualizarReporteDTO reporte) {
        dialog.show();
        AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
        List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
        interceptors.add(interceptor);
        reportesClient.getRestTemplate().setInterceptors(interceptors);

        try {
            reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
            reportesClient.actualizarReporte(getIntent().getExtras().getLong(EXTRA_ID), reporte);
            mostrarResultado();

        } catch (HttpServerErrorException e) {
            e.printStackTrace();
            showServerError();
        } catch (HttpClientErrorException e) {
            e.printStackTrace();
            if (e.getStatusCode().ordinal() != 24)
                showServerError();
        } catch (ResourceAccessException e) {
            e.printStackTrace();
            showConnectionError();
        } finally {
            dialog.dismiss();
        }

    }

    @UiThread
    void mostrarResultado() {
        obtenerReporte(getIntent().getExtras().getLong(EXTRA_ID));
        configurarInterfaz();

        final AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage(R.string.detalle_actualizar_disclaimer)
                .setCancelable(false)
                .setPositiveButton(R.string.terminar, new DialogInterface.OnClickListener() {
                    public void onClick(final DialogInterface dialog, final int id) {
                        dialog.cancel();
                        finish();
                    }
                });
        final AlertDialog alert = builder.create();
        alert.show();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        System.gc();
        if (requestCode == CAMERA_INTENT) {
            if (resultCode == Activity.RESULT_OK) {

                if (data.hasExtra("data")) {

                    buildAlertAddImage(data);


                }
            }
        }

    }

    @Background
    void asociarImagen(AsociarImagenDTO imagen) {


        dialog.show();
        AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
        List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
        interceptors.add(interceptor);
        reportesClient.getRestTemplate().setInterceptors(interceptors);

        try {
            reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
            reportesClient.asociarImagen(imagen);
            obtenerReporte(getIntent().getExtras().getLong(EXTRA_ID));
        } catch (HttpServerErrorException e) {
            e.printStackTrace();
            showServerError();
        } catch (HttpClientErrorException e) {
            e.printStackTrace();
            if (e.getStatusCode().ordinal() != 24)
                showServerError();
        } catch (ResourceAccessException e) {
            e.printStackTrace();
            showConnectionError();
        } finally {
            dialog.dismiss();
        }

    }

    private void savePicture(File file, Bitmap b, Context ctx) {
        if (file.exists())
            file.delete();
        try {
            FileOutputStream out = new FileOutputStream(file);
            b.compress(Bitmap.CompressFormat.JPEG, 100, out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private File getTempFile() {

        if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {

            File file = new File(Environment.getExternalStorageDirectory(), TEMP_PHOTO_FILE);
            try {
                file.createNewFile();
            } catch (IOException e) {
            }

            return file;
        } else {

            return null;
        }
    }

    @UiThread
    void showServerError() {

        new AlertDialog.Builder(this)
                .setMessage(R.string.server_error_message)
                .setTitle(R.string.server_error_title)
                .setPositiveButton(R.string.ok,
                        new DialogInterface.OnClickListener() {

                            @Override
                            public void onClick(DialogInterface dialog,
                                                int which) {
                                dialog.dismiss();
                            }
                        }).create().show();

    }

    @UiThread
    void showConnectionError() {
        new AlertDialog.Builder(this)
                .setMessage(R.string.conection_error_message)
                .setTitle(R.string.conection_error_title)
                .setPositiveButton(R.string.ok,
                        new DialogInterface.OnClickListener() {

                            @Override
                            public void onClick(DialogInterface dialog,
                                                int which) {
                                dialog.dismiss();
                            }
                        }).create().show();

    }


    //
    @Background
    void obtenerRangos() {

        AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
        List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
        interceptors.add(interceptor);
        reportesClient.getRestTemplate().setInterceptors(interceptors);

        try {
            reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
            loadLista_rangos(reportesClient.consultarRangos());

        } catch (HttpServerErrorException e) {
            e.printStackTrace();
            showServerError();
        } catch (HttpClientErrorException e) {
            e.printStackTrace();
            if (e.getStatusCode().ordinal() != 24)
                showServerError();
        } catch (ResourceAccessException e) {
            e.printStackTrace();
            showConnectionError();
        }

    }

    @UiThread
    void loadLista_rangos(ElementoListaDTO[] rangosLista) {

        rangos.clear();


        if (esMiReporte && !tiempoEstadoValidado && (idRangoInicial != null && idRangoInicial > 0L)) {
            for (ElementoListaDTO elemento : rangosLista) {
                if (elemento.getId() == idRangoInicial)
                    rangos.add(new TextValueDTO(elemento.getId(), elemento.getTexto()));
            }

            for (ElementoListaDTO elemento : rangosLista) {
                if (elemento.getId() != idRangoInicial)
                    rangos.add(new TextValueDTO(elemento.getId(), elemento.getTexto()));
            }

            ArrayAdapter<TextValueDTO> dataAdapter = new ArrayAdapter<TextValueDTO>(this, R.layout.simple_spinner_item, rangos);

            spinnerTiempo.setAdapter(dataAdapter);
        } else {

            TextValueDTO defaultElement = new TextValueDTO();
            defaultElement.setId(0l);
            defaultElement.setNombre(getString(R.string.campo_tiempo_existencia));
            rangos.add(defaultElement);

            for (ElementoListaDTO elemento : rangosLista) {
                rangos.add(new TextValueDTO(elemento.getId(), elemento.getTexto()));
            }

            ArrayAdapter<TextValueDTO> dataAdapter = new ArrayAdapter<TextValueDTO>(this, R.layout.simple_spinner_item, rangos);

            spinnerTiempo.setAdapter(dataAdapter);
        }
    }

    private void buildAlertAddImage(Intent data) {

        final Intent myData = data;

        final AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage(R.string.texto_adjuntar_foto)
                .setCancelable(false)
                .setPositiveButton(R.string.terminar, new DialogInterface.OnClickListener() {
                    public void onClick(final DialogInterface dialog, final int id) {

                        Bitmap bitmapT = (Bitmap) myData.getParcelableExtra("data");

                        int w = 680, h = 380;

                        if (bitmapT.getWidth() < bitmapT.getHeight()) {
                            h = 680;
                            w = 380;
                        }

                        Bitmap bitmap = Bitmap.createScaledBitmap(bitmapT, w, h, false);


                        ByteArrayOutputStream baos = new ByteArrayOutputStream();
                        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
                        byte[] imgBytes = baos.toByteArray();

                        AsociarImagenDTO dto = new AsociarImagenDTO();
                        dto.setImagen(Base64.encodeToString(imgBytes, Base64.DEFAULT));
                        dto.setIdReporte(getIntent().getExtras().getLong(EXTRA_ID));

                        asociarImagen(dto);

                        dialog.dismiss();


                    }
                });
        final AlertDialog alert = builder.create();
        alert.show();
    }

    @AfterTextChange({R.id.detalle_title, R.id.entidad, R.id.costo, R.id.contratista})
    void afterTextChangedOnSomeTextViews(TextView tv, Editable text) {
        Log.i("DetalleActivity", "Nuevo texto: " + text.toString());

        if (allLoaded && !text.toString().isEmpty()) ;
        ((Button) findViewById(R.id.btnActualizar)).setEnabled(true);
    }

    @Override
    public void onConnectionFailed(ConnectionResult result) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onConnected(Bundle connectionHint) {
        mLocationClient.getLastLocation();
    }

    @Override
    public void onDisconnected() {
        // TODO Auto-generated method stub

    }
}
