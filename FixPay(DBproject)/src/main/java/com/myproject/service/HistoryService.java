package com.myproject.service;

import java.util.List;

import com.myproject.domain.HistoryVO;

public interface HistoryService {
    
    public void register(HistoryVO history);
    public List<HistoryVO> getListByExpense(Long expense_id);
}