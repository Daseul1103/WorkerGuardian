package egovframework.example.mypage.web;

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
import egovframework.example.mypage.service.MypageService;
import egovframework.example.mypage.vo.MypageVO;

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
        	
        	if(httpSession.getAttribute("IdentityInfo") == null) {
        		mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
        		mav.setViewName("/mypage/Identity_verification");      		
        	} else {
        		LoginVO loginSessionList = (LoginVO) httpSession.getAttribute("LoginInfo");       	
            	String userId = loginSessionList.getUSER_ID();
            	
            	MypageVO loginTimeList = mypageService.loginTimeList(userId);
            	
            	if(loginTimeList != null) {  // 첫 접속이 아닌 경우
                	String formattDate = loginTimeList.getLOGIN_TIME();  // date 타입 포맷팅
                	formattDate = formattDate.substring(0, formattDate.length() - 2);
                	
                	loginTimeList.setLOGIN_TIME(formattDate);
            	} 
            	
            	mav.addObject("loginTimeList", loginTimeList);
            	mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            	mav.setViewName("/mypage/inventory");
        	}

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
  
        // 로그인 세션 확인하기
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
    
    
    
    // 마이페이지 - 본인 확인
    @RequestMapping(value="/mypage/identity.do")
    public ModelAndView identityMypage(@RequestParam("USER_PW") String password, HttpSession httpSession, HttpServletRequest request)
    throws Exception {
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
    		LoginVO loginInfo = (LoginVO) httpSession.getAttribute("LoginInfo"); // 로그인 세션 정보 가져오기
    		String getUserId = loginInfo.getUSER_ID(); // 현재 로그인된 사용자의 아이디 가져오기
    		
    		LoginVO identityVO = new LoginVO(); // 새로운 객체 생성
    		identityVO.setUSER_ID(getUserId); // 새로운 객체에 사용자 아이디 주입
    		identityVO.setUSER_PW(password); // 새로운 객체에 비밀번호 확인 주입
    		
    		List<LoginVO> identityPw = mypageService.identityPw(identityVO);  // 주입한 정보로 일치하는지 확인

    		if(identityPw.size() != 0) { // 결과가 0 보다 크다면(비밀번호 확인 일치함)
    			// 일치한 경우 세션에 본인 확인 인증 저장하기
    			LoginVO identityInfo = identityPw.get(0);
                httpSession.setAttribute("IdentityInfo", identityInfo);
                
    			mav.setViewName("redirect:/mypage/agreement.do");
    		} else { // 결과가 0이라면 (비밀번호 확인 불일치함)
    			mav.setViewName("redirect:/mypage/notAgreement.do");
    		}
    		
    	}
    	
    	return mav;
    }
    
    
    
    // 비밀번호 확인 했을 시 화면 처리
    @RequestMapping(value="/mypage/agreement.do")
    public ModelAndView agreementMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        mav.setViewName("/common/agreement"); 
        return mav;
    }
    
    
    // 비밀번호 불일치 했을 시 화면 처리
    @RequestMapping(value="/mypage/notAgreement.do")
    public ModelAndView noAgreementMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        mav.setViewName("/common/notAgreement"); 
        return mav;
    }
    
    
}

