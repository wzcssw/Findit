package com.wzcssw.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.wzcssw.util.DateFormatNew;

/**
 * Picture entity. @author MyEclipse Persistence Tools
 */

public class Picture implements java.io.Serializable {

	// Fields

	private String pid;
	private String pname;
	private Date createDate;
	private String createDate_str;
	private String description;
	private String titles;
	private String cid;
	private Integer zan;
	private boolean sharing;
	private Integer priority;
	private User author;
	private Set<Album> albums;    ///////////////////////////////////////
	private Set<User> users = new HashSet<User>();
	private Set<Category> categories = new HashSet<Category>();
	private Set<User> collectedUsers = new HashSet<User>();

	// Constructors

	/** default constructor */
	public Picture() {
	}

	/** minimal constructor */
	public Picture(String pid, String pname, Date createDate,
			String cid) {
		this.pid = pid;
		this.pname = pname;
		this.createDate = createDate;
		this.cid = cid;
	}

	/** full constructor */

	// Property accessors

	public String getPid() {
		return this.pid;
	}

	public Picture(String pid, String pname, Date createDate,
			String description, String titles, String cid, Integer zan,
			boolean sharing, Integer priority, Set<User> users,
			Set<Category> categories) {
		super();
		this.pid = pid;
		this.pname = pname;
		this.createDate = createDate;
		this.description = description;
		this.titles = titles;
		this.cid = cid;
		this.zan = zan;
		this.sharing = sharing;
		this.priority = priority;
		this.users = users;
		this.categories = categories;
	}
	
	public Picture(String pid, String pname, Date createDate,
			String titles, String cid, Integer zan,
			boolean sharing, Integer priority, User author
			) {
		super();
		this.pid = pid;
		this.pname = pname;
		this.createDate = createDate;
		this.titles = titles;
		this.cid = cid;
		this.zan = zan;
		this.sharing = sharing;
		this.priority = priority;
		this.author = author;
	}
	public Picture(String pid, String pname, Date createDate,
			String titles,String description, String cid, Integer zan,
			boolean sharing, Integer priority, User author
			) {
		super();
		this.pid = pid;
		this.pname = pname;
		this.createDate = createDate;
		this.titles = titles;
		this.description  = description;
		this.cid = cid;
		this.zan = zan;
		this.sharing = sharing;
		this.priority = priority;
		this.author = author;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getPname() {
		return this.pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}


	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
		this.createDate_str = DateFormatNew.format(createDate);
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTitles() {
		return this.titles;
	}

	public void setTitles(String titles) {
		this.titles = titles;
	}

	public String getCid() {
		return this.cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public Integer getZan() {
		return this.zan;
	}

	public void setZan(Integer zan) {
		this.zan = zan;
	}

	public Set<Category> getCategories() {
		return categories;
	}

	public void setCategories(Set<Category> categories) {
		this.categories = categories;
	}

	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	public boolean isSharing() {
		return sharing;
	}

	public void setSharing(boolean sharing) {
		this.sharing = sharing;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	@Override
	public String toString() {
		return "Picture [pid=" + pid + ", pname=" + pname + ", createDate="
				+ createDate + ", description=" + description + ", titles="
				+ titles + ", cid=" + cid + ", zan=" + zan + ", sharing="
				+ sharing + ", priority=" + priority   + "]";
	}

	public Set<Album> getAlbums() {
		return albums;
	}

	public void setAlbums(Set<Album> albums) {
		this.albums = albums;
	}

	public Set<User> getCollectedUsers() {
		return collectedUsers;
	}

	public void setCollectedUsers(Set<User> collectedUsers) {
		this.collectedUsers = collectedUsers;
	}

	public String getCreateDate_str() {
		return createDate_str;
	}

	public void setCreateDate_str(String createDate_str) {
		this.createDate_str = createDate_str;
	}

}