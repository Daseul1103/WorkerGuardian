package egovframework.example.safety.web;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.example.login.vo.LoginVO;
import egovframework.example.safety.service.SafetyService;
import egovframework.example.safety.vo.SafetyVO;

@Controller
// 안전 이벤트 컨트롤러
public class SafetyController {

	// 의존성 주입
    @Resource(name = "safetyService")
    private SafetyService safetyService;

    
    
    @RequestMapping(value="/safeevent/safeEvent.do")
    public ModelAndView safeEventMapping(@ModelAttribute("SafetyVO") SafetyVO vo, HttpSession httpSession,
                                         HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성

        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃 
        } else {
        	String start_date = vo.getStart_date();
        	String end_date = vo.getEnd_date();
        	
        	if(start_date == null && end_date == null) { // 첫 진입 또는 조건 분기처리 실패로 조회 기간 값이 null인 경우 처리
        		LocalDate today = LocalDate.now(); 
        	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        	    String now_date = today.format(formatter);  // 현재 날짜 yyyy-mm-dd 형식으로 가져오기
        	    
        	    // vo에 setting
        	    vo.setStart_date(now_date);
        	    vo.setEnd_date(now_date);
        	    
        	    mav.addObject("today", now_date);
        	}
        	
        	// 조회에 필요한 정보 준비하기
            LoginVO loginUserInfo = (LoginVO) httpSession.getAttribute("LoginInfo");
            vo.setORG_ID(loginUserInfo.getORG_ID());
            
            // 안전 이벤트 조회하기
            List<SafetyVO> safetyList = safetyService.safetyList(vo);

            
            // 화면으로 넘길 데이터 & 데이터 넘길 화면 설정하기
            mav.addObject("loginInfo", loginUserInfo);
            mav.addObject("safetyList", safetyList);
            mav.addObject("searchType", vo);
            mav.setViewName("/safeevent/safeEvent");
        }

        // mav return
        return mav;
    }

    @RequestMapping(value="/safetyEvent/ExcellDownLoad.do")
    public String safeEventExcel(@ModelAttribute("SafetyVO") SafetyVO vo, HttpSession httpSession,
                                HttpServletRequest request, Model model) throws Exception {
        LoginVO loginUserInfo = (LoginVO) httpSession.getAttribute("LoginInfo");
        vo.setORG_ID(loginUserInfo.getORG_ID());

        List<SafetyVO> safetyList = safetyService.safetyList(vo);

        String start_date = vo.getStart_date().replace("-", "");
        String end_date = vo.getEnd_date().replace("-", "");
        
        String fileTitle = "안전이벤트(" + start_date + "~" + end_date + ").xls";
        
        model.addAttribute("mapping", "safeEventExcell");
        model.addAttribute("fileName",  fileTitle);  
        model.addAttribute("safetyList", safetyList);

        return "hssfExcel";
    }
}

