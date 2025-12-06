package com.myproject.service;

import java.util.List;
import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Service;
import com.myproject.domain.LogVO;
import com.myproject.mapper.LogMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor // 생성자 주입
public class LogServiceImpl implements LogService {

    private LogMapper mapper;

    @Override
    public List<Map<String, Object>> getMonthlyStats(Long user_id) {
        log.info("get Monthly Stats service.... user_id: " + user_id);
        return mapper.getMonthlyStats(user_id);
    }

    @Override
    public void register(LogVO log) {
        // 나중에 HistoryServiceImpl에서도 이 서비스를 쓰도록 리팩토링할 수 있습니다.
        mapper.insert(log); 
    }
    
    @Override
    public Map<String, Object> getDashboardData(Long user_id, String category_name, String method_name) {
        Map<String, Object> result = new HashMap<>();
        
        // 1. 월별 추이 데이터
        result.put("monthlyStats", mapper.getFilteredMonthlyStats(user_id, category_name, method_name));
        
        // 2. 카테고리 비중 데이터
        result.put("categoryStats", mapper.getFilteredCategoryStats(user_id, category_name, method_name));
        
        // 3. 결제 로그
        result.put("logList", mapper.getFilteredLogList(user_id, category_name, method_name));
        
        return result;
    }
}