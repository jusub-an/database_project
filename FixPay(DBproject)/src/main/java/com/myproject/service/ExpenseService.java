package com.myproject.service;

import java.util.List;
import com.myproject.domain.Criteria;
import com.myproject.domain.ExpenseVO;
import com.myproject.domain.StatsDTO;

public interface ExpenseService {

	public void register(ExpenseVO expense);

	public ExpenseVO get(Long expense_id);

	public boolean modify(ExpenseVO expense);

	public boolean remove(Long expense_id);

	public List<ExpenseVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	// 2. 통계 메소드 추가
	public List<StatsDTO> getCategoryStats(Long user_id);
	
	public List<ExpenseVO> getAllExpenses(Long user_id);
}