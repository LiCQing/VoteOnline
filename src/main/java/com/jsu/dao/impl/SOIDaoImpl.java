package com.jsu.dao.impl;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.jsu.dao.SOIDao;
import com.jsu.pojo.VoteSubject;
import com.jsu.to.HighchartsResult;
import com.jsu.to.OptionAnalyze;
import com.jsu.util.DateUtil;
import com.jsu.util.DbTable;
import com.jsu.util.JdbcUtil;
import com.jsu.util.SqlExcute;

public class SOIDaoImpl  implements SOIDao{
	/*
	 * 获取热门投票
	 */
	@Override
	public List<VoteSubject> getHotList() throws Exception {
		SqlExcute exe = new SqlExcute(JdbcUtil.getConnection());
		ResultSet rs = exe.ExecuteQuery(DbTable.GET_HOT_SUBJECT,DateUtil.getTimestamp());
		List<VoteSubject> list = new ArrayList<>();
		while(rs.next()){
			list.add(rsToVoteSubject(rs));
		}
		exe.closeResource();
		return list;
	}

	private VoteSubject rsToVoteSubject(ResultSet rs) {
		VoteSubject vs = new VoteSubject();
		try {
			
			vs.setId(rs.getInt(DbTable.SUBJECT_ID));
			vs.setType(rs.getInt(DbTable.SUBJECT_TYPE));
			vs.setStatus(rs.getInt(DbTable.SUBJECT_STATUS));
			vs.setTitile(rs.getString(DbTable.SUBJECT_TITLE));
			vs.setEnd(rs.getLong(DbTable.SUBJECT_END));
			vs.setUserId(rs.getInt(DbTable.USER_ID));
			vs.setStart(rs.getLong(DbTable.SUBJECT_START));
			vs.setCreate(rs.getLong(DbTable.SUBJECT_CREATE));
			vs.setCount(rs.getInt("count"));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vs;
	}
	
	/*
	 * 获取某投票性别分布
	 */
	@Override
	public List<OptionAnalyze> getSubjectSex(int subjectId) throws Exception {
		SqlExcute exe = new SqlExcute(JdbcUtil.getConnection());
		ResultSet rs = exe.ExecuteQuery(DbTable.GET_SEX_FENGBU,subjectId);
		List<OptionAnalyze> list = new ArrayList<>();
		while(rs.next()){
			OptionAnalyze oa = new OptionAnalyze();
			oa.setOptionId(rs.getInt(DbTable.OPTION_ID));
			oa.setOptionName(rs.getString(DbTable.OPTION_TITLE));
			oa.setMale(rs.getInt("male"));
			oa.setFemale(rs.getInt("female"));
			list.add(oa);
		}
		exe.closeResource();
		return list;
	}

}
