package egovframework.example.view.mapper;

import java.util.List;

import egovframework.example.view.vo.ViewVO;
import egovframework.example.view.vo.nFileVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("viewMapper")
public interface ViewMapper {

	// 현장 목록 생성하기
    List<ViewVO> siteSelect() throws Exception;

    
    // 선택 된 현장 정보 가져오기
    List<ViewVO> siteSelectInfo(String paramString) throws Exception;

    
    // 선택 된 현장의 파일 정보 가져오기
    List<ViewVO> siteSelectfile(String paramString) throws Exception;

    
    // 선택 된 현장의 파일 정보 가져오기
    List<ViewVO> selectFileList(ViewVO paramViewVO) throws Exception;

    
    // 현장 등록하기
    void insertView(ViewVO paramViewVO) throws Exception;

    
    // 현장 id 가져오기
    String selectViewId() throws Exception;

    
    // 현장 파일 등록하기
    void insertFile(nFileVO paramnFileVO) throws Exception;

    
    // 현장 파일 정보 삭제하기
    void deleteFileInfo(String paramString) throws Exception;

    
    // 현장 삭제하기
    void deleteSiteInfo(String paramString) throws Exception;

    
    // 파일명 가져오기
    String getFileName(String paramString) throws Exception;

    
    // 현장 정보 가져오기
    List<ViewVO> viewInfoList(String paramString) throws Exception;

    
    List<ViewVO> limitList(String paramString) throws Exception;

    
    // 현장 정보 업데이트 하기
    void updateSite(ViewVO paramViewVO) throws Exception;

    
    // 현장 파일 정보 업데이트 하기
    void updateFile(nFileVO paramnFileVO) throws Exception;

    
    // 현장 정보 삭제하기
    void siteInfoDelete(ViewVO paramViewVO) throws Exception;
}
