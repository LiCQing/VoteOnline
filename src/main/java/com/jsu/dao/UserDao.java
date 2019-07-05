package com.jsu.dao;

import java.util.List;

import com.jsu.pojo.User;

public interface UserDao {

	boolean checkUserName(String name) throws Exception;

	boolean checkPhone(String phone) throws Exception;

	boolean insertUser(User user) throws Exception;

	User getUserById(String name, String pass) throws Exception ;

	boolean updateInfo(User user)throws Exception ;

	boolean updatePass(User user) throws Exception;
	
	List<User> getUserList(int start,int end) throws Exception;

	boolean updateVersion(String id, String type)throws Exception;

	int getTotlePage(int row)throws Exception;

	boolean updateStatus(String id, String status)throws Exception;

}
