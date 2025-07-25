package egovframework.example.safety.vo;

/*************************************
* 안전 이벤트 테이블 - safety-event       *
*************************************/
public class SafetyVO {
	private String ORG_ID;  // 소속 회사 id
	  
	private String REG_DATE;  // 안전 이벤트 등록일
	  
	private String EVENT_TYPE;  // 이벤트 종류
	  
	private String EVENT_CONTENT;  // 이벤트 내용
	  
	private String WORKER_ID;  // 작업자 id
	  
	private String start_date;  // 검색 조건 - 시작일
	  
	private String end_date;  // 검색 조건 - 종료일
	  
	private String type_L;  // 이벤트 종류 - 접근 제한
	  
	private String type_G;  // 이벤트 종류 - 유해 가스
	  
	private String type_F;  // 이벤트 종류 - 낙상 사고

	  
	  
	public String getORG_ID() {
		return ORG_ID;
	}

	public void setORG_ID(String oRG_ID) {
		ORG_ID = oRG_ID;
	}

	public String getREG_DATE() {
		return REG_DATE;
	}

	public void setREG_DATE(String rEG_DATE) {
		REG_DATE = rEG_DATE;
	}

	public String getEVENT_TYPE() {
		return EVENT_TYPE;
	}

	public void setEVENT_TYPE(String eVENT_TYPE) {
		EVENT_TYPE = eVENT_TYPE;
	}

	public String getEVENT_CONTENT() {
		return EVENT_CONTENT;
	}

	public void setEVENT_CONTENT(String eVENT_CONTENT) {
		EVENT_CONTENT = eVENT_CONTENT;
	}

	public String getWORKER_ID() {
		return WORKER_ID;
	}

	public void setWORKER_ID(String wORKER_ID) {
		WORKER_ID = wORKER_ID;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getType_L() {
		return type_L;
	}

	public void setType_L(String type_L) {
		this.type_L = type_L;
	}

	public String getType_G() {
		return type_G;
	}

	public void setType_G(String type_G) {
		this.type_G = type_G;
	}

	public String getType_F() {
		return type_F;
	}

	public void setType_F(String type_F) {
		this.type_F = type_F;
	}
	   
	  
}
