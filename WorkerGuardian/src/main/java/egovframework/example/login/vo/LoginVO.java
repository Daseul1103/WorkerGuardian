package egovframework.example.login.vo;

/*************************************
* 로그인 및 사용자 관리 테이블 - user_info   *
*************************************/
public class LoginVO {
	private String USER_ID;  // 사용자 id
	  
	private String USER_PW;  // 사용자 password
	  
	private String USER_NAME;  // 사용자 이름
	  
	private String USER_PHONE;  // 사용자 휴대폰 번호
	  
	private String USER_ORG;  // 사용자  소속 회사 (사용 x)
	  
	private String ORG_ID; // 사용자 소속 회사 id
	  
	private String REG_DATE;  // 사용자 등록일

	  
	  
	public String getUSER_ID() {
		return USER_ID;
	}

	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}

	public String getUSER_PW() {
		return USER_PW;
	}

	public void setUSER_PW(String uSER_PW) {
		USER_PW = uSER_PW;
	}

	public String getUSER_NAME() {
		return USER_NAME;
	}

	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}

	public String getUSER_PHONE() {
		return USER_PHONE;
	}

	public void setUSER_PHONE(String uSER_PHONE) {
		USER_PHONE = uSER_PHONE;
	}

	public String getUSER_ORG() {
		return USER_ORG;
	}

	public void setUSER_ORG(String uSER_ORG) {
		USER_ORG = uSER_ORG;
	}

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
	  
	  
	  
}
