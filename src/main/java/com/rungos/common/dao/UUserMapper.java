package com.rungos.common.dao;

import java.util.Map;

import com.rungos.common.domain.UUser;

public interface UUserMapper {
	
	/** 根据邮箱账号查询 */
	UUser selectUserByEmail(String email);

	/** 登录 */
	UUser login(Map<String, Object> map);

	/** 新增 */
	int insertSelective(UUser user);
}
