package com.jsu.dao;

import com.jsu.pojo.User;

public interface UserDao {

	boolean checkUserName(String name) throws Exception;

	boolean checkPhone(String phone) throws Exception;

	boolean insertUser(User user) throws Exception;

	User getUserById(String name, String pass) throws Exception ;

}
