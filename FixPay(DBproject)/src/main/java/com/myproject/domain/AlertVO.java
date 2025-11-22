package com.myproject.domain;
import lombok.Data;
@Data
public class AlertVO {
    // Alert_Setting 테이블
    private Long alert_id;
    private Long user_id;
    private int days_before;
    private int is_active; // 1:활성, 0:비활성
}