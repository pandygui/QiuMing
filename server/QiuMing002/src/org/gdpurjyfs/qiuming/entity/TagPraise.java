package org.gdpurjyfs.qiuming.entity;

import java.util.Date;

public class TagPraise {
	private long id;
	private long tagId;
	private long praiseUserId;
	private Date time;

	public TagPraise() {
		this.id = 0;
		this.tagId = 0;
		this.praiseUserId = 0;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getTagId() {
		return tagId;
	}

	public void setTagId(long tagId) {
		this.tagId = tagId;
	}

	public long getPraiseUserId() {
		return praiseUserId;
	}

	public void setPraiseUserId(long praiseUserId) {
		this.praiseUserId = praiseUserId;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return "TagPraise [id=" + id + ", tagId=" + tagId + ", praiseUserId="
				+ praiseUserId + ", time=" + time + "]";
	}

}
