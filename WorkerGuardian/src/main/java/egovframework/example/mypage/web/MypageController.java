package egovframework.example.mypage.web;

import egovframework.example.login.vo.LoginVO;
import egovframework.example.mypage.service.MypageService;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
// 마이페이지 관리 컨트롤러
public class MypageController {

	// 의존성 주입
    @Resource(name = "mypageService")
    private MypageService mypageService;

    
    // 마이페이지 관리 화면으로 이동(내 정보) - 마이페이지 버튼 클릭 시 이동
    @RequestMapping(value="/mypage/mypageGo.do")
    public ModelAndView mypageMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성

        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/mypage/inventory"); // 내 정보로 이동
        }

        return mav;
    }

    
    // 내 정보 수정 화면으로 이동
    @RequestMapping(value="/mypage/mypageUpdateGo.do")
    public ModelAndView mypageUpdateMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성

        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/mypage/myInfoUpdate");  // 내 정보 수정으로 이동
        }

        return mav;
    }

    
    // 내 정보 수정하기
    @RequestMapping(value="/mypage/updateInfoSave.do")
    public ModelAndView myInfoSave(HttpSession httpSession, HttpServletRequest request, Model model,
                                   @ModelAttribute LoginVO vo) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성      // 로그인 세션 없는 경우 강제 로그아웃
  
        // 로그인 세션 확인하기s
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            LoginVO infoVO = (LoginVO) httpSession.getAttribute("LoginInfo");
            vo.setUSER_ID(infoVO.getUSER_ID());

            mypageService.infoSave(vo);

            LoginVO loginInfo = mypageService.loginInfo(vo);
            String orgName = infoVO.getUSER_ORG();
            loginInfo.setUSER_ORG(orgName);

            httpSession.setAttribute("LoginInfo", loginInfo);
            mav.addObject("loginInfo", loginInfo);
            mav.setViewName("redirect:/mypage/mypageGo.do");  // 내 정보로 이동
        }

        return mav;
    }
    
    
}

