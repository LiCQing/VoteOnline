package com.jsu.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;

import com.jsu.dao.UserDao;
import com.jsu.en.Status;
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
		String sql = "INSERT INTO " + DbTable.USER + " (" + DbTable.USER_NAME+","+DbTable.USER_PASSWORD + ","+DbTable.USER_PHONE
				+" ) VALUES (?,?,?)";
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		System.out.println(sql);
		boolean res = excute.ExecuteUpdate(sql, user.getName(),user.getPassword(),user.getPhone());
		excute.closePreparedStatement();
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
		}else{
			return null;
		}
		return user;
	}

}
