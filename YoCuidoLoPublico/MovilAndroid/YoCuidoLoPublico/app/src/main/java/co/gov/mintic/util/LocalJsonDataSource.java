package co.gov.mintic.util;

import java.io.IOException;
import java.io.InputStream;
import android.content.res.AssetManager;

public class LocalJsonDataSource implements JsonDataSource {

	private RequestInfo ri;

	public LocalJsonDataSource(Object ri) {
		this.ri = (RequestInfo) ri;
	}

	@Override
	public InputStream getDataList() {
		AssetManager assetMan = ri.getContext().getAssets();
		InputStream file;
		try {
			file = assetMan.open(ri.getRutaArchivo());
			
			return file;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

}
