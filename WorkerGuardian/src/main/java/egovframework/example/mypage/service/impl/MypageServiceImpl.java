package egovframework.example.mypage.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import egovframework.example.login.vo.LoginVO;
import egovframework.example.mypage.mapper.MypageMapper;
import egovframework.example.mypage.service.MypageService;
import egovframework.example.mypage.vo.MypageVO;

@Service("mypageService")
@Transactional
public class MypageServiceImpl implements MypageService {

	// 의존성 주입
    @Resource(name = "mypageMapper")
    private MypageMapper mypageMapper;

    
    @Override
    // 사용자 정보 수정 저장
    public void infoSave(LoginVO vo) throws Exception {
        mypageMapper.infoSave(vo);
    }

    @Override
    // 사용자 정보 조회
    public LoginVO loginInfo(LoginVO vo) throws Exception {
        return mypageMapper.loginInfo(vo);
    }
    
    
    // 사용자 최근 접속 시간 가져오기
    @Override
    public MypageVO loginTimeList(String userId) throws Exception {
    	return mypageMapper.loginTimeList(userId);
    }
    
    
    // 마이페이지 본인 확인
    @Override
    public List<LoginVO> identityPw(LoginVO vo) throws Exception {
    	return mypageMapper.identityPw(vo);
    }
    
    
}
