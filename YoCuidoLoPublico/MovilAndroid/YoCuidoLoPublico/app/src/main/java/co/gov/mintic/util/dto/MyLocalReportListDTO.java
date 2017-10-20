package co.gov.mintic.util.dto;

import java.util.List;

public class MyLocalReportListDTO {
	private List<MyLocalReportDTO> favorites;

	public List<MyLocalReportDTO> getFavorites() {
		return favorites;
	}

	public void setFavorites(List<MyLocalReportDTO> favorites) {
		this.favorites = favorites;
	}
}
