package co.gov.presidencia.yocuidolopublico.enumeration;


import co.gov.presidencia.yocuidolopublico.R;


public enum Region {
	
	AMAZONICA("5", R.id.regionAmazoniaFondo, R.id.regionAmazoniaIcono, R.id.textoRegionAmazonas, R.drawable.mapa_region_amazonia_activa), 
	ORINOQUIA("4", R.id.regionOrinoquiaFondo, R.id.regionOrinoquiaIcono, R.id.textoRegionOrinoquia, R.drawable.mapa_region_orinoquia_activa), 
	CARIBE("1", R.id.regionCaribeFondo, R.id.regionCaribeIcono, R.id.textoRegionCaribe, R.drawable.mapa_region_caribe_activa), 
	ANDINA("2", R.id.regionAndinaFondo, R.id.regionAndinaIcono, R.id.textoRegionAndina, R.drawable.mapa_region_andina_activa), 
	PACIFICA("3", R.id.regionPacificaFondo, R.id.regionPacificaIcono, R.id.textoRegionPacifica, R.drawable.mapa_region_pacifica_activa), 
	INSULAR("6", R.id.regionInsularFondo, R.id.regionInsularIcono, R.id.textoRegionInsular, R.drawable.mapa_region_insular_activa);
		
	private String id;
	private int enabledDrawableResourceId, backgroundResourceId, iconResourceId, textViewResourceId;
	
	private Region(String id, int backgroundResourceId, int iconResourceId, int textViewResourceId, int enabledDrawableResourceId) {
		this.id = id;
		this.enabledDrawableResourceId = enabledDrawableResourceId;
		this.backgroundResourceId = backgroundResourceId;
		this.iconResourceId = iconResourceId;
		this.textViewResourceId = textViewResourceId;
	}
	
	public String getId() {
		return id;
	}
	
	public int getEnabledDrawableResourceId() {
		return enabledDrawableResourceId;
	}
	
	public int getBackgroundResourceId() {
		return backgroundResourceId;
	}
	
	public int getIconResourceId() {
		return iconResourceId;
	}
	
	public int getTextViewResourceId() {
		return textViewResourceId;
	}
	
}
