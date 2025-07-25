package egovframework.example.login.web;

import java.util.List;


import egovframework.example.login.service.LoginService;
import egovframework.example.login.vo.LoginVO;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
// 로그인 관리 컨트롤러
public class LoginController {

	// 의존성 주입
    @Resource(name = "loginService")
    private LoginService loginService;

    
    // 로그인 화면 - 웹 페이지 진입 시 초기 화면 (index.jps -> login)
    @RequestMapping(value="/login/login.do")
    public ModelAndView loginMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        mav.setViewName("/login/login");  // 로그인 화면으로 이동
        return mav;
    }

    
    // 세션이 없거나 끊겼을 경우 강제 로그아웃
    @RequestMapping(value="/login/notSession.do")
    public ModelAndView noSessionMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        mav.setViewName("/common/notSession"); // 강제 로그아웃 화면으로 이동
        return mav;
    }

    
    // 로그인 화면에서 로그인 버튼 눌렀을 시 - 로그인 정보 조회
    @RequestMapping(value="/login/loginUser.ajax")
    public ModelAndView loginControll(
            @RequestParam("user_id") String user_id,
            @RequestParam("user_pw") String user_pw,
            HttpSession httpSession,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        List<LoginVO> loginInfoList = loginService.loginInfo(user_id, user_pw);
        
        if (loginInfoList.isEmpty()) {
            mav.addObject("msg", "noInfo");
        } else {
            LoginVO loginInfo = loginInfoList.get(0);
            httpSession.setAttribute("LoginInfo", loginInfo);
            
            mav.addObject("msg", "success");
        }
        return mav;
    }

    
    // 사용자 로그아웃하기
    @RequestMapping(value="/login/logoutUser.do")
    public ModelAndView logout(HttpSession httpSession, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        httpSession.removeAttribute("LoginInfo"); // 세션에 저장된 로그인 정보 삭제
        mav.setViewName("redirect:/login/login.do"); // 로그인 화면(첫 진입 화면)으로 이동
        
        return mav;
    }

    
    // 회원가입 화면으로 이동
    @RequestMapping(value="/login/join.do")
    public ModelAndView joinMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        mav.setViewName("/login/join");  // 회원 가입 화면으로 이동
        return mav;
    }

    
    // 회원가입 - 아이디 중복 확인하기
    @RequestMapping(value="/login/idDupleChk.ajax")
    public ModelAndView dupleChk(
            @RequestParam("idVal") String idVal,
            HttpSession httpSession,
            HttpServletRequest request,
            Model model) throws Exception {

        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        List<LoginVO> idDupleChkList = loginService.idDupleChk(idVal);
        mav.addObject("chkMsg", idDupleChkList.isEmpty() ? "ok" : "no");
        
        return mav;
    }

    
    // 회원가입 - 소속회사 확인하기
    @RequestMapping(value="/login/orgChk.ajax")
    public ModelAndView orgChk(
            @RequestParam("orgVal") String orgVal,
            HttpSession httpSession,
            HttpServletRequest request,
            Model model) throws Exception {

        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        List<LoginVO> orgChkList = loginService.orgChk(orgVal);
        mav.addObject("chkMsg", orgChkList.isEmpty() ? "no" : "ok");
        
        return mav;
    }

    
    // 회원가입 하기
    @RequestMapping(value="/login/joinSave.do")
    public ModelAndView joinSave(
            HttpSession httpSession,
            HttpServletRequest request,
            Model model,
            @ModelAttribute("LoginVO") LoginVO vo) throws Exception {

        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        loginService.joinSave(vo);
        mav.setViewName("redirect:/common/okJoin.do");  // 회원가입 확인 화면으로 이동
        
        return mav;
    }
    
    
    // 회원 가입 확인 화면으로 이동
    @RequestMapping(value="/common/okJoin.do")
    public ModelAndView joinMsgMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        mav.setViewName("/common/okJoin"); // 회원가입 확인 화면으로 이동 -> 확인 클릭 시 로그인 화면으로 이동
        return mav;
    }
    
    
}

