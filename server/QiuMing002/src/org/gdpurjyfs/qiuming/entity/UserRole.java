package org.gdpurjyfs.qiuming.entity;

public class UserRole {
	private long id;
	private String roleName;
	
	public UserRole() {
		this.roleName = "";
	}
		
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	@Override
	public String toString() {
		return "UserRole [id=" + id + ", roleName=" + roleName + "]";
	}
}
