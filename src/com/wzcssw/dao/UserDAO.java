package com.wzcssw.dao;

import java.util.List;

import com.wzcssw.domain.User;

public interface UserDAO {
	User findUserById(String uid);

	User findUser(String username, String password);

	User findUserByName(String username);
	
	User findUserByCode(String code);

	List<User> findAllUser(int start, int pageCount);
	
	List<User> findAllUser();

	void addUser(User user);

	void delUser(User user);

	void updateUser(User user);
	
	int countUser();

}
