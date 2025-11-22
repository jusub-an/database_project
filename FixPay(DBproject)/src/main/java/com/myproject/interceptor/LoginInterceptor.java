package com.myproject.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        
        HttpSession session = request.getSession();
        
        if (session.getAttribute("loginUser") == null) {
            // 로그인하지 않은 사용자
            response.sendRedirect(request.getContextPath() + "/user/login");
            return false; // 컨트롤러 실행 중지
        }
        
        return true; // 컨트롤러 계속 실행
    }
}