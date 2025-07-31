package egovframework.example.main.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.example.login.vo.LoginVO;
import egovframework.example.main.service.MainService;
import egovframework.example.main.vo.MainVO;

@Controller
// 비콘 모니터링 관리 컨트롤러
public class MainController {

	// 의존성 주입
    @Resource(name = "mainService")
    private MainService mainService;
    
    
    // 비콘 모니터링 화면으로 이동 ( 로그인 시 첫 진입 화면 ) - 비콘 모니터링 메뉴 클릭 시 이동
    @RequestMapping(value="/first.do")
    public ModelAndView mainMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성

        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/monitering/main"); // 비콘 모니터링 화면으로 이동
        }

        return mav;
    }

    
    // 현장 목록 생성하기
    @RequestMapping(value="/main/siteInfo.ajax")
    public ModelAndView siteInfo(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성

        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            LoginVO loginUserInfo = (LoginVO) httpSession.getAttribute("LoginInfo");
            String org_id = loginUserInfo.getORG_ID();
            
            List<MainVO> siteList = mainService.siteList(org_id);
            
            mav.addObject("siteList", siteList);
        }

        return mav;
    }

    
    // 선택된 현장의 비콘 정보 가져오기
    @RequestMapping(value="/main/selectBeaconInfo.ajax")
    public ModelAndView selectBeaconInfo(
        @RequestParam("siteId") String siteId,
        HttpSession httpSession,
        HttpServletRequest request,
        Model model
    ) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성

        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            List<MainVO> beaconInfoList = mainService.beaconInfo(siteId);
            MainVO background = mainService.backgroundInfo(siteId);
            
            LoginVO loginInfo = (LoginVO) httpSession.getAttribute("LoginInfo");
            String orgId = loginInfo.getORG_ID();
            
            List<MainVO> workerInfoList = mainService.workerInfoList(siteId);
            
            mav.addObject("workerInfoList", workerInfoList); // 작업자 정보
            mav.addObject("BeaconInfoList", beaconInfoList);  // 비콘 정보
            mav.addObject("background", background);
            mav.addObject("OrgId", orgId); // 회사 id
        }

        return mav;
    }
    
    
    
    @RequestMapping(value="/main/insertTestData.ajax")
    public ModelAndView testDataInsert(HttpSession httpSession, HttpServletRequest request, Model model
    		, @ModelAttribute MainVO vo ) throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
    	
    	mainService.insertTestData(vo);
    	
    	return mav;
    }
    
}
