package com.myproject.service;

import com.myproject.domain.UserVO;

public interface UserService {
    
    public void register(UserVO user);
    
    // 로그인을 위해 UserVO를 받아 비밀번호까지 비교
    public UserVO login(UserVO user); 
}