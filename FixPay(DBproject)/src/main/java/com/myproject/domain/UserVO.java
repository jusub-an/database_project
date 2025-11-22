package com.myproject.domain;

import java.util.Date;
import lombok.Data;

@Data
public class UserVO {
    
    // Users 테이블 컬럼
    private Long user_id;
    private String email;
    private String password;
    private String nickname;
    private Date created_at; 
}