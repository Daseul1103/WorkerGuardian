package egovframework.example.main.mapper;

import java.util.List;

import egovframework.example.main.vo.MainVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mainMapper")
public interface MainMapper {
	
	// 현장 목록 생성하기
	List<MainVO> siteList(String paramString) throws Exception;
	 
	// 선택된 현장의 비콘 정보 가져오기
	List<MainVO> beaconInfo(String paramString) throws Exception;
	  
	// 선택된 현장 화면 정보 가져오기
	MainVO backgroundInfo(String paramString) throws Exception;
	
	List<MainVO> workerInfoList(String siteId) throws Exception;
	
	void insertTestData(MainVO vo) throws Exception;
	
}
