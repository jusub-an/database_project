package com.myproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.myproject.domain.ExpenseVO;
import com.myproject.domain.HistoryVO;
import com.myproject.domain.LogVO;
import com.myproject.mapper.ExpenseMapper;
import com.myproject.mapper.HistoryMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class HistoryServiceImpl implements HistoryService {

	private HistoryMapper historyMapper;
    private ExpenseMapper expenseMapper; // 원본 정보 조회를 위해 필요
    private LogService logService;
    
    @Override
    public void register(HistoryVO history) {
        // 1. 기존 로직
        historyMapper.register(history);
        
        // 2. 영구 로그 저장 로직
        ExpenseVO original = expenseMapper.read(history.getExpense_id());
        
        if (original != null) {
            LogVO log = new LogVO();
            log.setUser_id(original.getUser_id());
            log.setExpense_name(original.getName());
            log.setCategory_name(original.getCategory_name());
            log.setMethod_name(original.getMethod_name());
            log.setAmount(history.getPaid_amount());
            log.setPayment_date(history.getPayment_date());
            
            // ✨ [수정] 서비스의 메소드 호출
            logService.register(log); 
        }
    }
    
    @Override
    public List<HistoryVO> getListByExpense(Long expense_id) {
        return historyMapper.getListByExpense(expense_id);
    }
}