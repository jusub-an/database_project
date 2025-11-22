package com.myproject.controller;

import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.myproject.domain.StatsDTO;
import com.myproject.domain.UserVO;
import com.myproject.service.ExpenseService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/dashboard/*")
@AllArgsConstructor
public class DashboardController {

    private ExpenseService expenseService; // 통계 쿼리를 위해 ExpenseService 주입

    private ObjectMapper objectMapper;
    
    @GetMapping("/main")
    public void main(HttpSession session, Model model) throws Exception { // ✨ 3. throws Exception 추가
        log.info("Dashboard Main Page....");
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) { return; }
        
        // 4. 기존 통계 데이터 (테이블용)
        List<StatsDTO> stats = expenseService.getCategoryStats(loginUser.getUser_id());
        model.addAttribute("categoryStats", stats);
        
        // --- ✨ 5. [추가] 차트용 JSON 데이터 ---
        String statsJson = objectMapper.writeValueAsString(stats);
        model.addAttribute("statsJson", statsJson);
        
        // --- 6. (2단계 기능 개선에서 추가할 코드) ---
        model.addAttribute("expenseList", 
                expenseService.getAllExpenses(loginUser.getUser_id()));
    }
}