package com.myproject.service;
import java.util.List;
import com.myproject.domain.MethodVO;
public interface MethodService {
    public List<MethodVO> getList(Long user_id);
    public void register(MethodVO method);
    public boolean remove(Long method_id);
}