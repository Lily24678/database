package com.lsy.code.database.domain;

import java.util.Date;

/**
 * 用户表
 */
public class User {

	private String uid;//主键				
	private String username;//用户名		
	private String password;//登录密码		
	private String name;//姓名			
	private String email;//邮件			
	private String telephone;//电话号码	
	private String code;//所在区域行政编码			
	private String sex;//性别				
	private Integer state;//具体地理位置			
	private Date birthday;//生日	

	

	public String getUid() {
		return uid;
	}



	public void setUid(String uid) {
		this.uid = uid;
	}



	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getTelephone() {
		return telephone;
	}



	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}



	public String getCode() {
		return code;
	}



	public void setCode(String code) {
		this.code = code;
	}



	public String getSex() {
		return sex;
	}



	public void setSex(String sex) {
		this.sex = sex;
	}



	public Integer getState() {
		return state;
	}



	public void setState(Integer state) {
		this.state = state;
	}



	public Date getBirthday() {
		return birthday;
	}



	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}



	@Override
	public String toString() {
		return "User [uid=" + uid + ", username=" + username + ", password=" + password + ", name=" + name + ", email="
				+ email + ", telephone=" + telephone + ", code=" + code + ", sex=" + sex + ", state=" + state
				+ ", birthday=" + birthday + "]";
	}

	
	
}
