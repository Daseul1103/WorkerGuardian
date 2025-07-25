package egovframework.example.gas.mapper;

import egovframework.example.gas.vo.GasVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import java.util.List;

@Mapper("gasMapper")
public interface GasMapper {
	
	// 가스 센서 관리 목록 생성
    List<GasVO> gasSelect() throws Exception;

    
    // 가스 센서 정보 가져오기
    List<GasVO> gasInfoList(String paramString) throws Exception;

    
    // 가스 센서 등록, 수정 - 할당 작업자 정보 가져오기
    List<GasVO> selectWorker(String paramString) throws Exception;

    
    // 가스 센서 등록하기
    void insertGas(GasVO paramGasVO) throws Exception;

    
    // 가스 센서 삭제하기
    void deleteGasInfo(String paramString) throws Exception;

    
    // 가스 센서 정보 수정하기
    void updateGas(GasVO paramGasVO) throws Exception;
}
