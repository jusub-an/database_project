package com.myproject.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
    
    private int pageNum;  // 현재 페이지 번호
    private int amount;   // 페이지당 보여줄 개수
    private Long user_id;
    
    // 기본값 설정
    public Criteria() {
        this(1, 10); // 기본 1페이지, 10개
    }
    
    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }
}