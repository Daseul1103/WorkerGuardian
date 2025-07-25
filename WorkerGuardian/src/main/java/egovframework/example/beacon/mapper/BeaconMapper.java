package egovframework.example.beacon.mapper;

import egovframework.example.beacon.vo.BeaconVO;
import egovframework.example.view.vo.ViewVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import java.util.List;

@Mapper("beaconMapper")
public interface BeaconMapper {

	// 비콘 관리 목록 생성
    List<BeaconVO> beaconSelect() throws Exception;

    
    // 비콘 정보 가져오기
    List<BeaconVO> beaconInfoList(String uuid) throws Exception;

    
    // 비콘 삭제하기
    void deleteBeaconInfo(String uuid) throws Exception;

    
    // 비콘 등록 및 수정 - 적용 현장 정보 가져오기
    List<ViewVO> selectSite() throws Exception;

    
    // 비콘 등록하기
    void insertBeacon(BeaconVO beaconVO) throws Exception;

    
    // 비콘 정보 수정하기
    void updateBeacon(BeaconVO beaconVO) throws Exception;
}

