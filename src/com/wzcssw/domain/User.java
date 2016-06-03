package com.wzcssw.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


public class User implements java.io.Serializable {

	// Fields
	private String uid;
	private String username;
	private String password;
	private String code;
	private Date birthday;
	private Date lastLogin;
	private Date createDate;
	private String nick;
	private String address;
	private String phone;
	private String mail;
	private String role;
	private Picture head;
	private String gender;

	private Set<Picture> collectedPictures = new HashSet<Picture>();
	// Constructors

	/** default constructor */
	public User() {
	}

	/** minimal constructor */
	public User(String uid, String username, String password, String code,
			String nick, String address, String phone, String mail, String role) {
		this.uid = uid;
		this.username = username;
		this.password = password;
		this.code = code;
		this.nick = nick;
		this.address = address;
		this.phone = phone;
		this.mail = mail;
		this.role = role;
	}

	/** full constructor */

	// Property accessors

	public String getUid() {
		return this.uid;
	}

	

	public User(String uid, String username, String password, String code,
			Date birthday, Date createDate, String nick, String address,
			String phone, String mail, String role, Picture head, String gender) {
		super();
		this.uid = uid;
		this.username = username;
		this.password = password;
		this.code = code;
		this.birthday = birthday;
		this.createDate = createDate;
		this.nick = nick;
		this.address = address;
		this.phone = phone;
		this.mail = mail;
		this.role = role;
		this.head = head;
		this.gender = gender;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Date getBirthday() {
		return this.birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getNick() {
		return this.nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMail() {
		return this.mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getRole() {
		return this.role;
	}

	public void setRole(String role) {
		this.role = role;
	}


	public Picture getHead() {
		return head;
	}

	public void setHead(Picture head) {
		this.head = head;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Set<Picture> getCollectedPictures() {
		return collectedPictures;
	}

	public void setCollectedPictures(Set<Picture> collectedPictures) {
		this.collectedPictures = collectedPictures;
	}

	public Date getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(Date lastLogin) {
		this.lastLogin = lastLogin;
	}

	@Override
	public int hashCode() {
		return uid.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(obj instanceof User){
			return this.uid.equals(((User) obj).getUid());
		}
		return super.equals(obj);
	}

	@Override
	public String toString() {
		return "User [uid=" + uid + ", username=" + username + ", password="
				+ password + ", code=" + code + ", birthday=" + birthday
				+ ", createDate=" + createDate + ", nick=" + nick
				+ ", address=" + address + ", phone=" + phone + ", mail="
				+ mail + ", role=" + role + ", head=" + head + ", gender="
				+ gender + "]";
	}

}