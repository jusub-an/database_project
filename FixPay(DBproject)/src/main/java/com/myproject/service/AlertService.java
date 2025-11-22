package com.myproject.service;
import com.myproject.domain.AlertVO;
public interface AlertService {
    // 유저의 설정을 가져오거나, 없으면 기본값(3일) 생성
    public AlertVO getSetting(Long user_id);
    
    // 설정 저장 (수정)
    public boolean saveSetting(AlertVO alert);
}