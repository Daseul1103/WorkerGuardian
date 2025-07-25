package egovframework.example.view.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import egovframework.example.view.mapper.ViewMapper;
import egovframework.example.view.service.ViewService;
import egovframework.example.view.vo.ViewVO;
import egovframework.example.view.vo.nFileVO;

@Service("viewService")
@Transactional
public class ViewServiceImpl implements ViewService {

	// 의존성 주입
    @Resource(name = "viewMapper")
    private ViewMapper viewMapper;

    
    @Override
	// 현장 목록 생성하기
    public List<ViewVO> siteSelect() throws Exception {
        return viewMapper.siteSelect();
    }

    @Override
    // 선택 된 현장 정보 가져오기
    public List<ViewVO> siteSelectInfo(String nowId) throws Exception {
        return viewMapper.siteSelectInfo(nowId);
    }

    @Override
    // 선택 된 현장의 파일 정보 가져오기
    public List<ViewVO> siteSelectfile(String nowId) throws Exception {
        return viewMapper.siteSelectfile(nowId);
    }

    @Override
    // 선택 된 현장의 파일 정보 가져오기
    public List<ViewVO> selectFileList(ViewVO vo) throws Exception {
        return viewMapper.selectFileList(vo);
    }

    @Override
    // 현장 등록하기
    public void insertView(ViewVO vo) throws Exception {
        viewMapper.insertView(vo);
    }

    @Override
    // 현장 id 가져오기
    public String selectViewId() throws Exception {
        return viewMapper.selectViewId();
    }

    @Override
    // 현장 파일 등록하기
    public void insertFile(nFileVO fileVO) throws Exception {
        viewMapper.insertFile(fileVO);
    }

    @Override
    // 현장 파일 정보 삭제하기
    public void deleteFileInfo(String siteId) throws Exception {
        viewMapper.deleteFileInfo(siteId);
    }

    @Override
    // 현장 삭제하기
    public void deleteSiteInfo(String siteId) throws Exception {
        viewMapper.deleteSiteInfo(siteId);
    }

    @Override
    // 파일명 가져오기
    public String getFileName(String siteId) throws Exception {
        return viewMapper.getFileName(siteId);
    }

    @Override
    // 현장 정보 가져오기
    public List<ViewVO> viewInfoList(String siteId) throws Exception {
        return viewMapper.viewInfoList(siteId);
    }

    @Override
    public List<ViewVO> limitList(String siteId) throws Exception {
        return viewMapper.limitList(siteId);
    }

    @Override
    // 현장 정보 업데이트 하기
    public void updateSite(ViewVO vo) throws Exception {
        viewMapper.updateSite(vo);
    }

    @Override
    // 현장 파일 정보 업데이트 하기
    public void updateFile(nFileVO fileVO) throws Exception {
        viewMapper.updateFile(fileVO);
    }

    @Override
    // 현장 정보 삭제하기
    public void siteInfoDelete(ViewVO vo) throws Exception {
        viewMapper.siteInfoDelete(vo);
    }
}