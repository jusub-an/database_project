package com.myproject.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.myproject.domain.Criteria;
import com.myproject.domain.ExpenseVO;
import com.myproject.mapper.ExpenseMapper;
import com.myproject.domain.StatsDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor // 생성자 주입
public class ExpenseServiceImpl implements ExpenseService {

	// @AllArgsConstructor를 사용하면 @Setter(onMethod_ = @Autowired)가 필요 없습니다.
	private ExpenseMapper mapper; 

	@Override
	public void register(ExpenseVO expense) {
		log.info("register......" + expense);
		mapper.insertSelectKey(expense);
	}

	@Override
	public ExpenseVO get(Long expense_id) {
		log.info("get......" + expense_id);
		return mapper.read(expense_id);
	}

	@Override
	public boolean modify(ExpenseVO expense) {
		log.info("modify......" + expense);
		return mapper.update(expense) == 1;
	}

	@Override
	public boolean remove(Long expense_id) {
		log.info("remove...." + expense_id);
		return mapper.delete(expense_id) == 1;
	}

	@Override
	public List<ExpenseVO> getList(Criteria cri) {
		log.info("getList with criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	// 2. 통계 메소드 구현 추가
	@Override
	public List<StatsDTO> getCategoryStats(Long user_id) {
		log.info("get category stats for user: " + user_id);
		return mapper.getCategoryStats(user_id);
	}
	
	@Override
    public List<ExpenseVO> getAllExpenses(Long user_id) {
        log.info("get All expenses for user: " + user_id);
        return mapper.getAllExpenses(user_id);
    }
}