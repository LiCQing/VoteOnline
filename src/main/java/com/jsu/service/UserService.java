package com.jsu.service;

import com.jsu.pojo.User;
import com.jsu.to.CheckResult;

public interface UserService {
	public CheckResult checkUserName(String name) throws Exception;

	public CheckResult checkPhone(String phone)throws Exception;

	public boolean addUser(User user)throws Exception;

	public User login(String name, String pass) throws Exception ;
}
