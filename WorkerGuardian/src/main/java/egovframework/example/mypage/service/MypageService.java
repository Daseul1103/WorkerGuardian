package egovframework.example.mypage.service;

import egovframework.example.login.vo.LoginVO;

public interface MypageService {

    // 사용자 정보 수정 저장
    void infoSave(LoginVO paramLoginVO) throws Exception;

    // 사용자 정보 조회
    LoginVO loginInfo(LoginVO paramLoginVO) throws Exception;
}
