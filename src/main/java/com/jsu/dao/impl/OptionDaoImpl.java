package com.jsu.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jsu.dao.OptionDao;
import com.jsu.pojo.VoteOption;
import com.jsu.util.DbTable;
import com.jsu.util.FtpUtil;
import com.jsu.util.JdbcUtil;
import com.jsu.util.SqlExcute;

public class OptionDaoImpl implements OptionDao {
	/**
	 * 插入新选项，因为选项最少需要两个，因此采用list存储传递
	 * 
	 * @param vsId
	 *            SubjectId用于记录所属投票
	 */
	public boolean insertOption(List<VoteOption> list, int vsId, Connection conn) throws Exception {
		SqlExcute excute = new SqlExcute(conn);
		// 插入选项
		String sql = "INSERT INTO" + DbTable.OPTION + "(" + DbTable.OPTION_TITLE + "," + DbTable.SUBJECT_ID + ","
				+ DbTable.OPTION_IMAGE + ") VALUES (?,?,?)";
		boolean result = true;
		for (VoteOption voteOption : list) {
			try{
				result = result & excute.ExecuteUpdate(sql, voteOption.getTitle(), vsId, voteOption.getImage());
			}finally{
				excute.closePreparedStatement();
			}
		}

		return result;
	}
	/**
	 * 获取投票id下面选项
	 * @param vsId
	 * @return
	 * @throws Exception
	 */
	public List<VoteOption> getOptionListByVSid(int vsId) throws Exception{
		String sql = "SELECT * FROM" + DbTable.OPTION + "WHERE " + DbTable.SUBJECT_ID + " = ?";
		// System.out.println(sql);
		//创建执行器
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		
		ResultSet rs = excute.ExecuteQuery(sql, vsId);
		//System.out.println(vsId);
		List<VoteOption> list = new ArrayList<VoteOption>();
		while (rs.next()) {
			list.add(rsToVoteOption(rs));
		}
		
		excute.closeResource();
		return list;
	}
	/**
	 * 将最新结果集转成对象
	 * @param rs
	 * @return
	 */
	private VoteOption rsToVoteOption(ResultSet rs) {
		VoteOption vo = new VoteOption();
		try {
			vo.setId(rs.getInt(DbTable.OPTION_ID));
			vo.setImage(FtpUtil.IMAGE_URL + rs.getString(DbTable.OPTION_IMAGE));
			vo.setOrder(rs.getInt(DbTable.OPTION_ORDER));
			vo.setSubjectId(rs.getInt(DbTable.SUBJECT_ID));
			vo.setTitle(rs.getString(DbTable.OPTION_TITLE));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
	}
	
	/**
	 * 根据ID修改选项 不修改vsid值
	 */
	@Override
	public boolean updateOption(List<VoteOption> optionList, Connection conn) throws Exception {
		SqlExcute excute = new SqlExcute(conn);
		boolean result = true;
		String sql = "UPDATE "+ DbTable.OPTION + " SET " + DbTable.OPTION_TITLE + " = ?," + DbTable.OPTION_IMAGE +" = ? WHERE " + DbTable.OPTION_ID + " = ?";
		for (VoteOption voteOption : optionList) {
			result = result & excute.ExecuteUpdate(sql, voteOption.getTitle(),voteOption.getImage(),voteOption.getId());
			excute.closePreparedStatement();
		}
		
		return result;
	}
	
	@Override
	public boolean deleteOption(int vsId, Connection conn) throws Exception {
		SqlExcute excute = new SqlExcute(conn);
		String sql = "DELETE FROM " + DbTable.OPTION + " WHERE " + DbTable.SUBJECT_ID + " = ?";
		boolean result = excute.ExecuteUpdate(sql, vsId);
		excute.closePreparedStatement();
		return result;
	}
	/**
	 * 加载某个投票中选项的第一张图片
	 */
	@Override
	public String getSomeImg(int id) throws Exception {
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		String sql = "SELECT " +DbTable.OPTION_IMAGE + " FROM " + DbTable.OPTION + " WHERE " + DbTable.SUBJECT_ID + " = ? limit 0,1";
		ResultSet rs = excute.ExecuteQuery(sql, id);
		try{
			if(rs.next()){
				return rs.getString(DbTable.OPTION_IMAGE);
			}
		}finally{
			excute.closeResource();
		}
		return null;
	}

}
