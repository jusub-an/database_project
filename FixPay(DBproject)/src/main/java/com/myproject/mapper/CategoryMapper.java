package com.myproject.mapper;

import java.util.List;
import com.myproject.domain.CategoryVO;

public interface CategoryMapper {
    
    // 1. 로그인한 유저의 커스텀 카테고리 + 기본 카테고리(user_id IS NULL) 목록
    public List<CategoryVO> getList(Long user_id);
    
    // 2. 새 카테고리 등록
    public void register(CategoryVO category);
    
    // 3. 카테고리 삭제
    public int delete(Long category_id);
    
    // (수정을 위한 1개 조회)
    public CategoryVO get(Long category_id);
}