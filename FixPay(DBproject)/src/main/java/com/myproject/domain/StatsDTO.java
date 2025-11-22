package com.myproject.domain;

import lombok.Data;

@Data
public class StatsDTO {
    // 통계 쿼리 결과를 담을 필드
    private String category_name; // 예: 'OTT/구독'
    private int total_amount;     // 예: 50000
}