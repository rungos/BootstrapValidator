package com.rungos.common.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * 
 * @author rungos
 * @date 2018年5月1日下午5:40:43
 * @Description 其它
 */
@Controller
@Scope("prototype")
@RequestMapping("common")
public class CommonController {

	@RequestMapping(value = "index", method = RequestMethod.GET)
	public ModelAndView index() {
		return new ModelAndView("/user/index");
	}

	@RequestMapping(value = "404", method = RequestMethod.GET)
	public ModelAndView _404() {
		return new ModelAndView("/error/404");
	}
	
	@RequestMapping(value = "500", method = RequestMethod.GET)
	public ModelAndView _500() {
		return new ModelAndView("/error/500");
	}

}
