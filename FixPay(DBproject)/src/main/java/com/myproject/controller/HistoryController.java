package com.myproject.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.myproject.domain.ExpenseVO;
import com.myproject.domain.HistoryVO;
import com.myproject.domain.UserVO;
import com.myproject.service.ExpenseService;
import com.myproject.service.HistoryService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Log4j
@RequestMapping("/history/*")
@AllArgsConstructor
public class HistoryController {

    private HistoryService historyService;
    private ExpenseService expenseService; // '예정 목록'을 가져오기 위해
    
    // 1. '결제 확정' 관리 페이지 (GET)
    @GetMapping("/manage")
    public void manage(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        // 5-4에서 만든 메소드 호출
        List<ExpenseVO> expenseList = expenseService.getAllExpenses(loginUser.getUser_id());
        model.addAttribute("expenseList", expenseList);
        
        // (참고) 나중에 이 달에 '이미 확정된' 내역(History)도 조회해서
        // JSP에서 "처리 완료" 표시를 해주면 좋습니다.
        
        // /WEB-INF/views/history/manage.jsp 로 이동
    }
    
    // 2. '결제 확정' 처리 (POST)
    @PostMapping("/confirm")
    public String confirm(HistoryVO history, RedirectAttributes rttr) {
        log.info("Confirm Payment: " + history);
        
        // 폼에서 넘어온 (expense_id, paid_amount, payment_date)를 DB에 INSERT
        historyService.register(history);
        
        rttr.addFlashAttribute("result", "confirm_success");
        // 처리가 완료되면 차트가 업데이트된 '대시보드'로 이동
        return "redirect:/dashboard/main"; 
    }
    
 // [추가] 결제 내역 상세 페이지 (GET)
    @GetMapping("/detail")
    public void detail(@RequestParam("expense_id") Long expense_id, Model model) {

        log.info("Getting history detail for expense_id: " + expense_id);

        // 1. 항목 정보 (예: '넷플릭스')
        model.addAttribute("expense", expenseService.get(expense_id));

        // 2. 실제 결제 내역 목록 (Jan, Feb, Mar...)
        model.addAttribute("historyList", historyService.getListByExpense(expense_id));

        // /WEB-INF/views/history/detail.jsp 로 이동
    }
}