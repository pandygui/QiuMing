package org.gdpurjyfs.qiuming.entity;

import java.util.Date;

public class Complain {

	private long id;
	private long postId;
	private long userId;
	private String reason;
	private int state;				// 0:受理 1:成功
	private Date time;
	
	public Complain() {
		this.reason = "举报原因";
	}
	
	public Complain(long userId, long postId, String reason) {
		this.userId = userId;
		this.postId = postId;
		this.reason = reason;
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getPostId() {
		return postId;
	}
	public void setPostId(long postId) {
		this.postId = postId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	@Override
	public String toString() {
		return "Complain [id=" + id + ", postId=" + postId + ", userId="
				+ userId + ", reason=" + reason + ", state=" + state
				+ ", time=" + time + "]";
	}
	
}
