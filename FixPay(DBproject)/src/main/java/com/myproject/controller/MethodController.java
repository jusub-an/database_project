package com.myproject.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.myproject.domain.MethodVO; // UserVO가 아님
import com.myproject.domain.UserVO;
import com.myproject.service.MethodService; // UserService가 아님
import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/method/*") // URL이 "/method/*" 임
@AllArgsConstructor
public class MethodController {

    private MethodService service; // MethodService 주입
    
    @GetMapping("/manage")
    public void manage(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        model.addAttribute("list", service.getList(loginUser.getUser_id()));
        // /WEB-INF/views/method/manage.jsp 로 이동
    }
    
    @PostMapping("/register")
    public String register(MethodVO method, HttpSession session) { // UserVO가 아님
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        method.setUser_id(loginUser.getUser_id());
        service.register(method);
        return "redirect:/method/manage";
    }
    
    @PostMapping("/remove")
    public String remove(@RequestParam("method_id") Long method_id) {
        service.remove(method_id);
        return "redirect:/method/manage";
    }
}