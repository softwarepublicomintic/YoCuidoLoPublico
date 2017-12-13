package co.gov.mintic.util;

import java.io.InputStream;
import java.util.List;

import android.content.Context;
import co.gov.mintic.util.adapter.TextValueDataAdapter;
import co.gov.mintic.util.dto.FormatoDTO;
import co.gov.mintic.util.dto.StringTextValueDTO;
import co.gov.mintic.util.dto.TextValueDTO;
import co.gov.presidencia.yocuidolopublico.enumeration.Json;

public class JsonHandler {

	public static List<TextValueDTO> getListFromJson(Context context, String fileName){
		Context ctx = context.getApplicationContext();
		String rutaArchivo = fileName;
		RequestInfo ri = new RequestInfo(ctx, rutaArchivo);
		JsonDataSource acds = new LocalJsonDataSource(ri);
		InputStream inputStream = acds.getDataList();

		FormatoDTO formato = new FormatoDTO(FormatoDTO.Type.JSON, inputStream);
		return TextValueDataAdapter.transformar(formato, TextValueDTO[].class);
	}
	
	public static List<StringTextValueDTO> getStringListFromJson(Context context, String fileName){
		Context ctx = context.getApplicationContext();
		String rutaArchivo = fileName;
		RequestInfo ri = new RequestInfo(ctx, rutaArchivo);
		JsonDataSource acds = new LocalJsonDataSource(ri);
		InputStream inputStream = acds.getDataList();

		FormatoDTO formato = new FormatoDTO(FormatoDTO.Type.JSON, inputStream);
		return TextValueDataAdapter.transformarString(formato, StringTextValueDTO[].class);
	}
	
	public static String getValueById(Context context, Json file, String id){
		Context ctx = context.getApplicationContext();
		String rutaArchivo = file.getFileName();
		RequestInfo ri = new RequestInfo(ctx, rutaArchivo);
		JsonDataSource acds = new LocalJsonDataSource(ri);
		InputStream inputStream = acds.getDataList();

		FormatoDTO formato = new FormatoDTO(FormatoDTO.Type.JSON, inputStream);
		return TextValueDataAdapter.obtenerValor(formato, StringTextValueDTO[].class, id);
	}
	
	public static String getValueByIds(Context context, String fileName, String[] ids){
		Context ctx = context.getApplicationContext();
		String rutaArchivo = fileName;
		RequestInfo ri = new RequestInfo(ctx, rutaArchivo);
		JsonDataSource acds = new LocalJsonDataSource(ri);
		InputStream inputStream = acds.getDataList();

		FormatoDTO formato = new FormatoDTO(FormatoDTO.Type.JSON, inputStream);
		return TextValueDataAdapter.obtenerValores(formato, TextValueDTO[].class, ids);
	}
	
	public static Integer[] getAllIds(Context context, String fileName){
		Context ctx = context.getApplicationContext();
		String rutaArchivo = fileName;
		RequestInfo ri = new RequestInfo(ctx, rutaArchivo);
		JsonDataSource acds = new LocalJsonDataSource(ri);
		InputStream inputStream = acds.getDataList();

		FormatoDTO formato = new FormatoDTO(FormatoDTO.Type.JSON, inputStream);
		return TextValueDataAdapter.obtenerTodosLosIds(formato);
	}
	
}
