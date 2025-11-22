package com.myproject.service;
import java.util.List;
import org.springframework.stereotype.Service;
import com.myproject.domain.CycleVO;
import com.myproject.mapper.CycleMapper;
import lombok.AllArgsConstructor;
@Service
@AllArgsConstructor
public class CycleServiceImpl implements CycleService {
    private CycleMapper mapper;
    @Override
    public List<CycleVO> getList() {
        return mapper.getList();
    }
}