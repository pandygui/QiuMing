package org.gdpurjyfs.qiuming.action;

import org.gdpurjyfs.qiuming.entity.User;
import org.gdpurjyfs.qiuming.service.UserService;

public class UserAction {

	/*
	 * 用户注册 
	 * 修改用户信息 
	 * 修改密码 
	 * 登陆
	 */
	private String username;
	private String password;

	private String pickname;
	private String email;
	private String telephone;
	private int age;
	private String address;
	private String sex;
	private String introduction;

	private String newPassword;
	
	private UserService service = new UserService();

	// TODO 修改用户信息
	public String modifyInfo() {
		service.setUser(this.getUser());
		String result = service.modifyInfo();
		return result;
	}

	// TODO 修改密码
	public String modifyPassword() {
		service.setUser(this.getUser());
		service.setNewPassword(this.getNewPassword());
		String result = service.modifyPassword();
		return result;
	}

	// TODO 用户注册
	public String register() {
		service.setUser(this.getUser());
		String result = service.register();
		return result;
	}

	// TODO 用户登录
	public String login() {
		service.setUser(this.getUser());
		String result = service.login();
		return result;
	}

	private User getUser() {
		User user = new User();
		user.setAddress(this.getAddress());
		user.setAge(this.getAge());
		user.setEmail(this.getEmail());
//		user.setExperience();
		user.setIntroduction(this.getIntroduction());
		user.setPassword(this.getPassword());
		user.setPickname(this.getPickname());
//		user.setRoleId();
		user.setSex(this.getSex());
		user.setTelephone(this.getTelephone());
		user.setUsername(this.getUsername());		
		return user;
	}
	
	//----------------------------------------------
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPickname() {
		return pickname;
	}

	public void setPickname(String pickname) {
		this.pickname = pickname;
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

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
}
