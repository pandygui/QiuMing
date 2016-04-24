package org.gdpurjyfs.qiuming.entity;

import java.util.Date;

public class Letter {
	private long id;
	private long receiveUserId;
	private long senderUserId;
	private String content;
	private Date time;

	public Letter() {

	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getReceiveUserId() {
		return receiveUserId;
	}

	public void setReceiveUserId(long receiveUserId) {
		this.receiveUserId = receiveUserId;
	}

	public long getSenderUserId() {
		return senderUserId;
	}

	public void setSenderUserId(long senderUserId) {
		this.senderUserId = senderUserId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

}
