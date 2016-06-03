package com.wzcssw.domain;

import java.util.Date;

import com.wzcssw.util.DateFormatNew;

/**
 * Comment entity. @author MyEclipse Persistence Tools
 */

public class Comment implements java.io.Serializable {

	// Fields

	private String comid;
	private User user;
	private String pid;
	private Date createtime;
	private String createtime_str;
	private String msg;

	// Constructors

	/** default constructor */
	public Comment() {
	}

	/** full constructor */
	public Comment(String comid, User user, String pid, Date createtime,
			String msg) {
		this.comid = comid;
		this.user = user;
		this.pid = pid;
		this.createtime = createtime;
		this.msg = msg;
	}

	// Property accessors

	public String getComid() {
		return this.comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}



	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getPid() {
		return this.pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
		this.createtime_str = DateFormatNew.format(createtime);
	}

	public String getMsg() {
		return this.msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}


	public String getCreatetime_str() {
		return createtime_str;
	}

	public void setCreatetime_str(String createtime_str) {
		this.createtime_str = createtime_str;
	}

	@Override
	public String toString() {
		return "Comment [comid=" + comid + ", user=" + user + ", pid=" + pid
				+ ", createtime=" + createtime + ", msg=" + msg +  "]";
	}

}