package co.gov.presidencia.yocuidolopublico.enumeration;

public enum Json {
	
	REGIONES("regiones.json"),
	DEPARTAMENTOS("departamentos.json"),
	MUNICIPIOS("municipios.json");
	
	private String fileName;
	
	private Json(String fileName) {
		this.fileName = fileName;
	}
	
	public String getFileName(){
		return fileName;
	}
	
}
