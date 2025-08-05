package egovframework.example.mypage.mapper;

import java.util.List;

import egovframework.example.login.vo.LoginVO;
import egovframework.example.mypage.vo.MypageVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mypageMapper")
public interface MypageMapper {

    // 사용자 정보 수정 저장
    void infoSave(LoginVO paramLoginVO) throws Exception;

    // 사용자 정보 조회
    LoginVO loginInfo(LoginVO paramLoginVO) throws Exception;
    
    // 사용자 최근 접속 시간 가져오기
    MypageVO loginTimeList(String userId) throws Exception;
    
    // 마이페이지 본인 확인
    List<LoginVO> identityPw(LoginVO vo) throws Exception;
}
