package com.myproject.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.myproject.domain.ExpenseVO;
import com.myproject.domain.StatsDTO;
import com.myproject.domain.UserVO;
import com.myproject.service.AlertService;
import com.myproject.service.ExpenseService;
import com.myproject.service.LogService;
import com.myproject.service.CategoryService; // 태그 목록용
import com.myproject.service.MethodService;   // 태그 목록용
import com.myproject.service.CycleService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dashboard/*")
@AllArgsConstructor
public class DashboardController {

	private ExpenseService expenseService;
    private AlertService alertService;
    private CategoryService categoryService;
    private MethodService methodService;
    private CycleService cycleService;
    private ObjectMapper objectMapper;

    // [수정된 main 메소드 전체]
    @GetMapping("/main")
    public void main(HttpSession session, Model model) throws Exception {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) { return; }
        
        // 태그 목록 로딩
        model.addAttribute("categoryList", categoryService.getList(loginUser.getUser_id()));
        model.addAttribute("methodList", methodService.getList(loginUser.getUser_id()));
        model.addAttribute("cycleList", cycleService.getList(loginUser.getUser_id()));
        
        // 초기 차트 데이터 (필터 없음)
        List<Map<String, Object>> rawData = expenseService.getDashboardData(loginUser.getUser_id(), null, null, null);
        model.addAttribute("initDataJson", objectMapper.writeValueAsString(rawData));
        
        // 알림 체크
        List<ExpenseVO> alertList = alertService.checkAlert(loginUser.getUser_id());
        if (alertList != null && !alertList.isEmpty()) {
            model.addAttribute("alertList", alertList);
            model.addAttribute("daysBefore", alertService.getSetting(loginUser.getUser_id()).getDays_before());
        }
    }
    
    @PostMapping(value = "/api/data", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String getDashboardData(
            HttpSession session,
            // [!!!] 여기서 value 값의 "[]"를 모두 지워주세요!
            @RequestParam(value="categoryList", required=false) List<String> categoryList,
            @RequestParam(value="methodList", required=false) List<String> methodList,
            @RequestParam(value="cycleList", required=false) List<String> cycleList) throws Exception {
            
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        // 서비스 호출
        List<Map<String, Object>> data = expenseService.getDashboardData(
                loginUser.getUser_id(), categoryList, methodList, cycleList);
        
        return objectMapper.writeValueAsString(data);
    }
}