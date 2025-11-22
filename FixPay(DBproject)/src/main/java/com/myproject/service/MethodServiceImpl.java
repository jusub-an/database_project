package com.myproject.service;
import java.util.List;
import org.springframework.stereotype.Service;
import com.myproject.domain.MethodVO;
import com.myproject.mapper.MethodMapper;
import lombok.AllArgsConstructor;
@Service
@AllArgsConstructor
public class MethodServiceImpl implements MethodService {
    private MethodMapper mapper;
    @Override
    public List<MethodVO> getList(Long user_id) {
        return mapper.getList(user_id);
    }
    @Override
    public void register(MethodVO method) {
        mapper.register(method);
    }
    @Override
    public boolean remove(Long method_id) {
        return mapper.delete(method_id) == 1;
    }
}