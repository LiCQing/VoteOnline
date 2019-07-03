package com.jsu.dao;

import java.sql.Connection;
import java.util.List;

import com.jsu.pojo.VoteSubject;

public interface SubjectDao {
	//插入新投票
	public boolean insertSubject(VoteSubject subject,Connection conn) throws Exception;
	//获取投票
	public VoteSubject getSubjectById(int vsId) throws Exception;
	//投票id返回
	public int getSubjectNewId(Connection conn) throws Exception;
	
	public List<VoteSubject> selectPageSubject(String sql,Object... param) throws Exception;
	
	public boolean delVoteSubject(int subjectId)throws Exception;
	public boolean updateSubject(VoteSubject vs, Connection conn) throws Exception;
	public List<VoteSubject> getListUserVoted(int userId, int page, int row)throws Exception;
}
