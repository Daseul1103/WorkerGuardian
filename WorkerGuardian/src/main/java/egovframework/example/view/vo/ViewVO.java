package egovframework.example.view.vo;

public class ViewVO {
	private String SITE_ID;  // 현장 id
	  
	private String ORG_ID;  // 소속 회사 id
	  
	private String FILE_DIR;  // 파일 dir
	  
	private String SITE_NAME; // 현장 이름(별칭)
	  
	private String REG_DATE;  // 현장 등록일
	  
	private String FILE_ID;  // 파일 id
	  
	private String FILE_NAME;  // 파일명
	  
	private String REG_DT;  // 파일 등록일
	  
	public String filePath;  // 파일 path
	  
	public int BEACON_COUNT;  // 비콘 개수
	  
	public String BEACON_NAME;  // 비콘 이름 (별칭)

	public String getSITE_ID() {
		return SITE_ID;
	}

	public void setSITE_ID(String sITE_ID) {
		SITE_ID = sITE_ID;
	}

	public String getORG_ID() {
		return ORG_ID;
	}

	public void setORG_ID(String oRG_ID) {
		ORG_ID = oRG_ID;
	}

	public String getFILE_DIR() {
		return FILE_DIR;
	}

	public void setFILE_DIR(String fILE_DIR) {
		FILE_DIR = fILE_DIR;
	}

	public String getSITE_NAME() {
		return SITE_NAME;
	}

	public void setSITE_NAME(String sITE_NAME) {
		SITE_NAME = sITE_NAME;
	}

	public String getREG_DATE() {
		return REG_DATE;
	}

	public void setREG_DATE(String rEG_DATE) {
		REG_DATE = rEG_DATE;
	}

	public String getFILE_ID() {
		return FILE_ID;
	}

	public void setFILE_ID(String fILE_ID) {
		FILE_ID = fILE_ID;
	}

	public String getFILE_NAME() {
		return FILE_NAME;
	}

	public void setFILE_NAME(String fILE_NAME) {
		FILE_NAME = fILE_NAME;
	}

	public String getREG_DT() {
		return REG_DT;
	}

	public void setREG_DT(String rEG_DT) {
		REG_DT = rEG_DT;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getBEACON_COUNT() {
		return BEACON_COUNT;
	}

	public void setBEACON_COUNT(int bEACON_COUNT) {
		BEACON_COUNT = bEACON_COUNT;
	}

	public String getBEACON_NAME() {
		return BEACON_NAME;
	}

	public void setBEACON_NAME(String bEACON_NAME) {
		BEACON_NAME = bEACON_NAME;
	}
	
	
}
