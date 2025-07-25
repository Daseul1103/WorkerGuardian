package egovframework.example.safety.service;

import java.util.List;

import egovframework.example.safety.vo.SafetyVO;

public interface SafetyService {
	
	// 안전 이벤트 조회
    List<SafetyVO> safetyList(SafetyVO paramSafetyVO) throws Exception;
}
