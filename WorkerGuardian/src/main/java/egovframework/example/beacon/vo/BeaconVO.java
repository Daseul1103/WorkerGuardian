package egovframework.example.beacon.vo;

/*************************************
* 비콘 관리 테이블 - beacon_info         *
*************************************/
public class BeaconVO {
	
	private String UUID;           // 비콘 UUID
    private String MAJOR;          // Major 값
    private String MINOR;          // Minor 값
    private String LIMIT_FLAG;     // 제한 구역 여부
    private String SITE_ID;        // 현장 ID
    private String BEACON_NAME;    // 비콘 이름(별칭)
    private String SITE_NAME;      // 현장 이름
    private String REG_DATE;       // 비콘 등록일
    private int DANGER_DISTANCE;   // 비콘 위험 거리
    private int BEACON_Y;          // 비콘 Y 값
    private int BEACON_X;          // 비콘 X 값
    
    
    
	public String getUUID() {
		return UUID;
	}
	public void setUUID(String uUID) {
		UUID = uUID;
	}
	public String getMAJOR() {
		return MAJOR;
	}
	public void setMAJOR(String mAJOR) {
		MAJOR = mAJOR;
	}
	public String getMINOR() {
		return MINOR;
	}
	public void setMINOR(String mINOR) {
		MINOR = mINOR;
	}
	public String getLIMIT_FLAG() {
		return LIMIT_FLAG;
	}
	public void setLIMIT_FLAG(String lIMIT_FLAG) {
		LIMIT_FLAG = lIMIT_FLAG;
	}
	public String getSITE_ID() {
		return SITE_ID;
	}
	public void setSITE_ID(String sITE_ID) {
		SITE_ID = sITE_ID;
	}
	public String getBEACON_NAME() {
		return BEACON_NAME;
	}
	public void setBEACON_NAME(String bEACON_NAME) {
		BEACON_NAME = bEACON_NAME;
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
	public int getDANGER_DISTANCE() {
		return DANGER_DISTANCE;
	}
	public void setDANGER_DISTANCE(int dANGER_DISTANCE) {
		DANGER_DISTANCE = dANGER_DISTANCE;
	}
	public int getBEACON_Y() {
		return BEACON_Y;
	}
	public void setBEACON_Y(int bEACON_Y) {
		BEACON_Y = bEACON_Y;
	}
	public int getBEACON_X() {
		return BEACON_X;
	}
	public void setBEACON_X(int bEACON_X) {
		BEACON_X = bEACON_X;
	}
    
    
}
