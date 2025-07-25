package egovframework.example.mypage.mapper;

import egovframework.example.login.vo.LoginVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mypageMapper")
public interface MypageMapper {

    // 사용자 정보 수정 저장
    void infoSave(LoginVO paramLoginVO) throws Exception;

    // 사용자 정보 조회
    LoginVO loginInfo(LoginVO paramLoginVO) throws Exception;
}
