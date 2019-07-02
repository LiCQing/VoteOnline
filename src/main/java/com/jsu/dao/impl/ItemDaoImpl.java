package com.jsu.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;

import com.jsu.dao.ItemDao;
import com.jsu.pojo.VoteItem;
import com.jsu.util.DbTable;
import com.jsu.util.JdbcUtil;
import com.jsu.util.SqlExcute;

public class ItemDaoImpl implements ItemDao {
	/**
	 * 插入新的投票数据
	 */
	@Override
	public boolean insertItem(VoteItem item) throws Exception {
		Connection conn= JdbcUtil.getConnection();
		boolean def = false;
		String Sql = "INSERT INTO " + DbTable.ITEM + " ( " + DbTable.SUBJECT_ID + "," + DbTable.USER_ID + "," + DbTable.OPTION_ID
				+") VALUES (?,?,?)";
		boolean result = true;
		SqlExcute excute = new SqlExcute(conn);
		// 获取连接，设置不自动提交事务
		try {
			def=conn.getAutoCommit();
			conn.setAutoCommit(false);
			for(String optionid:item.getOptionId()){
				result = result & excute.ExecuteUpdate(Sql, item.getSubjecId(),item.getUserId(),optionid);
			}
			
			if (!result ) {
				conn.rollback();
			} else {
				conn.commit();
			}
		} finally {
			conn.setAutoCommit(def);
			excute.closePreparedStatement();
		}

		return result;
	}
	/**
	 * 判断用户是否已经投过改项目
	 */
	@Override
	public boolean exits(VoteItem item) throws Exception {
		String sql = "SELECT COUNT(*) AS num FROM " + DbTable.ITEM + " WHERE " + DbTable.SUBJECT_ID +" = ? and " + DbTable.USER_ID + " = ?" ;
		//System.out.println(sql);
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		ResultSet rs = excute.ExecuteQuery(sql, item.getSubjecId(),item.getUserId());
		if(rs.next()){
			if(rs.getInt("num") != 0){
				return true;
			}
		}
		excute.closeResource();
		return false;
	}
	@Override
	public long countSomeOption(int id) throws Exception {
		String sql = "select count(*) as num from " + DbTable.ITEM + " where " +DbTable.OPTION_ID + " = ?";
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		ResultSet rs = excute.ExecuteQuery(sql, id);
		long re = 0;
		if(rs.next()){
			re = rs.getInt("num");
		}
		excute.closeResource();
		return re;
	}

}
