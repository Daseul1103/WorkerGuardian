package egovframework.example.beacon.web;

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

import egovframework.example.beacon.service.BeaconService;
import egovframework.example.beacon.vo.BeaconVO;
import egovframework.example.view.vo.ViewVO;

@Controller
// 비콘 관리 컨트롤러
public class BeaconController {

	// 의존성 주입
    @Resource(name = "beaconService")
    private BeaconService beaconService;

    
    // 비콘 관리 초기 진입 화면 - 비콘 관리 메뉴 클릭 시 이동
    @RequestMapping(value="/beacon/beaconInventory.do")
    public ModelAndView firstBeacon(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/beacon/inventory"); // 비콘 관리 목록으로 이동
        }
        return mav;
    }

    
    // 비콘 관리 목록 생성
    @RequestMapping(value="/beacon/selectBeacon.ajax")
    public ModelAndView beaconSelect(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            List<BeaconVO> beaconList = beaconService.beaconSelect();
            mav.addObject("BeaconList", beaconList);
        }
        return mav;
    }

    
    // 비콘 관리 상세 화면으로 이동
    @RequestMapping(value="/beacon/beaconDetail.do")
    public ModelAndView selectBeaconInfo(@RequestParam("uuid") String uuid, HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            List<BeaconVO> beaconInfoList = beaconService.beaconInfoList(uuid);
            BeaconVO beaconInfo = beaconInfoList.get(0);
            
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.addObject("data", beaconInfo);
            mav.setViewName("/beacon/beaconDetail"); // 비콘 상세 화면으로 이동
        }
        return mav;
    }

    
    // 비콘 삭제하기
    @RequestMapping(value="/beacon/beaconDelete.do")
    public ModelAndView beaconDelete(@RequestParam("uuid") String uuid, HttpSession httpSession, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            beaconService.deleteBeaconInfo(uuid);
            mav.setViewName("redirect:/beacon/beaconInventory.do"); // 비콘 목록으로 이동
        }
        return mav;
    }

    
    
    // 비콘 등록 화면으로 이동
    @RequestMapping(value="/beacon/beaconInsert.do")
    public ModelAndView beaconInsert(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/beacon/beaconInsert"); // 비콘 등록 화면으로 이동
        }
        return mav;
    }

    
    // 비콘 등록 및 수정 - 적용 현장 선택
    @RequestMapping(value="/beacon/selectStie.ajax")
    public ModelAndView siteSelect(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        List<ViewVO> siteList = beaconService.selectSite();
        
        mav.addObject("siteList", siteList);
        return mav;
    }

    
    // 비콘 등록하기
    @RequestMapping(value="/beacon/beaconSave.do")
    public ModelAndView beaconInsert(HttpSession httpSession, HttpServletRequest request, Model model, @ModelAttribute("BeaconVO") BeaconVO vo) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            String uuid = vo.getUUID();
            beaconService.insertBeacon(vo);
            
            mav.setViewName("redirect:/beacon/beaconDetail.do?uuid=" + uuid);  // 비콘 상세 화면으로 이동
        }
        return mav;
    }

    
    // 비콘 수정 화면으로 이동
    @RequestMapping(value="/beacon/beaconUpdate.do")
    public ModelAndView viewUpdate(@RequestParam("uuid") String uuid, HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            List<BeaconVO> beaconInfoList = beaconService.beaconInfoList(uuid);
            BeaconVO beaconInfo = beaconInfoList.get(0);
            
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.addObject("data", beaconInfo);
            mav.setViewName("/beacon/beaconUpdate"); // 비콘 수정 화면으로 이동
        }
        return mav;
    }

    
    // 비콘 수정 저장하기
    @RequestMapping(value="/beacon/beaconUpdateSave.do")
    public ModelAndView updateNotice(HttpSession httpSession, HttpServletRequest request, Model model, @ModelAttribute BeaconVO vo) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView"); // ModelAndView 객체 생성
        
        // 로그인 세션 확인하기
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do"); // 로그인 세션 없는 경우 강제 로그아웃
        } else {
            String uuid = vo.getUUID();
            String siteId = vo.getSITE_ID();
            
            if (siteId == null) {
                vo.setSITE_ID("none");
            }
            
            beaconService.updateBeacon(vo);
            mav.setViewName("redirect:/beacon/beaconDetail.do?uuid=" + uuid);  // 비콘 상세 화면으로 이동
        }
        return mav;
    }
    
    
}
