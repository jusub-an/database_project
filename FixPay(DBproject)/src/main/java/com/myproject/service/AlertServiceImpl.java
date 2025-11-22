package com.myproject.service;
import org.springframework.stereotype.Service;
import com.myproject.domain.AlertVO;
import com.myproject.mapper.AlertMapper;
import lombok.AllArgsConstructor;
@Service
@AllArgsConstructor
public class AlertServiceImpl implements AlertService {

    private AlertMapper mapper;
    
    @Override
    public AlertVO getSetting(Long user_id) {
        AlertVO setting = mapper.get(user_id);
        
        // 1. 사용자가 설정값이 아직 없으면 (최초 방문 시)
        if (setting == null) {
            // 2. '3일 전, 활성'이라는 기본값을 DB에 생성
            setting = new AlertVO();
            setting.setUser_id(user_id);
            setting.setDays_before(3); // 기본값 3일
            setting.setIs_active(1);   // 기본값 활성(1)
            mapper.register(setting);
        }
        return setting;
    }

    @Override
    public boolean saveSetting(AlertVO alert) {
        // 1. 설정 저장 (UPDATE)
        return mapper.update(alert) == 1;
    }
}