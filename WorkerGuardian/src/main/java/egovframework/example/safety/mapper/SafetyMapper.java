package egovframework.example.safety.mapper;

import java.util.List;

import egovframework.example.safety.vo.SafetyVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("safetyMapper")
public interface SafetyMapper {
	
	// 안전 이벤트 조회
    List<SafetyVO> safetyList(SafetyVO paramSafetyVO) throws Exception;
}
