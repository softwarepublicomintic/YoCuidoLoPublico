package co.gov.presidencia.yocuidolopublico.service;

public enum Server {
	SERVINFORMACION("admin","admin"), SECRETARIA("admin","admin");

	private String userName;
	private String password;

	private Server(String userName, String password){
		this.userName = userName;
		this.password = password;
	}

	public String getUserName(){
		return userName;
	}

	public String getPassword(){
		return password;
	}
}
