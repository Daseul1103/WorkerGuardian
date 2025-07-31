package egovframework.example.worker.web;

import egovframework.example.worker.service.WorkerService;
import egovframework.example.worker.vo.WorkerVO;
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

@Controller
// 작업자 관리 컨트롤러
public class WorkerController {

	// 의존성 주입
    @Resource(name = "workerService")
    private WorkerService workerService;

    
    // 작업자 관리 목록 화면으로 이동 - 작업자 관리 메뉴 클릭 시 이동
    @RequestMapping("/worker/workerInventory.do")
    public ModelAndView WorkerMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do");
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/worker/inventory");
        }
        return mav;
    }

    @RequestMapping("/worker/selectWorker.ajax")
    public ModelAndView workerSelect(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do");
        } else {
            List<WorkerVO> WorkerList = workerService.workerSelect();
            mav.addObject("WorkerList", WorkerList);
        }
        return mav;
    }

    @RequestMapping("/worker/workerDetail.do")
    public ModelAndView selectWorkerInfo(@RequestParam("workerId") String workerId, HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do");
        } else {
            List<WorkerVO> workerInfoList = workerService.workerInfoList(workerId);
            WorkerVO workerInfo = workerInfoList.get(0);
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.addObject("data", workerInfo);
            mav.setViewName("/worker/workerDetail");
        }
        return mav;
    }

    @RequestMapping("/worker/workerDelete.do")
    public ModelAndView beaconDelete(HttpSession httpSession, @RequestParam("workerId") String workerId) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do");
        } else {
            workerService.deleteWorkerInfo(workerId);
            mav.setViewName("redirect:/worker/workerInventory.do");
        }
        return mav;
    }

    @RequestMapping("/worker/workerInsert.do")
    public ModelAndView workerInsert(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do");
        } else {
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.setViewName("/worker/workerInsert");
        }
        return mav;
    }

    @RequestMapping("/worker/workerSave.do")
    public ModelAndView workerSave(HttpSession httpSession, HttpServletRequest request, Model model, @ModelAttribute("WorkerVO") WorkerVO vo) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do");
        } else {
            String workerId = vo.getWORKER_PHONE();
            String formatted = workerId.substring(0, 3) + "-" + workerId.substring(3, 7) + "-" + workerId.substring(7);
            vo.setWORKER_ID(workerId);
            vo.setWORKER_PHONE(formatted);

            String flagF = vo.getAPPLY_FUNCTION_F();
            String flagG = vo.getAPPLY_FUNCTION_G();
            String flagL = vo.getAPPLY_FUNCTION_L();
            String No = "N";

            if (flagF == null) vo.setAPPLY_FUNCTION_F(No);
            if (flagG == null) vo.setAPPLY_FUNCTION_G(No);
            if (flagL == null) vo.setAPPLY_FUNCTION_L(No);

            workerService.insertWorker(vo);
            mav.setViewName("redirect:/worker/workerDetail.do?workerId=" + workerId);
        }
        return mav;
    }

    @RequestMapping("/worker/workerUpdate.do")
    public ModelAndView ViewUpdate(@RequestParam("workerId") String workerId, HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do");
        } else {
            List<WorkerVO> workerInfoList = workerService.workerInfoList(workerId);
            WorkerVO workerInfo = workerInfoList.get(0);
            mav.addObject("loginInfo", httpSession.getAttribute("LoginInfo"));
            mav.addObject("data", workerInfo);
            mav.setViewName("/worker/workerUpdate");
        }
        return mav;
    }

    @RequestMapping("/worker/workerUpdateSave.do")
    public ModelAndView updateWorker(HttpSession httpSession, HttpServletRequest request, Model model, @ModelAttribute WorkerVO vo) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        if (httpSession.getAttribute("LoginInfo") == null) {
            mav.setViewName("redirect:/login/notSession.do");
        } else {
            String workerId = vo.getWORKER_ID();
            String flagF = vo.getAPPLY_FUNCTION_F();
            String flagG = vo.getAPPLY_FUNCTION_G();
            String flagL = vo.getAPPLY_FUNCTION_L();
            String No = "N";

            if (flagF == null) vo.setAPPLY_FUNCTION_F(No);
            if (flagG == null) vo.setAPPLY_FUNCTION_G(No);
            if (flagL == null) vo.setAPPLY_FUNCTION_L(No);

            workerService.updateWorker(vo);
            mav.setViewName("redirect:/worker/workerDetail.do?workerId=" + workerId);
        }
        return mav;
    }

    
    
    // 작업자 위치 이력 조회
    @RequestMapping("/worker/locationList.do")
    public ModelAndView WorkerLocationMapping(@RequestParam("workerId") String workerId, HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        
        List<WorkerVO> locationList = workerService.workerLocationSelect(workerId);
        int listSize = locationList.size();
        
        mav.addObject("locationData", locationList);
        mav.addObject("locationDataSize", listSize);
        
        mav.setViewName("/worker/workerLocation");
        
        return mav;
    }
}

