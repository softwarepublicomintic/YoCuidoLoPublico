package co.gov.presidencia.yocuidolopublico.service.client.dto;

public class ServinformacionDTO {
	private Boolean success;
	private String message;
	private ServinformacionObjectDTO object;
	
	public Boolean getSuccess() {
		return success;
	}
	public void setSuccess(Boolean success) {
		this.success = success;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public ServinformacionObjectDTO getObject() {
		return object;
	}
	public void setObject(ServinformacionObjectDTO object) {
		this.object = object;
	}
}
