package com.rungos.common.domain;

import java.io.Serializable;
import java.util.Date;

import net.sf.json.JSONObject;

/**
 * 
 * @author rungos
 * @date 2018年5月1日下午1:41:48
 * @Description User
 */
public class UUser implements Serializable {
	private static final long serialVersionUID = 1L;

	/** 禁止登录 */
	public static final Long _0 = new Long(0);
	/** 有效 */
	public static final Long _1 = new Long(1);

	private Long id;
	/** 昵称 */
	private String nickname;
	/** 邮箱账号 */
	private String email;
	/** 密码 */
	private transient String password;
	/** 创建时间 */
	private Date createTime;
	/** 最后登录时间 */
	private Date lastLoginTime;
	/** 1:有效 、0:禁止登录 */
	private Long status;

	public UUser() {
		super();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public Long getStatus() {
		return status;
	}

	public void setStatus(Long status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return JSONObject.fromObject(this).toString();
	}
}