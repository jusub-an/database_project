package com.myproject.service;

import java.util.List;
import java.util.Map;
import com.myproject.domain.LogVO;

public interface LogService {
    
    // 1. 월별 지출 통계 가져오기 (대시보드 차트용)
    public List<Map<String, Object>> getMonthlyStats(Long user_id);
    
    // 2. 로그 저장하기 (HistoryService에서 사용 가능)
    public void register(LogVO log);
}