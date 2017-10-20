package co.gov.presidencia.elefantes.blancos.dtoresponse;

/**
 *
 * @author Anibal Parra
 */
public class ElefanteBlancoResponseDto {
    
    private int id;
    //private co.gov.presidencia.elefantes.blancos.actualizacion.dtoresponse.ElefanteBlancoResponseDto id;

    /*public ElefanteBlancoResponseDto(int id) {
        this.id = id;
    }*/


	public ElefanteBlancoResponseDto(int n) {
		this.id = n;
	}

	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    
}
