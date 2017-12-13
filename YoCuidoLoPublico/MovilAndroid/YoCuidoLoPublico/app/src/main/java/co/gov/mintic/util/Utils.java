package co.gov.mintic.util;

import java.io.ByteArrayOutputStream;

import android.annotation.SuppressLint;
import android.graphics.Bitmap;
import android.util.Base64;

@SuppressLint("DefaultLocale")
public class Utils {

	
	public static Long[] getLongsFromString(String string){
		string = string.replace(" ", "");
		String[] strings = string.split(",");
		
		Long[] ids = new Long[strings.length];
		
		int i = 0;
		for (String s: strings){
			try {
				ids[i] = Long.parseLong(s);	
			} catch (Exception e) {}	
			i++;
		}
		
		return ids;
		
	}
	
	public static String toCamelCase(final String init) {
	    if (init==null)
	        return null;

	    final StringBuilder ret = new StringBuilder(init.length());

	    for (final String word : init.split(" ")) {
	        if (!word.isEmpty()) {
	            ret.append(word.substring(0, 1).toUpperCase());
	            ret.append(word.substring(1).toLowerCase());
	        }
	        if (!(ret.length()==init.length()))
	            ret.append(" ");
	    }

	    return ret.toString();
	}
	
	public static String encodeTobase64(Bitmap image)
	{
	    Bitmap immagex=image;
	    ByteArrayOutputStream baos = new ByteArrayOutputStream();  
	    immagex.compress(Bitmap.CompressFormat.JPEG, 100, baos);
	    byte[] b = baos.toByteArray();
	    String imageEncoded = Base64.encodeToString(b,Base64.DEFAULT);

	    return imageEncoded;
	}
	
}
