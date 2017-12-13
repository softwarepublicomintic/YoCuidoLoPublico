package co.gov.presidencia.elefantes.blancos.dtoresponse;

/**
 *
 * @author Anibal Parra
 */
public class CantidadRegionResponseDto {

    private int region;
    private int cantidad;

    public CantidadRegionResponseDto(int region, int cantidad) {
        this.region = region;
        this.cantidad = cantidad;
    }
    
    public CantidadRegionResponseDto() {
        
    }

    public int getRegion() {
        return region;
    }

    public void setRegion(int region) {
        this.region = region;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
    
}
