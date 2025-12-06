package com.myproject.service;
import java.util.List;
import com.myproject.domain.CycleVO;
public interface CycleService {
	public List<CycleVO> getList(Long user_id);
}