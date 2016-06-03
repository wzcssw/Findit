package com.wzcssw.service;

import java.util.List;

import com.wzcssw.domain.User;
import com.wzcssw.util.Page;

public interface UserService {
	User findUserById(String uid);

	User findUserByName(String username);

	User findUserByCode(String code);
	
	User findUser(String username, String password);

	Page<User> findAllUser(int pageNum,int pageCount);
	
	List<User> findAllUser();

	void addUser(User user);

	void delUser(User user);
	
	void updateUser(User user);
	
	int countUsers();

}
