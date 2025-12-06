package com.myproject.mapper;

import java.util.List;
import java.util.Map;

import com.myproject.domain.Criteria;
import com.myproject.domain.ExpenseVO;
import com.myproject.domain.StatsDTO;
import org.apache.ibatis.annotations.Param;

public interface ExpenseMapper {
    
    // BoardMapper의 getList와 동일
    public List<ExpenseVO> getList();
    
    // BoardMapper의 getListWithPaging와 동일
    public List<ExpenseVO> getListWithPaging(Criteria cri);
    
    // BoardMapper의 insertSelectKey와 동일
    public void insertSelectKey(ExpenseVO expense);
    
    // BoardMapper의 read와 동일
    public ExpenseVO read(Long expense_id);
    
    // BoardMapper의 delete와 동일
    public int delete(Long expense_id);
    
    // BoardMapper의 update와 동일
    public int update(ExpenseVO expense);
    
    // BoardMapper의 getTotalCount와 동일
    public int getTotalCount(Criteria cri);
    
    // 카테고리별 지출 통계를 가져올 메소드 추가
    public List<StatsDTO> getCategoryStats(Long user_id);
    
    // HistoryController에서 사용할 '모든 지출 항목' 조회 메소드
    public List<ExpenseVO> getAllExpenses(Long user_id);
    
    public List<ExpenseVO> getUpcomingExpenses(
            @Param("user_id") Long user_id, 
            @Param("startDay") int startDay, 
            @Param("endDay") int endDay
    );
    public List<Map<String, Object>> getFilteredHistory(
            @Param("user_id") Long user_id, 
            @Param("categoryList") List<String> categoryList, 
            @Param("methodList") List<String> methodList,
            @Param("cycleList") List<String> cycleList);
}