package com.rungos.common.service;

import com.rungos.common.domain.UUser;

public interface UUserService {
	UUser findUserByEmail(String email);

	UUser login(String email, String password);

	UUser register(UUser user);
}
