package com.wzcssw.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

public class Album implements Serializable {
	private String aid;
	private String aname;
	private String description;
	private Date createDate;
	
	private Picture head;
	private User user;
	private Set<Picture> pictures;
	
	public Album(){
		
	}

	public Album(String aid, String aname, String description, Date createDate,
			Picture head, User user, Set<Picture> pictures) {
		super();
		this.aid = aid;
		this.aname = aname;
		this.description = description;
		this.createDate = createDate;
		this.head = head;
		this.user = user;
		this.pictures = pictures;
	}

	public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Picture getHead() {
		return head;
	}

	public void setHead(Picture head) {
		this.head = head;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Set<Picture> getPictures() {
		return pictures;
	}

	public void setPictures(Set<Picture> pictures) {
		this.pictures = pictures;
	}

	@Override
	public String toString() {
		return "Album [aid=" + aid + ", aname=" + aname + ", description="
				+ description + ", createDate=" + createDate + ", head=" + head
				+ ", user=" + user + "]";
	}
	
}
