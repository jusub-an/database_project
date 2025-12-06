package com.myproject.domain;
import lombok.Data;
@Data
public class CycleVO {
    private Long cycle_id;
    private String name;
    private int months_interval;
    
    private int expenseCount;
}