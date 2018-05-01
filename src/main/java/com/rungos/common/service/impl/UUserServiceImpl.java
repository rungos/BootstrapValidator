package com.rungos.common.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rungos.common.dao.UUserMapper;
import com.rungos.common.domain.UUser;
import com.rungos.common.service.UUserService;

@Service
public class UUserServiceImpl implements UUserService {

	@Autowired
	UUserMapper userMapper;

	@Override
	public UUser findUserByEmail(String email) {
		return userMapper.selectUserByEmail(email);
	}

	@Override
	public UUser login(String email, String password) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("password", password);
		return userMapper.login(map);
	}

	@Override
	public UUser register(UUser user) {
		userMapper.insertSelective(user);
		return user;
	}

}
