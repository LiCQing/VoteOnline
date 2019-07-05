package com.jsu.service;

import java.util.List;

import com.jsu.pojo.User;
import com.jsu.to.CheckResult;
import com.jsu.to.PageResult;

public interface UserService {
	public CheckResult checkUserName(String name) throws Exception;

	public CheckResult checkPhone(String phone)throws Exception;

	public boolean addUser(User user)throws Exception;

	public User login(String name, String pass) throws Exception ;

	public boolean updatePass(User user)throws Exception ;

	public PageResult getUserList(String page, String row)throws Exception ;

	public boolean changeUserVersion(String id, String type)throws Exception ;

	public boolean changeUserStatus(String id, String status)throws Exception ;

}
