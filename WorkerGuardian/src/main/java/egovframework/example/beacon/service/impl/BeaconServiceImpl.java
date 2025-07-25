package egovframework.example.beacon.service.impl;

import egovframework.example.beacon.mapper.BeaconMapper;
import egovframework.example.beacon.service.BeaconService;
import egovframework.example.beacon.vo.BeaconVO;
import egovframework.example.view.vo.ViewVO;
import java.util.List;
import javax.annotation.Resource;
import javax.transaction.Transactional;
import org.springframework.stereotype.Service;

@Service("beaconService")
@Transactional
public class BeaconServiceImpl implements BeaconService {

	// 의존성 주입
    @Resource(name = "beaconMapper")
    private BeaconMapper beaconMapper;

    
    // 비콘 관리 목록 생성
    @Override
    public List<BeaconVO> beaconSelect() throws Exception {
        return beaconMapper.beaconSelect();
    }

    
    // 비콘 정보 가져오기
    @Override
    public List<BeaconVO> beaconInfoList(String uuid) throws Exception {
        return beaconMapper.beaconInfoList(uuid);
    }

    
    // 비콘 삭제하기
    @Override
    public void deleteBeaconInfo(String uuid) throws Exception {
        beaconMapper.deleteBeaconInfo(uuid);
    }

    
    // 비콘 등록 및 수정 - 적용 현장 정보 가져오기
    @Override
    public List<ViewVO> selectSite() throws Exception {
        return beaconMapper.selectSite();
    }

    
    // 비콘 등록하기
    @Override
    public void insertBeacon(BeaconVO vo) throws Exception {
        beaconMapper.insertBeacon(vo);
    }

    
    // 비콘 정보 수정하기
    @Override
    public void updateBeacon(BeaconVO vo) throws Exception {
        beaconMapper.updateBeacon(vo);
    }
    
}

