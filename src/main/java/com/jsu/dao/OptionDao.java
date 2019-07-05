package com.jsu.dao;

import java.sql.Connection;
import java.util.List;

import com.jsu.pojo.VoteOption;

public interface OptionDao {
	public boolean insertOption(List<VoteOption> list,int vsId,Connection conn) throws Exception;
	public List<VoteOption> getOptionListByVSid(int vsId) throws Exception;
	public boolean updateOption(List<VoteOption> optionList, Connection conn) throws Exception;
	public boolean deleteOption(int vsId, Connection conn)throws Exception;
	public String getSomeImg(int id) throws Exception; 
}
