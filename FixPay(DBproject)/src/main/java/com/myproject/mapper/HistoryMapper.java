package com.myproject.mapper;

import java.util.List;

import com.myproject.domain.HistoryVO;

public interface HistoryMapper {
    
    // 1. 실제 결제 내역 등록
    public void register(HistoryVO history);
    
    public List<HistoryVO> getListByExpense(Long expense_id);
    // (대시보드 외에, 결제 내역만 따로 보는 페이지를 위한 선택적 메소드)
    // public List<HistoryVO> getList(Long user_id);
}