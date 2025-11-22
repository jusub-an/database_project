package com.myproject.service;

import java.util.List;

import org.springframework.stereotype.Service;
import com.myproject.domain.HistoryVO;
import com.myproject.mapper.HistoryMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class HistoryServiceImpl implements HistoryService {

    private HistoryMapper mapper;
    
    @Override
    public void register(HistoryVO history) {
        mapper.register(history);
    }
    
    @Override
    public List<HistoryVO> getListByExpense(Long expense_id) {
        return mapper.getListByExpense(expense_id);
    }
}