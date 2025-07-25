package egovframework.example.safety.web;

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
            LoginVO loginUserInfo = (LoginVO) httpSession.getAttribute("LoginInfo");
            vo.setORG_ID(loginUserInfo.getORG_ID());
            List<SafetyVO> safetyList = safetyService.safetyList(vo);

            mav.addObject("loginInfo", loginUserInfo);
            mav.addObject("safetyList", safetyList);
            mav.addObject("searchType", vo);
            mav.setViewName("/safeevent/safeEvent");
        }

        return mav;
    }

    @RequestMapping(value="/safetyEvent/ExcellDownLoad.do")
    public String safeEventExcel(@ModelAttribute("SafetyVO") SafetyVO vo, HttpSession httpSession,
                                HttpServletRequest request, Model model) throws Exception {
        LoginVO loginUserInfo = (LoginVO) httpSession.getAttribute("LoginInfo");
        vo.setORG_ID(loginUserInfo.getORG_ID());

        List<SafetyVO> safetyList = safetyService.safetyList(vo);

        model.addAttribute("mapping", "safeEventExcell");
        model.addAttribute("fileName", "안전 이벤트.xls");  
        model.addAttribute("safetyList", safetyList);

        return "hssfExcel";
    }
}

