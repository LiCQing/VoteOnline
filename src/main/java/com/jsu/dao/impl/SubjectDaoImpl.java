package com.jsu.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jsu.dao.SubjectDao;
import com.jsu.en.Status;
import com.jsu.pojo.VoteOption;
import com.jsu.pojo.VoteSubject;
import com.jsu.util.DbTable;
import com.jsu.util.JdbcUtil;
import com.jsu.util.SqlExcute;

/**
 * 投票数据持久层
 * 
 * @author !N
 *
 */
public class SubjectDaoImpl implements SubjectDao {
	/**
	 * 添加新投票 同时添加新选项，如果未成功插入则回滚
	 * 
	 * @throws Exception
	 */
	public boolean insertSubject(VoteSubject subject, Connection conn) throws Exception {
		String sql = "INSERT INTO" + DbTable.SUBJECT + "(" + DbTable.SUBJECT_TITLE + "," + DbTable.SUBJECT_TYPE + ","
				+ DbTable.SUBJECT_END + ") VALUES (?,?,?)";

		// 创建执行类
		SqlExcute excute = new SqlExcute(conn);
		// 插入投票
		boolean result = false;
		try {
			result = excute.ExecuteUpdate(sql, subject.getTitile(), subject.getType(), subject.getEnd());
		} finally {
			excute.closePreparedStatement();
		}

		return result;
	}

	/**
	 * 获取最新插入的id，为了保证线程id正常，采用同一个connection对象
	 */
	public int getSubjectNewId(Connection conn) throws Exception {
		SqlExcute excute = new SqlExcute(conn);
		ResultSet set = excute.ExecuteQuery("SELECT LAST_INSERT_ID() AS id");
		set.next();
		int result = set.getInt("id");
		excute.closeResultSet();
		return result;
	}
	/**
	 * 通过id获取投票对象
	 */
	public VoteSubject getSubjectById(int vsId) throws Exception {
		// 创建执行器
		SqlExcute excute = new SqlExcute(JdbcUtil.getConnection());
		VoteSubject vs = null;
		String sql = "SELECT * FROM" + DbTable.SUBJECT + "WHERE " + DbTable.SUBJECT_ID + " = ?";
		// System.out.println(sql);
		ResultSet rs = excute.ExecuteQuery(sql, vsId);
		rs.next();
		vs = rsToVoteSubject(rs);

		excute.closeResource();
		return vs;
	}
	/**
	 * 将结果集的最新一个转成对象
	 * @param rs
	 * @return
	 */
	private VoteSubject rsToVoteSubject(ResultSet rs) {
		VoteSubject vs = new VoteSubject();
		try {
			vs.setId(rs.getInt(DbTable.SUBJECT_ID));
			vs.setType(rs.getInt(DbTable.SUBJECT_TYPE));
			vs.setStatus(rs.getInt(DbTable.SUBJECT_STATUS));
			vs.setTitile(rs.getString(DbTable.SUBJECT_TITLE));
			vs.setEnd(rs.getLong(DbTable.SUBJECT_END));
			vs.setUserId(rs.getInt(DbTable.USER_ID));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return vs;
	}

	/**
	 * 根据不同的请求语句，返回一页投票列表
	 */
	@Override
	public List<VoteSubject> selectPageSubject(String sql, Object... param) throws Exception {
		List<VoteSubject> list = new ArrayList<>();;
		SqlExcute excute = null;
		try {
			Connection conn = JdbcUtil.getConnection();
			excute = new SqlExcute(conn);
			ResultSet rs = excute.ExecuteQuery(sql, param);
			while (rs.next())
				list.add(rsToVoteSubject(rs));
		} finally {
			excute.closeResource();
		}
		return list;
	}

	/**
	 * 根据投票id置投票为删除状态
	 */
	@Override
	public boolean delVoteSubject(int subjectId) throws Exception {
		String sql = "UPDATE " +DbTable.SUBJECT + " SET "+ DbTable.SUBJECT_STATUS + " = " + Status.DELETE.getStatus() + " WHERE " + DbTable.SUBJECT_ID + " = ?";
		SqlExcute excute = null;
		boolean r = false;
		try {
			Connection conn = JdbcUtil.getConnection();
			excute = new SqlExcute(conn);
			r = excute.ExecuteUpdate(sql, subjectId);
		} finally {
			excute.closeResource();
		}
		return r;
	}
	/**
	 * 根据ID修改投票信息
	 */
	@Override
	public boolean updateSubject(VoteSubject vs, Connection conn) throws Exception {
		SqlExcute excute = new SqlExcute(conn);
		String sql = "UPDATE "+ DbTable.SUBJECT + " SET " + DbTable.SUBJECT_TITLE + " = ?," + DbTable.SUBJECT_TYPE + " = ?,"
		+DbTable.SUBJECT_END + " = ? WHERE " + DbTable.SUBJECT_ID + " = ?";
		boolean result = excute.ExecuteUpdate(sql, vs.getTitile(),vs.getType(),vs.getEnd(),vs.getId());
		excute.closePreparedStatement();
		return result;
	}

}
