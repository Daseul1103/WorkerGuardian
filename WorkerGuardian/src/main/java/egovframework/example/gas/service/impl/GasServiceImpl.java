package egovframework.example.gas.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import egovframework.example.gas.mapper.GasMapper;
import egovframework.example.gas.service.GasService;
import egovframework.example.gas.vo.GasVO;

@Service("gasService")
@Transactional
public class GasServiceImpl implements GasService {

	// 의존성 주입
    @Resource(name = "gasMapper")
    private GasMapper gasMapper;
    

	// 가스 센서 관리 목록 생성
    @Override
    public List<GasVO> gasSelect() throws Exception {
        return gasMapper.gasSelect();
    }
    
    
    // 가스 센서 정보 가져오기
    @Override
    public List<GasVO> gasInfoList(String gasId) throws Exception {
        return gasMapper.gasInfoList(gasId);
    }
    
    
    // 가스 센서 등록, 수정 - 할당 작업자 정보 가져오기
    @Override
    public List<GasVO> selectWorker(String org_id) throws Exception {
        return gasMapper.selectWorker(org_id);
    }

    
    // 가스 센서 등록하기
    @Override
    public void insertGas(GasVO vo) throws Exception {
        gasMapper.insertGas(vo);
    }

    
    // 가스 센서 삭제하기
    @Override
    public void deleteGasInfo(String gasId) throws Exception {
        gasMapper.deleteGasInfo(gasId);
    }

    
    // 가스 센서 정보 수정하기
    @Override
    public void updateGas(GasVO vo) throws Exception {
        gasMapper.updateGas(vo);
    }
    
    
}

