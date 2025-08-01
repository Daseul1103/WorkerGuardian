package egovframework.example.login.service;

import java.util.List;

import egovframework.example.login.vo.LoginVO;

public interface LoginService {

    // 로그인 정보 조회
    List<LoginVO> loginInfo(String userId, String userPw) throws Exception;

    // 아이디 중복 확인
    List<LoginVO> idDupleChk(String userId) throws Exception;

    // 소속 회사 확인
    List<LoginVO> orgChk(String orgId) throws Exception;

    // 회원가입 정보 저장
    void joinSave(LoginVO loginVO) throws Exception;
    
    // 로그인 접속 시간 등록
    void insertLoginTime(String userId) throws Exception;
}
