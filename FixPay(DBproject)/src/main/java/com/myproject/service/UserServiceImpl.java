package com.myproject.service;

import org.springframework.stereotype.Service;
import com.myproject.domain.UserVO;
import com.myproject.mapper.UserMapper; // ExpenseMapper가 아님
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService { // UserService 구현

    private UserMapper mapper; // UserMapper 주입
    
    @Override
    public void register(UserVO user) {
        log.info("register......" + user);
        // (참고) 실제로는 여기서 비밀번호를 암호화해야 합니다.
        mapper.register(user);
    }

    @Override
    public UserVO login(UserVO user) {
        log.info("login attempt......" + user.getEmail());
        
        // 1. 이메일로 회원 정보를 가져옵니다.
        UserVO dbUser = mapper.get(user.getEmail());
        
        // 2. 유저가 존재하고, 비밀번호가 일치하는지 확인합니다.
        if (dbUser != null && dbUser.getPassword().equals(user.getPassword())) {
            return dbUser; // 로그인 성공
        }
        
        return null; // 로그인 실패
    }
}