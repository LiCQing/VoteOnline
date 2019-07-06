package com.jsu.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.jsu.dao.UserDao;
import com.jsu.pojo.User;
import com.jsu.util.DbTable;
import com.jsu.util.JdbcUtil;
import com.jsu.util.SqlExcute;

public class UserDaoImpl implements UserDao{

	@Override
	public boolean checkUserName(String name) throws Exception {
		String sql = "SELECT COUNT(*) AS num FROM " + DbTable.USER + " WHERE " + DbTable.USER_NAME + " = ?";
		Connection conn = JdbcUtil.getConnection();
		SqlExcute excute = new SqlExcute(conn);
		ResultSet rs = null;
		try{
		  rs = excute.ExecuteQuery(sql, name);
		  rs.next();
		  int num = rs.getInt("num");
		  if(num > 0){
			  return false;
		  }
		}finally{
			excute.closeResource();
		}
		return true;
	}

	@Override
	public boolean checkPhone(String phone) throws Exception {
		String sql = "SELECT COUNT(*) AS num FROM " + DbTable.USER + " WHERE " + DbTable.USER_PHONE + " = ?";
		Connection conn = JdbcUtil.getConnection();
		SqlExcute excute = new SqlExcute(conn);
		ResultSet rs = null;
		try{
		  rs = excute.ExecuteQuery(sql, phone);
		  rs.next();
		  int num = rs.getInt("num");
		  if(num > 0){
			  return false;
		  }
		}finally{
			excute.closeResource();
		}
		return true;
	}

	@Override
	public boolean insertUser(User user) throws Exception {
		String sql = "INSERT INTO " + DbTable.USER + " (" + DbTable.USER_NAME+","+DbTable.USER_PASSWORD + ","+DbTable.USER_PHONE +
				 ","+DbTable.USER_CREATE_TIME +"," + DbTable.USER_ACTIVE_TIME
				+" ) VALUES (?,?,?,?,?)";
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		System.out.println(sql);
		boolean res = excute.ExecuteUpdate(sql, user.getName(),user.getPassword(),user.getPhone(),user.getCreateTime(),user.getActiveTime());
		excute.closeResource();
		return res;
	}

	@Override
	public User getUserById(String name, String pass) throws Exception {
		String sql = "SELECT * FROM " + DbTable.USER + " WHERE " + DbTable.USER_NAME + "  =? and " + DbTable.USER_PASSWORD + " = ?";
		System.out.println(sql+"  " + name + " " + pass);
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		ResultSet rs = excute.ExecuteQuery(sql, name,pass);
		User user = new User();
		if(rs.next()){
			user.setName(name);
			user.setId(rs.getInt(DbTable.USER_ID));
			user.setStatus(rs.getInt(DbTable.USER_STATUS));
			user.setVervion(rs.getInt(DbTable.USER_VERSION));
			user.setPassword(rs.getString(DbTable.USER_PASSWORD));
			user.setNick(rs.getString(DbTable.USER_NICK));
		}else{
			excute.closeResource();
			return null;
		}
		excute.closeResource();
		return user;
	}
	
	@Override
	public boolean updatePass(User user) throws Exception {
		String sql = "update " + DbTable.USER + " set " + DbTable.USER_PASSWORD + " =? where " + DbTable.USER_ID + " = ?";
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		boolean b = excute.ExecuteUpdate(sql, user.getPassword(),user.getId());
		excute.closeResource();
		return b;
	}

	@Override
	public boolean updateInfo(User user) throws Exception {
		String sql = "update " + DbTable.USER + " set " +  DbTable.USER_PHONE +" =?," +
		DbTable.USER_STATUS+" =?, " + DbTable.USER_VERSION + " =? where " + DbTable.USER_ID + " = ?";
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		boolean b = excute.ExecuteUpdate(sql, user.getPhone(),user.getStatus(),user.getVervion(),user.getId());
		excute.closeResource();
		return b;
	}
	/**
	 * 获取所有用户
	 */
	@Override
	public List<User> getUserList(int start, int end) throws Exception {
		String sql = "SELECT * FROM " +DbTable.USER + " LIMIT ?,?" ;
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		ResultSet rs = excute.ExecuteQuery(sql, start,end);
		List<User> list = new ArrayList<>();
		while(rs.next()){
			User user = new User();
			user.setName(rs.getString(DbTable.USER_NAME));
			user.setId(rs.getInt(DbTable.USER_ID));
			user.setStatus(rs.getInt(DbTable.USER_STATUS));
			user.setVervion(rs.getInt(DbTable.USER_VERSION));
			user.setPhone(rs.getString(DbTable.USER_PHONE));
			//user.setPassword(rs.getString(DbTable.USER_PASSWORD));
			list.add(user);
		}
		excute.closeResource();
		return list;
	}

	@Override
	public boolean updateVersion(String id, String type) throws Exception {
		String sql = "update " + DbTable.USER + " set " + DbTable.USER_VERSION + " =? where " + DbTable.USER_ID + " = ?";
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		boolean b = excute.ExecuteUpdate(sql, type,id);
		excute.closeResource();
		return b;
	}

	@Override
	public int getTotlePage(int row) throws Exception {
		String sql="SELECT COUNT(*) as num FROM " + DbTable.USER;
		SqlExcute exe = new SqlExcute(JdbcUtil.getConnection());
		ResultSet rs = exe.ExecuteQuery(sql);
		int all = 0;
		if(rs.next()){
			all = rs.getInt("num");
			all = all % row ==0?all/row:(all/row)+1;
		}
		exe.closeResource();
		return all;
	}

	@Override
	public boolean updateStatus(String id, String status) throws Exception {
		String sql = "update " + DbTable.USER + " set " + DbTable.USER_STATUS + " = ? where " + DbTable.USER_ID + " = ?";
		System.out.println(id + " " + status);
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		boolean b=false;
		try{
			b= excute.ExecuteUpdate(sql, status,id);
		}catch(Exception e){
			e.printStackTrace();
		}
		excute.closeResource();
		return b;
	}
	/**
	 * 添加用户基本信息
	 */
	@Override
	public boolean updateUserBaseInfo(int id, String nick, String sex, long birthday) throws Exception {
		SqlExcute exe = new SqlExcute(JdbcUtil.getConnection());
		boolean f = exe.ExecuteUpdate(DbTable.UPDATE_USER_BASE_INFO, nick,sex,birthday,id);
		exe.closeResource();
		if(f) return true;
		return false;
	}
	/**
	 * 添加更多信息
	 */
	@Override
	public boolean updateUserMoreInfo(int id, String hobby, String carer, String addr) throws Exception {
		SqlExcute exe = new SqlExcute(JdbcUtil.getConnection());
		boolean f = exe.ExecuteUpdate(DbTable.UPDATE_USER_MORE_INFO, hobby,carer,addr,id);
		exe.closeResource();
		if(f) return true;
		return false;
	}

}
