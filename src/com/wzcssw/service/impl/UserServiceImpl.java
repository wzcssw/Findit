package com.wzcssw.service.impl;

import java.util.List;

import com.wzcssw.dao.UserDAO;
import com.wzcssw.domain.User;
import com.wzcssw.service.UserService;
import com.wzcssw.util.Page;

public class UserServiceImpl implements UserService {
	private UserDAO dao;

	public UserDAO getDao() {
		return dao;
	}

	public void setDao(UserDAO dao) {
		this.dao = dao;
	}

	public User findUserById(String uid) {
		return dao.findUserById(uid);
	}

	public User findUserByName(String username) {
		return dao.findUserByName(username);
	}

	public User findUser(String username, String password) {
		return dao.findUser(username, password);
	}

	public Page<User> findAllUser(int pageNum, int pageCount) {
		int sum = (int) dao.countUser();
		Page<User> page = new Page<User>(pageNum,sum,pageCount);
		List<User> list = dao.findAllUser(page.getStart(),  pageCount);
		page.setData(list);
		return page;
	}

	public void addUser(User user) {
		dao.addUser(user);
	}

	public void delUser(User user) {
		dao.delUser(user);
	}

	public void updateUser(User user) {
		dao.updateUser(user);
	}

	public List<User> findAllUser() {
		List<User> list = dao.findAllUser();
		return list;
	}

	public User findUserByCode(String code) {
		return dao.findUserByCode(code);
	}

	public int countUsers() {
		return dao.countUser();
	}
	
}
