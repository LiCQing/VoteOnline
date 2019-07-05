package com.jsu.dao;

import com.jsu.pojo.VoteItem;

public interface ItemDao {
	public boolean insertItem(VoteItem item) throws Exception;

	public boolean exits(VoteItem item) throws Exception;

	public long countSomeOption(int id)throws Exception;

	public int countSomeSubject(int subjecid)throws Exception;

	public boolean exitsUserAndOption(int userid, int optionid)throws Exception;
}
