package com.myproject.domain;

import lombok.Data;

@Data
public class CategoryVO {
    private Long category_id;
    private String name;
    private Long user_id; // NULL이면 기본, 값이 있으면 커스텀
    
    
    private int expenseCount;
}	