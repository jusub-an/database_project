package com.myproject.mapper;
import java.util.List;
import com.myproject.domain.MethodVO;
public interface MethodMapper {
    public List<MethodVO> getList(Long user_id); // 내것만 조회
    public void register(MethodVO method);
    public int delete(Long method_id);
}