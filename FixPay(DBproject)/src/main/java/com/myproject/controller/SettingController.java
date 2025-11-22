package com.myproject.controller;

import javax.servlet.http.HttpSession;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.myproject.domain.AlertVO;
import com.myproject.domain.CategoryVO;
import com.myproject.domain.MethodVO;
import com.myproject.domain.UserVO;
import com.myproject.service.AlertService;
import com.myproject.service.CategoryService;
import com.myproject.service.MethodService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/setting/*")
@AllArgsConstructor
public class SettingController {
    
    // 3개의 Service를 모두 주입받음
    private CategoryService categoryService;
    private MethodService methodService;
    private AlertService alertService;
    
    // 1. 통합 설정 메인 페이지 (GET)
    @GetMapping("/main")
    public void main(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        Long user_id = loginUser.getUser_id();
        
        // 3개 탭에 필요한 데이터를 모두 조회해서 전달
        model.addAttribute("categoryList", categoryService.getList(user_id));
        model.addAttribute("methodList", methodService.getList(user_id));
        model.addAttribute("alertSetting", alertService.getSetting(user_id));
        
        // /WEB-INF/views/setting/main.jsp 로 이동
    }

    // --- Category 관리 (기존 CategoryController의 기능) ---
    @PostMapping("/category/register")
    public String registerCategory(CategoryVO category, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        category.setUser_id(loginUser.getUser_id());
        categoryService.register(category);
        return "redirect:/setting/main"; // 통합 페이지로 복귀
    }
    
    @PostMapping("/category/remove")
    public String removeCategory(@RequestParam("category_id") Long category_id, RedirectAttributes rttr) {
        try {
            // 4. 삭제 시도
            categoryService.remove(category_id);
            rttr.addFlashAttribute("result", "카테고리가 삭제되었습니다.");
            
        } catch (DataIntegrityViolationException e) {
            // 5. [!!!] 오류 발생 시 (자식 레코드가 있을 때)
            log.error("Category remove error: " + e.getMessage());
            rttr.addFlashAttribute("error", "이 카테고리를 사용 중인 '지출 항목'이 있어 삭제할 수 없습니다.");
            
        } catch (Exception e) {
            // 6. (기타 예외 처리)
            rttr.addFlashAttribute("error", "삭제 중 오류가 발생했습니다.");
        }
        return "redirect:/setting/main";
    }

    // --- Method 관리 (기존 MethodController의 기능) ---
    @PostMapping("/method/register")
    public String registerMethod(MethodVO method, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        method.setUser_id(loginUser.getUser_id());
        methodService.register(method);
        return "redirect:/setting/main";
    }
    
    @PostMapping("/method/remove")
    public String removeMethod(@RequestParam("method_id") Long method_id, RedirectAttributes rttr) {
         try {
            // 8. 삭제 시도
            methodService.remove(method_id);
            rttr.addFlashAttribute("result", "결제 수단이 삭제되었습니다.");
            
        } catch (DataIntegrityViolationException e) {
            // 9. [!!!] 오류 발생 시 (자식 레코드가 있을 때)
            log.error("Method remove error: " + e.getMessage());
            rttr.addFlashAttribute("error", "이 결제 수단을 사용 중인 '지출 항목'이 있어 삭제할 수 없습니다.");
            
        } catch (Exception e) {
            rttr.addFlashAttribute("error", "삭제 중 오류가 발생했습니다.");
        }
        return "redirect:/setting/main";
    }
    
    // --- Alert 관리 (신규) ---
    @PostMapping("/alert/save")
    public String saveAlert(AlertVO alert, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        alert.setUser_id(loginUser.getUser_id());
        
        // 폼에서 is_active가 체크 안되면 0으로 설정
        if (alert.getIs_active() != 1) {
            alert.setIs_active(0);
        }
        
        alertService.saveSetting(alert);
        return "redirect:/setting/main";
    }
}