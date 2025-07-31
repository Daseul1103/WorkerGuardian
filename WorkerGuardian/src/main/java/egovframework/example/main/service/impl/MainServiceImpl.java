package egovframework.example.main.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import egovframework.example.main.mapper.MainMapper;
import egovframework.example.main.service.MainService;
import egovframework.example.main.vo.MainVO;

@Service("mainService")
@Transactional
public class MainServiceImpl implements MainService {

	// 의존성 주입
    @Resource(name = "mainMapper")
    private MainMapper mainMapper;

    
	// 현장 목록 생성하기
    @Override
    public List<MainVO> siteList(String org_id) throws Exception {
        return mainMapper.siteList(org_id);
    }

    
	// 선택된 현장의 비콘 정보 가져오기
    @Override
    public List<MainVO> beaconInfo(String siteId) throws Exception {
        return mainMapper.beaconInfo(siteId);
    }

    @Override
	public List<MainVO> workerInfoList(String siteId) throws Exception {
		return mainMapper.workerInfoList(siteId);
	}
    
	// 선택된 현장 화면 정보 가져오기
    @Override
    public MainVO backgroundInfo(String siteId) throws Exception {
        return mainMapper.backgroundInfo(siteId);
    }
    
    @Override
	public void insertTestData(MainVO vo) throws Exception {
    	mainMapper.insertTestData(vo);
    }
    
    
}

