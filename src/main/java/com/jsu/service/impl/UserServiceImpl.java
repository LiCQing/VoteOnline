package com.jsu.service.impl;

import java.util.Date;
import java.util.List;

import com.jsu.dao.UserDao;
import com.jsu.dao.impl.UserDaoImpl;
import com.jsu.pojo.User;
import com.jsu.pojo.UserInfo;
import com.jsu.service.UserService;
import com.jsu.to.CheckResult;
import com.jsu.to.PageResult;
import com.jsu.util.DateUtil;
import com.jsu.util.DbTable;

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
		User user = userDao.getUserByPass(name,pass);
		if(user!=null){
			userDao.updateUserActiveTime(user.getId(), DateUtil.getTimestamp());
		}
		return user;
	}
	/**
	 * 修改
	 */
	@Override
	public boolean updatePass(User user) throws Exception {
		return userDao.updatePass(user);
	}
	/**
	 *获取用户列表
	 */
	@Override
	public PageResult getUserList(String page, String row) throws Exception {
		int p = Integer.parseInt(page);
		int r = Integer.parseInt(row);
		
		PageResult result = new PageResult();
		result.setCurrentPage(p);
		result.setList(userDao.getUserList((p-1)*r, r));
		result.setHasPre(p==1?false:true);
		int totle = userDao.getTotlePage(r);
		result.setHasNext(p==totle?false:true);
		result.setTotlePage(totle); ;
		return result;
	}
	@Override
	public boolean changeUserVersion(String id, String type) throws Exception {
		return userDao.updateVersion(id,type);
	}
	@Override
	public boolean changeUserStatus(String id, String status) throws Exception {
		return userDao.updateStatus(id,status);
	}
	/**
	 * 添加用户基本信息
	 * 用户名，性别，生日
	 */
	@Override
	public boolean updateUserBaseInfo(int id, String nick, String sex, long birthday) throws Exception {
		return userDao.updateUserBaseInfo(id,nick,sex,birthday);
	}

	@Override
	public boolean updateUserMoreInfo(int id, String hobby, String career, String addr) throws Exception {
		return userDao.updateUserMoreInfo(id,hobby,career,addr);
	}
	/**
	 * 获取用户可发次数
	 */
	@Override
	public int getFreeTimes(int userId) throws Exception {
		return userDao.getFreeTimes(userId);
	}
	/**
	 * 更新用户免费次数
	 */
	@Override
	public boolean reduceFreeTimes(int id) throws Exception {
		return userDao.updateUserFreeTimes(id);
	}
	
	/**
	 * 获取用户全部信息
	 * @throws Exception 
	 */
	@Override
	public UserInfo getUserInfoById(int userId) throws Exception {
		UserInfo info = userDao.getUserMoreInfo(userId);
		info.setInfo(userDao.getUerBaseInfoById(userId));
		return info;
	}
}
