package egovframework.example.gas.web;

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

import egovframework.example.gas.service.GasService;
import egovframework.example.gas.vo.GasVO;
import egovframework.example.login.vo.LoginVO;

@Controller
// 가스 센서 관리 컨트롤러
public class GasController {

	// 의존성 주입
    @Resource(name = "gasService")
    private GasService gasService;

    
    // 가스 센서 관리 초기 진입 화면 - 가스 센서 관리 메뉴 클릭 시 이동
    @RequestMapping(value="/gas/gasInventory.do")
    public ModelAndView GasMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/gas/inventory"); // 가스 센서 관리 목록으로 이동
        }
        return mav;
    }

    
    // 가스 센서 목록 생성하기
    @RequestMapping(value="/gas/selectGas.ajax")
    public ModelAndView gasSelect(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        List<GasVO> gasList = gasService.gasSelect();
        mav.addObject("GasList", gasList);
        
        return mav;
    }

    
    // 가스 센서 적용 작업자 선택하기
    @RequestMapping(value="/gas/selectWoker.ajax")
    public ModelAndView workerSelect(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        LoginVO loginUserInfo = (LoginVO) httpSession.getAttribute("LoginInfo");
        String org_id = loginUserInfo.getORG_ID();
        
        List<GasVO> workerList = gasService.selectWorker(org_id);
        
        mav.addObject("workerList", workerList);
        return mav;
    }

    
    // 가스 센서 상세 화면으로 이동
    @RequestMapping(value="/gas/gasDetail.do")
    public ModelAndView selectGasInfo(@RequestParam("gasId") String gasId, HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            List<GasVO> gasInfoList = gasService.gasInfoList(gasId);
            GasVO gasInfo = gasInfoList.get(0);
            
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.addObject("data", gasInfo);
            mav.setViewName("/gas/gasDetail"); // 가스 센서 관리 상세 화면으로 이동
        }
        return mav;
    }

    
    // 가스 센서 등록 화면으로 이동
    @RequestMapping(value="/gas/gasInsert.do")
    public ModelAndView workerInsert(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/gas/gasInsert"); // 가스 센서 등록 화면으로 이동
        }
        return mav;
    }
    
    
    // 가스 센서 등록하기
    @RequestMapping(value="/gas/gasSave.do")
    public ModelAndView beaconInsert(HttpSession httpSession, HttpServletRequest request, Model model, @ModelAttribute("GasVO") GasVO vo) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            String gasId = vo.getGAS_ID();
            gasService.insertGas(vo);
            
            mav.setViewName("redirect:/gas/gasDetail.do?gasId=" + gasId);  // 가스 센서 상세 화면으로 이동
        }
        return mav;
    }

    
    // 가스 센서 삭제하기
    @RequestMapping(value="/gas/gasDelete.do")
    public ModelAndView beaconDelete(@RequestParam("gasId") String gasId, HttpSession httpSession, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            gasService.deleteGasInfo(gasId);
            mav.setViewName("redirect:/gas/gasInventory.do");  // 가스 센서 목록으로 이동
        }
        return mav;
    }

    
    // 가스 센서 정보 수정으로 이동
    @RequestMapping(value="/gas/gasUpdate.do")
    public ModelAndView GasUpdate(@RequestParam("gasId") String gasId, HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            List<GasVO> gasInfoList = gasService.gasInfoList(gasId);
            GasVO gasInfo = gasInfoList.get(0);
            
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.addObject("data", gasInfo);
            mav.setViewName("/gas/gasUpdate"); // 가스 센서 정보 수정 화면으로 이동
        }
        return mav;
    }

    
    // 가스 센서 수정 정보 저장
    @RequestMapping(value="/gas/gasUpdateSave.do")
    public ModelAndView updateGas(HttpSession httpSession, HttpServletRequest request, Model model, @ModelAttribute GasVO vo) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            String gasId = vo.getGAS_ID();
            String workerId = vo.getGAS_WORKER_ID();
            
            if (workerId == null) {
                vo.setGAS_WORKER_ID("none");
            }
            
            gasService.updateGas(vo);
            
            mav.setViewName("redirect:/gas/gasDetail.do?gasId=" + gasId);  // 가스 센서 상세 화면으로 이동
        }
        return mav;
    }
    
    
}
