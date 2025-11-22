package com.myproject.domain;
import lombok.Data;
@Data
public class MethodVO {
    private Long method_id;
    private Long user_id;
    private String name;
    private String type;
}