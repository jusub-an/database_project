package com.myproject.domain;

import java.util.Date;
import lombok.Data;

@Data
public class ExpenseVO {
    
    // Fixed_Expense 테이블 컬럼
    private Long expense_id;  // PK
    private String name;
    private int amount;
    private int payment_day;
    
    // Foreign Keys (일단 ID만 받도록 설계)
    private Long user_id;
    private Long category_id;
    private Long cycle_id;
    private Long method_id;
    
    private String category_name;
    private String method_name;
    
    private int is_active;
    
    private String cycle_name;
    
 // ✨ [추가] 화면 표시용 D-Day 변수 (DB 컬럼 아님)
    private int d_day;

}