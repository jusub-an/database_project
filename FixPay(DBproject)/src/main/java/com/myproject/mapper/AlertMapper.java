package com.myproject.mapper;
import com.myproject.domain.AlertVO;
public interface AlertMapper {
    // 1. 유저의 알림 설정 1개 가져오기
    public AlertVO get(Long user_id);
    // 2. 알림 설정이 없으면 새로 등록
    public void register(AlertVO alert);
    // 3. 알림 설정이 있으면 수정
    public int update(AlertVO alert);
}