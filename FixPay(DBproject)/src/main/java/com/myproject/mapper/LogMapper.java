package com.myproject.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.myproject.domain.LogVO;
import com.myproject.domain.StatsDTO;


public interface LogMapper {
    // 1. 로그 저장
    public void insert(LogVO log);
    
    // 2. 월별 지출 통계 (YYYY-MM 별 합계) -> 차트용
    public List<Map<String, Object>> getMonthlyStats(Long user_id);
    
 // [✨ 신규 메소드 3개]
    public List<Map<String, Object>> getFilteredMonthlyStats(
            @Param("user_id") Long user_id, 
            @Param("category_name") String category_name, 
            @Param("method_name") String method_name);
            
    public List<StatsDTO> getFilteredCategoryStats(
            @Param("user_id") Long user_id, 
            @Param("category_name") String category_name, 
            @Param("method_name") String method_name);
            
    public List<LogVO> getFilteredLogList(
            @Param("user_id") Long user_id, 
            @Param("category_name") String category_name, 
            @Param("method_name") String method_name);
}
