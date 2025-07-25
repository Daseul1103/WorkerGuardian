package egovframework.example.view.web;

import egovframework.example.view.service.ViewService;
import egovframework.example.view.vo.ViewVO;
import egovframework.example.view.vo.nFileVO;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
// 현장 관리 컨트롤러
public class ViewController implements ApplicationContextAware {

    private WebApplicationContext context = null;

    // 의존성 주입
    @Resource(name = "viewService")
    private ViewService viewService;

    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.context = (WebApplicationContext) applicationContext;
    }

    
    // 현장 관리 초기 화면 진입 - 현장 관리 메뉴 클릭 시 이동
    @RequestMapping(value="/view/viewInventory.do")
    public ModelAndView ViewMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/view/inventory");
        }
        return mav;
    }

    
    // 현장 관리 목록 생성하기
    @RequestMapping(value="/view/selectSite.ajax")
    public ModelAndView siteSelect(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else { 
            List<ViewVO> SiteList = viewService.siteSelect();
            mav.addObject("SiteList", SiteList);
        }
        return mav;
    }

    
    // 현장 상세 화면으로 이동
    @RequestMapping(value="/view/siteDetail.do")
    public ModelAndView selectSiteInfo(@RequestParam("siteId") String siteId, HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            List<ViewVO> viewInfoList = viewService.viewInfoList(siteId);
            List<ViewVO> limitList = viewService.limitList(siteId);
            
            ViewVO viewInfo = viewInfoList.get(0);
            
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.addObject("data", viewInfo);
            mav.addObject("limitList", limitList);
            mav.setViewName("/view/viewDetail");  // 현장 상세 화면으로 이동
        }
        return mav;
    }

    
    // 현장 파일 다운로드
    @RequestMapping(value="/view/fileDownload.do")
    public ModelAndView fileDownload(@RequestParam("fileId") String fileId, HttpSession httpSession, ModelAndView mView, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 로그인 세션 확인하기
    	if (httpSession.getAttribute("LoginInfo") == null) {
            mView.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            ViewVO fvo = new ViewVO();
            fvo.setFILE_ID(fileId);
            fvo = viewService.selectFileList(fvo).get(0);
            
            String filePath = String.valueOf(fvo.getFILE_DIR()) + fvo.getFILE_NAME();
            fvo.setFilePath(filePath);
            
            mView.addObject("fvo", fvo);
            mView.setViewName("fileDownView");
        }
        return mView;
    }
    
    
    // 도움말 자료 다운로드 - 도움말 버튼 클릭 시 실행
    @RequestMapping(value="/view/helpDownload.do")
    public ModelAndView helpfileDownload(ModelAndView mView, HttpServletRequest request, HttpSession httpSession, HttpServletResponse response) throws Exception {
        
        // 로그인 세션 확인하기
    	if (httpSession.getAttribute("LoginInfo") == null) {
            mView.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            mView.setViewName("fileDownHelp");
        }
        return mView;
    }
    
    

    // 현장 정보 수정으로 이동
    @RequestMapping(value="/view/viewUpdate.do")
    public ModelAndView ViewUpdate(@RequestParam("siteId") String siteId, HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            List<ViewVO> viewInfoList = viewService.viewInfoList(siteId);
            ViewVO viewInfo = viewInfoList.get(0);
            
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.addObject("data", viewInfo);
            mav.setViewName("/view/viewUpdate"); // 현장 정보 수정으로 이동
        }
        return mav;
    }

    
    // 현장 정보 수정하기
    @RequestMapping(value="/view/siteUpdate.do")
    public ModelAndView updateNotice(@RequestParam("multiFile") List<MultipartFile> multiFileList, HttpSession httpSession, HttpServletRequest request, Model model, @ModelAttribute ViewVO vo, @RequestParam("fileUpType") String fileUptype) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            viewService.updateSite(vo);
            
            String siteId = vo.getSITE_ID();
            String fileName = vo.getFILE_NAME();
            
            if (fileUptype.equals("Y")) {
                String fileDir = String.valueOf(context.getServletContext().getRealPath("/")) + "siteFile/" + siteId + "/";
                
                FileUploadSave fus = new FileUploadSave();
                
                viewService.siteInfoDelete(vo);
                
                fus.udeleteFileOne(fileDir, fileName);
                
                List<nFileVO> fileList = fus.fileUploadMultiple(multiFileList, fileDir, vo);
                
                if (fileList.size() != 0) {
                	viewService.updateFile(fileList.get(0));
                }
                    
            }
            mav.setViewName("redirect:/view/siteDetail.do?siteId=" + siteId);  // 현장 상세 화면으로 이동
        }
        return mav;
    }

    
    // 현장 등록으로 이동
    @RequestMapping(value="/view/viewInsert.do")
    public ModelAndView ViewInsert(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/view/viewInsert"); // 현장 등록으로 이동하기
        }
        return mav;
    }

    
    // 현장 등록하기
    @RequestMapping(value="/view/siteInsert.do")
    public ModelAndView siteInsert(@RequestParam("multiFile") List<MultipartFile> multiFileList, HttpSession httpSession, HttpServletRequest request, Model model, @ModelAttribute("ViewVO") ViewVO vo) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            viewService.insertView(vo);
            String nowSiteId = viewService.selectViewId();
            try {
                String fileDir = String.valueOf(context.getServletContext().getRealPath("/")) + "siteFile/" + nowSiteId + "/";
                FileUploadSave fus = new FileUploadSave();
                
                List<nFileVO> fileList = fus.fileUploadMultiple(multiFileList, fileDir, vo);
                
                if (fileList.size() != 0) {
                	viewService.insertFile(fileList.get(0));
                }
                
                mav.setViewName("redirect:/view/viewInventory.do");  // 현장 관리 목록으로 이동
            } catch (Exception exception) {
                // 무시
            }
        }
        return mav;
    }

    
    // 현장 삭제하기
    @RequestMapping(value="/view/siteDelete.do")
    public ModelAndView siteDelete(HttpSession httpSession, @RequestParam("siteId") String siteId) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            String fileName = viewService.getFileName(siteId);
            String fileDir = String.valueOf(context.getServletContext().getRealPath("/")) + "siteFile/" + siteId + "/";
            
            FileUploadSave fus = new FileUploadSave();
            
            fus.ndeleteFileOne(fileDir, fileName);
            
            this.viewService.deleteFileInfo(siteId);
            this.viewService.deleteSiteInfo(siteId);
            
            mav.setViewName("redirect:/view/viewInventory.do");  // 현장 관리 목록으로 이동
        }
        return mav;
    }
}

