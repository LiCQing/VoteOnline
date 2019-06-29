package com.jsu.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jsu.dao.OptionDao;
import com.jsu.pojo.VoteOption;
import com.jsu.util.DbTable;
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
	
	public List<VoteOption> getOptionListByVSid(int vsId) throws Exception{
		String sql = "SELECT * FROM" + DbTable.OPTION + "WHERE " + DbTable.SUBJECT_ID + " = ?";
		// System.out.println(sql);
		//创建执行器
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		
		ResultSet rs = excute.ExecuteQuery(sql, vsId);
		
		List<VoteOption> list = new ArrayList<VoteOption>();
		while (rs.next()) {
			list.add(rsToVoteOption(rs));
		}
		return list;
	}
	
	private VoteOption rsToVoteOption(ResultSet rs) {
		VoteOption vo = new VoteOption();
		try {
			vo.setId(rs.getInt(DbTable.OPTION_ID));
			vo.setImage(rs.getString(DbTable.OPTION_IMAGE));
			vo.setOrder(rs.getInt(DbTable.OPTION_ORDER));
			vo.setSubjectId(rs.getInt(DbTable.SUBJECT_ID));
			vo.setTitle(rs.getString(DbTable.OPTION_TITLE));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
	}

}
