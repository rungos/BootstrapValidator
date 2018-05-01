package com.rungos.common.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.rungos.common.domain.UUser;
import com.rungos.common.service.UUserService;

/**
 * 
 * @author rungos
 * @date 2018年5月1日下午2:47:12
 * @Description 登录相关
 */
@Controller
@Scope("prototype")
@RequestMapping("user")
public class LoginController {

	Map<String, Object> resultMap = new HashMap<String, Object>();

	@Autowired
	UUserService userService;

	@RequestMapping(value = "register", method = RequestMethod.GET)
	public ModelAndView register() {
		return new ModelAndView("/user/register");
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public ModelAndView login() {
		return new ModelAndView("/user/login");
	}

	@RequestMapping(value = "register", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> register(UUser user, HttpSession session) {
		resultMap.put("status", 500);
		user.setCreateTime(new Date());
		user.setLastLoginTime(new Date());
		user.setStatus(UUser._1);
		user = userService.register(user);
		resultMap.put("status", 200);
		resultMap.put("message", "注册成功");
		userService.login(user.getEmail(), user.getPassword());
		user.setPassword("");
		session.setAttribute("session_user", user);
		return resultMap;
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> login(UUser user, HttpSession session) {
		UUser u = userService.login(user.getEmail(), user.getPassword());
		if (null == u) {
			resultMap.put("status", 500);
			resultMap.put("message", "账号或密码不正确");
		} else if (UUser._0.equals(u.getStatus())) {
			resultMap.put("status", 500);
			resultMap.put("message", "账号已禁止登录");
		} else {
			u.setPassword("");
			session.setAttribute("session_user", u);
			resultMap.put("status", 200);
			resultMap.put("message", "登录成功");
		}
		return resultMap;
	}

	@RequestMapping(value = "logout", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> logout(HttpSession session) {
		try {
			session.removeAttribute("session_user");
			resultMap.put("status", 200);
		} catch (Exception e) {
			resultMap.put("status", 500);
		}
		return resultMap;
	}

	@RequestMapping(value = "checkAccount", method = RequestMethod.POST)
	@ResponseBody
	public String checkAccount(@RequestParam("email") String email) throws IOException {
		UUser user = userService.findUserByEmail(email);
		Boolean result = true;
		// 邮箱账号验证
		if (null != user) {
			result = false;
		}
		// bootstrapValidator需要返回{"valid",true or false}
		resultMap.put("valid", result);
		ObjectMapper mapper = new ObjectMapper();
		String resultString = "";
		try {
			resultString = mapper.writeValueAsString(resultMap);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return resultString;
	}
}