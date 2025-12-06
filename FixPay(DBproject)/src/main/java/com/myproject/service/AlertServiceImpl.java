package com.myproject.service;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Service;
import com.myproject.domain.AlertVO;
import com.myproject.domain.ExpenseVO;
import com.myproject.mapper.AlertMapper;
import com.myproject.mapper.ExpenseMapper;

import lombok.AllArgsConstructor;
@Service
@AllArgsConstructor
public class AlertServiceImpl implements AlertService {

    private AlertMapper mapper;
    private ExpenseMapper expenseMapper;
    
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
    
    @Override
    public List<ExpenseVO> checkAlert(Long user_id) {
        // 1. 설정값 가져오기 (기존 코드)
        AlertVO setting = getSetting(user_id);
        if (setting.getIs_active() == 0) {
            return new ArrayList<>();
        }
        
        // 2. 날짜 계산을 위한 Calendar 객체 준비
        Calendar cal = Calendar.getInstance();
        int currentDay = cal.get(Calendar.DAY_OF_MONTH); // 오늘 날짜 (예: 22)
        int lastDayOfMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 이달의 마지막 날 (예: 30 or 31)
        
        // 3. 검색 범위 설정 (기존 코드)
        cal.add(Calendar.DATE, 1); 
        int startDay = cal.get(Calendar.DAY_OF_MONTH);
        
        // (주의: cal 객체가 변경되었으니 다시 초기화하거나 계산 주의)
        // 편의상 로직 흐름을 위해 검색용 날짜는 별도로 계산하는 게 안전합니다.
        Calendar searchCal = Calendar.getInstance();
        searchCal.add(Calendar.DATE, 1);
        int searchStart = searchCal.get(Calendar.DAY_OF_MONTH);
        
        searchCal.add(Calendar.DATE, setting.getDays_before() - 1); // 검색 범위 끝
        int searchEnd = searchCal.get(Calendar.DAY_OF_MONTH);
        
        // 4. DB에서 목록 조회
        List<ExpenseVO> list = expenseMapper.getUpcomingExpenses(user_id, searchStart, searchEnd);
        
        // ✨ 5. [추가] D-Day 계산 로직
        for (ExpenseVO vo : list) {
            int paymentDay = vo.getPayment_day();
            int dDay = 0;
            
            if (paymentDay >= currentDay) {
                // Case A: 같은 달인 경우 (예: 오늘 22일, 결제일 25일 -> 3일 남음)
                dDay = paymentDay - currentDay;
            } else {
                // Case B: 다음 달로 넘어가는 경우 (예: 오늘 30일, 결제일 2일 -> 남은일수 + 2일)
                // (이달의 남은 일수) + (다음달 날짜)
                dDay = (lastDayOfMonth - currentDay) + paymentDay;
            }
            
            vo.setD_day(dDay); // 계산된 값을 VO에 저장
        }
        
        return list;
    }
}