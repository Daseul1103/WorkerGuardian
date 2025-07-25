package egovframework.example.safety.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import egovframework.example.safety.mapper.SafetyMapper;
import egovframework.example.safety.service.SafetyService;
import egovframework.example.safety.vo.SafetyVO;

@Service("safetyService")
@Transactional
public class SafetyServiceImpl implements SafetyService {
	
	// 의존성 주입
    @Resource(name = "safetyMapper")
    private SafetyMapper safetyMapper;
    
    
    // 안전 이벤트 조회
    public List<SafetyVO> safetyList(SafetyVO vo) throws Exception {
        return safetyMapper.safetyList(vo);
    }
}
