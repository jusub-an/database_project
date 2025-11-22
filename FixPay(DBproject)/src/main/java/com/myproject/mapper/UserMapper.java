package com.myproject.mapper;

import com.myproject.domain.UserVO;

public interface UserMapper {
    
    // 1. 회원가입
    public void register(UserVO user);
    
    // 2. 로그인 (이메일로 사용자 정보 조회)
    public UserVO get(String email);
    
    // 3. (선택적) 이메일 중복 체크
    public int idCheck(String email);
}