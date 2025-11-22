package com.myproject.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.myproject.domain.CategoryVO;
import com.myproject.domain.UserVO;
import com.myproject.service.CategoryService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/category/*")
@AllArgsConstructor
public class CategoryController {

    private CategoryService service;
    
    // 1. 관리 페이지 (목록 + 등록 폼)
    @GetMapping("/manage")
    public void manage(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        model.addAttribute("list", service.getList(loginUser.getUser_id()));
        // /WEB-INF/views/category/manage.jsp 로 이동
    }
    
    // 2. 새 카테고리 등록
    @PostMapping("/register")
    public String register(CategoryVO category, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        category.setUser_id(loginUser.getUser_id()); // 본인 ID로 등록
        
        service.register(category);
        return "redirect:/category/manage";
    }
    
    // 3. 카테고리 삭제
    @PostMapping("/remove")
    public String remove(@RequestParam("category_id") Long category_id) {
        service.remove(category_id);
        return "redirect:/category/manage";
    }
}