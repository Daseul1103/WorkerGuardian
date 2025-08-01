package egovframework.example.login.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import egovframework.example.login.vo.LoginVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("loginMapper")
public interface LoginMapper {

    // 로그인 정보 조회
    List<LoginVO> loginInfo(@Param("user_id") String user_id, @Param("user_pw") String user_pw) throws Exception;

    // 아이디 중복 확인
    List<LoginVO> idDupleChk(String userId) throws Exception;

    // 소속 회사 확인
    List<LoginVO> orgChk(String orgId) throws Exception;

    // 회원가입 정보 저장
    void joinSave(LoginVO loginVO) throws Exception;
    
    // 로그인 접속 시간 등록
    void insertLoginTime(String userId) throws Exception;
    
}