package egovframework.example.login.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import egovframework.example.login.mapper.LoginMapper;
import egovframework.example.login.service.LoginService;
import egovframework.example.login.vo.LoginVO;

@Service("loginService")
@Transactional
public class LoginServiceImpl implements LoginService {

	// 의존성 주입
    @Resource(name = "loginMapper")
    private LoginMapper loginMapper;

    
    // 로그인 정보 조회
    @Override
    public List<LoginVO> loginInfo(String user_id, String user_pw) throws Exception {
        return loginMapper.loginInfo(user_id, user_pw);
    }

    
    // 아이디 중복 확인
    @Override
    public List<LoginVO> idDupleChk(String idVal) throws Exception {
        return loginMapper.idDupleChk(idVal);
    }

    
    // 소속 회사 확인
    @Override
    public List<LoginVO> orgChk(String orgVal) throws Exception {
        return loginMapper.orgChk(orgVal);
    }

    
    // 회원가입 정보 저장
    @Override
    public void joinSave(LoginVO vo) throws Exception {
        loginMapper.joinSave(vo);
    }
    
    
    // 로그인 접속 시간 등록
    @Override
    public void insertLoginTime(String userId) throws Exception {
    	loginMapper.insertLoginTime(userId);
    }
    
    
}

