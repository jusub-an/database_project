package com.myproject.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.myproject.domain.CategoryVO;
import com.myproject.mapper.CategoryMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private CategoryMapper mapper;
    
    @Override
    public List<CategoryVO> getList(Long user_id) {
        return mapper.getList(user_id);
    }

    @Override
    public void register(CategoryVO category) {
        mapper.register(category);
    }

    @Override
    public boolean remove(Long category_id) {
        // (참고) 실제로는 이 카테고리를 Fixed_Expense가 쓰고 있는지 확인해야 함
        return mapper.delete(category_id) == 1;
    }
}