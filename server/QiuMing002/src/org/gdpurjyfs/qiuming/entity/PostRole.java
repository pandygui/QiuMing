package org.gdpurjyfs.qiuming.entity;

public class PostRole {
	private long id;
	private String roleName;
	
	public PostRole() {
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
		return "PostRole [id=" + id + ", roleName=" + roleName + "]";
	}
	
	
}
