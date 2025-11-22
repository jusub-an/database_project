package com.myproject.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.myproject.domain.UserVO;
import com.myproject.service.UserService; // ExpenseService가 아님
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*") // URL이 "/user/*" 임
@AllArgsConstructor
public class UserController {

    private UserService service; // UserService 주입
    
    // 1. 회원가입 페이지 (GET)
    @GetMapping("/register")
    public void register() {
        // /WEB-INF/views/user/register.jsp 로 이동
    }
    
    // 2. 회원가입 처리 (POST)
    @PostMapping("/register")
    public String register(UserVO user, RedirectAttributes rttr) {
        log.info("POST register: " + user);
        service.register(user);
        rttr.addFlashAttribute("result", "register_success");
        return "redirect:/user/login"; // 회원가입 후 로그인 페이지로
    }
    
    // 3. 로그인 페이지 (GET)
    @GetMapping("/login")
    public void login() {
        // /WEB-INF/views/user/login.jsp 로 이동
    }
    
    // 4. 로그인 처리 (POST)
    @PostMapping("/login")
    public String login(UserVO user, HttpServletRequest request, RedirectAttributes rttr) {
        log.info("POST login attempt: " + user.getEmail());
        
        UserVO loginUser = service.login(user);
        
        if (loginUser == null) {
            // 로그인 실패
            rttr.addFlashAttribute("result", "login_fail");
            return "redirect:/user/login";
        }
        
        // 로그인 성공 -> 세션(Session)에 사용자 정보 저장
        HttpSession session = request.getSession();
        session.setAttribute("loginUser", loginUser);
        
        log.info("Login Success: " + loginUser.getNickname());
        return "redirect:/expense/list"; // 로그인 후 메인(지출 목록)으로
    }
    
    // 5. 로그아웃 (GET)
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        log.info("Logout....");
        session.invalidate(); // 세션 무효화
        return "redirect:/user/login"; // 로그아웃 후 로그인 페이지로
    }
}