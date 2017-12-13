package co.gov.mintic.util.dto;

import java.util.ArrayList;
import java.util.List;

public class ReportesRechazadosDTO {

	List<Long> rechazados = new ArrayList<Long>();
	
	public List<Long> getRechazados() {
		return rechazados;
	}
	
	public void setRechazados(List<Long> rechazados) {
		this.rechazados = rechazados;
	}
	
}
