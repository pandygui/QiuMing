package org.gdpurjyfs.qiuming.entity;

public class User {
	
	private long id;
	private String username;
	private String password;
	private String pickname;
	private String email;
	private String telephone;
	private int age;
	private String address;
	private long experience;
	private String sex;
	private long roleId;
	private String introduction;
	
	public User() {
		/* 这里设置默认值 */
		this.email = "";
		this.age = 0;
		this.address = "秋名山";
		this.sex = "秀吉";
		this.roleId = 0;
		this.introduction = "这个人好懒，一句话也没有写";
		this.telephone = "";
		
	}
		
	///////////////////////////
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
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
	public long getExperience() {
		return experience;
	}
	public void setExperience(long experience) {
		this.experience = experience;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public long getRoleId() {
		return roleId;
	}
	public void setRoleId(long roleId) {
		this.roleId = roleId;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password="
				+ password + ", pickname=" + pickname + ", email=" + email
				+ ", telephone=" + telephone + ", age=" + age + ", address="
				+ address + ", experience=" + experience + ", sex=" + sex
				+ ", roleId=" + roleId + ", introduction=" + introduction + "]";
	}
}
