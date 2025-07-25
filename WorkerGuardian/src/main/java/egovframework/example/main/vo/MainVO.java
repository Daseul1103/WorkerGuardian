package egovframework.example.main.vo;

public class MainVO {
	public String SITE_ID;  // 현장 id
	  
	public String SITE_NAME;  // 현장 이름(별칭)
	  
	public String UUID;  // 비콘 uuid
	  
	public String BEACON_NAME;  // 비콘 이름(별칭)
	  
	public String BEACON_Y;  // 비콘 y값
	  
	public String BEACON_X;  // 비콘 x값
	  
	public String FILE_NAME;  // 현장 파일 이름

	
	public String getSITE_ID() {
		return SITE_ID;
	}

	public void setSITE_ID(String sITE_ID) {
		SITE_ID = sITE_ID;
	}

	public String getSITE_NAME() {
		return SITE_NAME;
	}

	public void setSITE_NAME(String sITE_NAME) {
		SITE_NAME = sITE_NAME;
	}

	public String getUUID() {
		return UUID;
	}

	public void setUUID(String uUID) {
		UUID = uUID;
	}

	public String getBEACON_NAME() {
		return BEACON_NAME;
	}

	public void setBEACON_NAME(String bEACON_NAME) {
		BEACON_NAME = bEACON_NAME;
	}

	public String getBEACON_Y() {
		return BEACON_Y;
	}

	public void setBEACON_Y(String bEACON_Y) {
		BEACON_Y = bEACON_Y;
	}

	public String getBEACON_X() {
		return BEACON_X;
	}

	public void setBEACON_X(String bEACON_X) {
		BEACON_X = bEACON_X;
	}

	public String getFILE_NAME() {
		return FILE_NAME;
	}

	public void setFILE_NAME(String fILE_NAME) {
		FILE_NAME = fILE_NAME;
	}
	  
	   
}
