package com.jsu.dao;

import java.util.List;

import com.jsu.pojo.VoteSubject;
import com.jsu.to.HighchartsResult;
import com.jsu.to.OptionAnalyze;

public interface SOIDao {
	public List<VoteSubject> getHotList() throws Exception ;
	
	public  List<OptionAnalyze>  getSubjectSex(int subjectId) throws Exception;
}