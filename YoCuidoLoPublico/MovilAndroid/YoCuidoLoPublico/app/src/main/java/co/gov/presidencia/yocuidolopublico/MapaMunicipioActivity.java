package co.gov.presidencia.yocuidolopublico;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import android.location.Location;
import android.location.LocationManager;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import android.widget.Toast;

import co.gov.mintic.util.MyReportsUtil;
import co.gov.mintic.util.dto.MyLocalReportDTO;
import co.gov.presidencia.yocuidolopublico.enumeration.Desde;
import co.gov.presidencia.yocuidolopublico.event.CameraUpdatedEvent;
import co.gov.presidencia.yocuidolopublico.event.ReporteSeleccionadoEvent;
import co.gov.presidencia.yocuidolopublico.listener.ReporteSeleccionadoListener;
import co.gov.presidencia.yocuidolopublico.listener.MapChangedListener;
import co.gov.presidencia.yocuidolopublico.service.Server;
import co.gov.presidencia.yocuidolopublico.service.client.CuidoLoPublicoClient;
import co.gov.presidencia.yocuidolopublico.service.client.dto.CuidoLoPublicoMapaMunicipioDTO;
import co.gov.presidencia.yocuidolopublico.service.client.interceptor.AuthInterceptor;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesClient;
import com.google.android.gms.location.LocationClient;
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.LatLngBounds;
import com.google.android.gms.maps.model.MarkerOptions;
import com.googlecode.androidannotations.annotations.Background;
import com.googlecode.androidannotations.annotations.Click;
import com.googlecode.androidannotations.annotations.EActivity;
import com.googlecode.androidannotations.annotations.UiThread;
import com.googlecode.androidannotations.annotations.rest.RestService;

import de.greenrobot.event.EventBus;

@EActivity(R.layout.activity_mapa_municipio)
public class MapaMunicipioActivity extends FragmentActivity implements
        GooglePlayServicesClient.ConnectionCallbacks,
        GooglePlayServicesClient.OnConnectionFailedListener {

    public static final String REQUESTED_LATITUDE = "1";
    public static final String REQUESTED_LONGITUDE = "2";
    public static final String REQUESTED_CODE = "3";

    private static final String TEMP_PHOTO_FILE = "temporary_holder_reportar.jpg";

    private static final String TAG = "MapaActivity";
    private GoogleMap map;
    private static final Float DEFAULT_ZOOM = 11.0f;
    private Boolean firstTime = true;
    private Double latitude;
    private Double longitude;
    private static LatLng elephantPosition;
    private MyReportsUtil myElephants;
    private List<Long> alreadyLoaded = new ArrayList<Long>();

    boolean firstState = true;

    @RestService
    CuidoLoPublicoClient reportesClient;

    private HashMap<String, Long> markers = new HashMap<String, Long>();

    private LocationClient mLocationClient;
    private static boolean isRegistered = false;
    private static final Integer CAMERA_INTENT = 1111;
    private static final Integer REPORT_INTENT = 1112;

    private LatLng requestedPosition;

    @Override
    protected void onResume() {
        Log.i(TAG, "onResume");
        super.onResume();
    }

    @Override
    protected void onStart() {

        Log.i(TAG, "onStart()");
        mLocationClient = new LocationClient(this, this, this);
        mLocationClient.connect();

        myElephants = MyReportsUtil.getInstance(getApplicationContext());

        if (!isRegistered) {
            isRegistered = true;
            EventBus.getDefault().register(this);
        }

        map = ((SupportMapFragment) (getSupportFragmentManager().findFragmentById(R.id.map))).getMap();
        map.getUiSettings().setMyLocationButtonEnabled(false);
        map.setMyLocationEnabled(true);
        map.getUiSettings().setZoomControlsEnabled(false);
        map.getUiSettings().setCompassEnabled(false);
        map.setMapType(GoogleMap.MAP_TYPE_NORMAL);
        map.setOnCameraChangeListener(new MapChangedListener());
        LatLng loc = new LatLng(4.624335, -74.063644);
        map.moveCamera(CameraUpdateFactory.newLatLngZoom(loc, 5));

        getSupportFragmentManager().executePendingTransactions();
        super.onStart();
    }

    public void onEventMainThread(CameraUpdatedEvent event) {
        obtenerReportes(event.getNewPosition());
    }

    public void onEventMainThread(ReporteSeleccionadoEvent event) {
        Log.d(TAG, "Reporte seleccionado: " + event.getId());

        Intent intent = new Intent(this, DetalleActivity_.class);
        intent.putExtra(DetalleActivity.EXTRA_ID, event.getId());
        intent.putExtra(DetalleActivity.EXTRA_FROM_WHERE, Desde.MAPA_MUNICIPIO.getId());

        startActivity(intent);
    }

    @Background
    void obtenerReportes(LatLng posicion) {

        AuthInterceptor interceptor = AuthInterceptor.getInstance(Server.SECRETARIA);
        List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
        interceptors.add(interceptor);
        reportesClient.getRestTemplate().setInterceptors(interceptors);
        //obtenerPorMunicipioRequest(getIntent().getExtras().getString(REQUESTED_CODE));

        try {
            reportesClient.getRestTemplate().setRequestFactory(new HttpComponentsClientHttpRequestFactory());
            mostrarResultado(reportesClient.obtenerPorMunicipio(getIntent().getExtras().getString(REQUESTED_CODE)));
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
    void mostrarResultado(CuidoLoPublicoMapaMunicipioDTO[] reportes) {
        LatLngBounds.Builder builder = new LatLngBounds.Builder();

        for (CuidoLoPublicoMapaMunicipioDTO reporte : reportes) {

            if (reporte.getEstado() == 1) {
                MarkerOptions options = new MarkerOptions();

                LatLng latLng = new LatLng(reporte.getPosicion().getLatitud(), reporte.getPosicion().getLongitud());

                builder.include(latLng);

                options.position(latLng);
                options.title(reporte.getTitulo());

                if (reporte.getNoEsUnReporte()) {
                    options.icon(BitmapDescriptorFactory.fromResource(R.drawable.icono_edificio));
                } else {
                    options.icon(BitmapDescriptorFactory.fromResource(R.drawable.icono_ubicacion_reporte));
                }

                markers.put(map.addMarker(options).getId(), reporte.getId());
                alreadyLoaded.add(reporte.getId());
            }
        }

        LatLngBounds bounds = builder.build();
        int padding = 250;
        if (firstState) {
            CameraUpdate cu = CameraUpdateFactory.newLatLngBounds(bounds, padding);
            map.moveCamera(cu);
            map.animateCamera(cu);
            firstState = false;
        }



        map.setOnInfoWindowClickListener(new ReporteSeleccionadoListener(markers));
    }

    @Click
    void ubicarme() {
        Log.d(TAG, "Ubicarme");
        centerMap(true, null);
    }

    @Click
    void reportar() {
        LocationManager locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);

        if (!locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            buildAlertMessageNoGps();
        } else {
            Location location = mLocationClient.getLastLocation();
            elephantPosition = new LatLng(location.getLatitude(), location.getLongitude());

            Intent photoIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
            startActivityForResult(photoIntent, CAMERA_INTENT);
        }
    }

    private void buildAlertMessageNoGps() {
        final AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage(R.string.habilitar_gps)
                .setCancelable(false)
                .setPositiveButton(R.string.ajustes, new DialogInterface.OnClickListener() {
                    public void onClick(final DialogInterface dialog, final int id) {
                        startActivity(new Intent(android.provider.Settings.ACTION_LOCATION_SOURCE_SETTINGS));
                    }
                })
                .setNegativeButton(R.string.cancelar, new DialogInterface.OnClickListener() {
                    public void onClick(final DialogInterface dialog, final int id) {
                        dialog.cancel();
                    }
                });
        final AlertDialog alert = builder.create();
        alert.show();
    }

    @UiThread
    void centerMap(boolean animate, LatLng position) {

        CameraUpdate center = null;
        Location location = mLocationClient.getLastLocation();

        if (position != null) {
            center = CameraUpdateFactory.newLatLngZoom(position, DEFAULT_ZOOM);
        } else {
            if (location != null)
                center = CameraUpdateFactory.newLatLngZoom(new LatLng(location.getLatitude(), location.getLongitude()), DEFAULT_ZOOM);
            else
                Toast.makeText(getApplicationContext(), R.string.ubicacion_no_disponible, Toast.LENGTH_LONG).show();
        }

        if (center != null && animate)
            map.animateCamera(center);
        else if (center != null)
            map.moveCamera(center);
    }

    @Override
    protected void onDestroy() {
        mLocationClient.disconnect();

        if (isRegistered) {
            isRegistered = false;
            EventBus.getDefault().unregister(this);
        }

        super.onDestroy();
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

    // Gmaps listeners

    @Override
    public void onConnectionFailed(ConnectionResult result) {
        // Connection Failed
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        System.gc();
        if (requestCode == CAMERA_INTENT) {
            if (resultCode == Activity.RESULT_OK) {
                Intent intent = new Intent(getApplicationContext(), ReportarActivity_.class);

                if (data.hasExtra("data")) {
                    Bitmap b = Bitmap.createScaledBitmap((Bitmap) data.getParcelableExtra("data"), 1200, 800, false);
                    File f = getTempFile();
                    savePicture(f, b, this);
                    intent.putExtra(ReportarActivity.IMG, Uri.fromFile(f).getPath());
                }

                intent.putExtra(ReportarActivity.LAT, elephantPosition.latitude);
                intent.putExtra(ReportarActivity.LNG, elephantPosition.longitude);


                startActivityForResult(intent, REPORT_INTENT);
            }
        } else if (requestCode == REPORT_INTENT) {
            if (resultCode == Activity.RESULT_OK) {

                MarkerOptions options = new MarkerOptions();
                options.position(elephantPosition);
                options.title(data.getStringExtra(ReportarActivity.RETURN_NAME));
                options.icon(BitmapDescriptorFactory.fromResource(R.drawable.icono_pendiente));

                markers.put(map.addMarker(options).getId(), data.getLongExtra(ReportarActivity.RETURN_ID, 99L));

                MyLocalReportDTO newElephant = new MyLocalReportDTO();
                newElephant.setId(data.getLongExtra(ReportarActivity.RETURN_ID, 99L));
                newElephant.setLat(elephantPosition.latitude);
                newElephant.setLng(elephantPosition.longitude);
                newElephant.setNombreInstitucion(data.getStringExtra(ReportarActivity.RETURN_NAME));

                myElephants.addElephant(newElephant);
            }
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

    @Override
    public void onConnected(Bundle connectionHint) {

        Bundle bundle = getIntent().getExtras();

        if (bundle != null) {
            latitude = bundle.getDouble(REQUESTED_LATITUDE);
            longitude = bundle.getDouble(REQUESTED_LONGITUDE);
        }

        if ((latitude != null && latitude != 0d) && (longitude != null && longitude != 0d)) {
            Log.i(TAG, "latitude [" + latitude + "]");
            Log.i(TAG, "longitude [" + longitude + "]");
            requestedPosition = new LatLng(latitude, longitude);
        }

        if (firstTime) {

            if (requestedPosition != null) {
                CameraUpdatedEvent event = new CameraUpdatedEvent(requestedPosition);
                onEventMainThread(event);

                centerMap(false, requestedPosition);

                requestedPosition = null;
            }

            firstTime = false;
        }

    }

    @Override
    public void onDisconnected() {
        // Disconnected

    }

}
