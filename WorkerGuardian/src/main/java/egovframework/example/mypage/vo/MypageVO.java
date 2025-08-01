package egovframework.example.mypage.vo;

public class MypageVO {

	public String USER_ID;  // 사용자 최근 접속 기록 - 사용자 아이디
	public String LOGIN_TIME;  // 사용자 최근 접속 기록 - 접속 시간
	
	
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getLOGIN_TIME() {
		return LOGIN_TIME;
	}
	public void setLOGIN_TIME(String lOGIN_TIME) {
		LOGIN_TIME = lOGIN_TIME;
	}
	
	
}
