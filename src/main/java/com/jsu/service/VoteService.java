package com.jsu.service;

import java.util.List;

import com.jsu.pojo.VoteSubject;

public interface VoteService {
	public boolean addSubject(VoteSubject vs) throws Exception ;
	public List<VoteSubject> allVoteList(String page,String row)throws Exception;
	public List<VoteSubject> lookUpVoteList(String key,String page,String row)throws Exception;
	public List<VoteSubject> myVoteList(String userId, String page,String row)throws Exception;
	public boolean deleteVoteSbjec(int SubjectId) throws Exception;
	public VoteSubject getSubjetByid(int parseInt) throws Exception;
	public boolean updateSubject(VoteSubject subjet) throws Exception;
} 
