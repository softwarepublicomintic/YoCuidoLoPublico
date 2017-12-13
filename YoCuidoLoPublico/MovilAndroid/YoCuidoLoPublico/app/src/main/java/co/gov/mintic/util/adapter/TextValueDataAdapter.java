package co.gov.mintic.util.adapter;

import java.io.InputStreamReader;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import co.gov.mintic.util.dto.FormatoDTO;
import co.gov.mintic.util.dto.StringTextValueDTO;
import co.gov.mintic.util.dto.StringTextValueParseableDTO;
import co.gov.mintic.util.dto.TextValueDTO;
import co.gov.mintic.util.dto.TextValueParseableDTO;

import com.google.gson.Gson;


public class TextValueDataAdapter {

	public static List<TextValueDTO> transformar(FormatoDTO formato,
			Class<? extends TextValueParseableDTO[]> typeC) {

		List<TextValueDTO> data = new ArrayList<TextValueDTO>();

		if (formato.getType().equals(FormatoDTO.Type.JSON)) {
			Gson gson = new Gson();
			Reader reader = new InputStreamReader(formato.getContenido());
			TextValueParseableDTO[] response = gson.fromJson(reader, typeC);

			for (TextValueParseableDTO value : response) {
				TextValueDTO item = new TextValueDTO();

				item.setId(value.getId());
				item.setNombre(value.getNombre());

				data.add(item);
			}

		}

		return data;
	}	
	
	public static String obtenerValores(FormatoDTO formato, Class<? extends TextValueParseableDTO[]> typeC, String[] ids) {

		if (formato.getType().equals(FormatoDTO.Type.JSON)) {
			Gson gson = new Gson();
			Reader reader = new InputStreamReader(formato.getContenido());
			TextValueParseableDTO[] response = gson.fromJson(reader, typeC);

			String values = "";
			List<String> listIds = new ArrayList<String>();
			
			for (String l: ids){
				listIds.add(l);
			}			
			
			for (TextValueParseableDTO value : response) {
				if (listIds.contains(value.getId())){
					values += value.getNombre() + ", ";
				}								
			}

			if (values.length()>1)
				values = values.substring(0, values.length()-2);
			
			return values;
		}

		return "";
	}
	
	public static List<StringTextValueDTO> transformarString(FormatoDTO formato,
			Class<? extends StringTextValueParseableDTO[]> typeC) {

		List<StringTextValueDTO> data = new ArrayList<StringTextValueDTO>();

		if (formato.getType().equals(FormatoDTO.Type.JSON)) {
			Gson gson = new Gson();
			Reader reader = new InputStreamReader(formato.getContenido());
			StringTextValueParseableDTO[] response = gson.fromJson(reader, typeC);

			for (StringTextValueParseableDTO value : response) {
				StringTextValueDTO item = new StringTextValueDTO();

				item.setId(value.getId());
				item.setNombre(value.getNombre());

				data.add(item);
			}

		}

		return data;
	}	
	
	public static String obtenerValor(FormatoDTO formato, Class<? extends StringTextValueParseableDTO[]> typeC, String id) {

		if (formato.getType().equals(FormatoDTO.Type.JSON)) {
			Gson gson = new Gson();
			Reader reader = new InputStreamReader(formato.getContenido());
			StringTextValueParseableDTO[] response = gson.fromJson(reader, typeC);

			for (StringTextValueParseableDTO value : response) {
				if (value.getId().equals(id)){
					return value.getNombre();
				}
			}
		}

		return "";
	}
	
	public static Integer[] obtenerTodosLosIds(FormatoDTO formato) {

		if (formato.getType().equals(FormatoDTO.Type.JSON)) {
			Gson gson = new Gson();
			Reader reader = new InputStreamReader(formato.getContenido());
			TextValueParseableDTO[] response = gson.fromJson(reader, TextValueDTO[].class);

			Integer[] ids = new Integer[response.length];
			int i = 0;
			
			for (TextValueParseableDTO value : response) {
				ids[i] = Integer.parseInt(value.getId() + "");
				i++;
			}

			return ids;
		}

		return null;
	}

}
