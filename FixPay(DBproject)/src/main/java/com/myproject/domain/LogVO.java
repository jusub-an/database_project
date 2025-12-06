package com.myproject.domain;
import java.util.Date;
import lombok.Data;

@Data
public class LogVO {
    private Long log_id;
    private Long user_id;
    private String expense_name;
    private String category_name;
    private String method_name;
    private int amount;
    private Date payment_date;
}