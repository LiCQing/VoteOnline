package com.jsu.service;

import java.util.List;

import com.jsu.pojo.VoteSubject;
import com.jsu.to.PageResult;

public interface VoteService {
	public boolean addSubject(VoteSubject vs) throws Exception ;
	public PageResult allVoteList(int id, String page,String row)throws Exception;
	public PageResult lookUpVoteList(int id, String key,String page,String row)throws Exception;
	public PageResult myVoteList(String userId, String page,String row)throws Exception;
	public boolean deleteVoteSbjec(int SubjectId) throws Exception;
	public VoteSubject getSubjetByid(int parseInt) throws Exception;
	public boolean updateSubject(VoteSubject subjet) throws Exception;
	PageResult getListUserVoted(int userId, int page, int row) throws Exception;
	public boolean hasPeopleVoted(int subjecid)throws Exception;
	public int countSubjectVoted(int subjecid)throws Exception;
	public List<VoteSubject> getHotVoteList(int userId) throws Exception;
} 
