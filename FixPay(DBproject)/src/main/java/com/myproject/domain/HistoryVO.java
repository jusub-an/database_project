package com.myproject.domain;

import java.util.Date;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class HistoryVO {
    
    // Payment_History 테이블 컬럼
    private Long history_id;
    private Long expense_id; // (FK) 어떤 항목에 대한 내역인지
    private int paid_amount; // 실제 결제된 금액
    
    @DateTimeFormat(pattern = "yyyy-MM-dd") // 폼에서 날짜를 받을 수 있게
    private Date payment_date; // 실제 결제한 날짜
    
    private String memo; // (선택적)
}