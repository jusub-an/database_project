package com.myproject.mapper;

import java.util.List;
import java.util.Map;

import com.myproject.domain.LogVO;

public interface LogMapper {
    // 1. 로그 저장
    public void insert(LogVO log);
    
    // 2. 월별 지출 통계 (YYYY-MM 별 합계) -> 차트용
    public List<Map<String, Object>> getMonthlyStats(Long user_id);
}