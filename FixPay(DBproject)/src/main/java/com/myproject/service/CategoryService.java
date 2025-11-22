package com.myproject.service;

import java.util.List;
import com.myproject.domain.CategoryVO;

public interface CategoryService {
    
    public List<CategoryVO> getList(Long user_id);
    
    public void register(CategoryVO category);
    
    public boolean remove(Long category_id);
}