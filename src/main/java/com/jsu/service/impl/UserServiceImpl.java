package com.jsu.service.impl;

import java.util.Date;

import com.jsu.dao.UserDao;
import com.jsu.dao.impl.UserDaoImpl;
import com.jsu.pojo.User;
import com.jsu.service.UserService;
import com.jsu.to.CheckResult;

public class UserServiceImpl implements UserService {
	private UserDao userDao = new UserDaoImpl();
	@Override
	public CheckResult checkUserName(String name) throws Exception {
		if(userDao.checkUserName(name)){
			return CheckResult.T("账号可用 √ ");
		}else{
			return	CheckResult.F("账号已注册 × ");
		}
	}
	@Override
	public CheckResult checkPhone(String phone) throws Exception {
		if(userDao.checkPhone(phone)){
			return CheckResult.T("sign/verify?t=" + new Date().getTime());
		}else{
			return	CheckResult.F("该手机号已注册 × ");
		}
	}
	@Override
	public boolean addUser(User user) throws Exception {
		return userDao.insertUser(user);
	}
	@Override
	public User login(String name, String pass) throws Exception {
		
		return userDao.getUserById(name,pass);
	}

}
