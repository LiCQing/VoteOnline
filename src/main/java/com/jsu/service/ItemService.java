package com.jsu.service;

import com.jsu.pojo.VoteItem;

public interface ItemService {
	public boolean votiong(VoteItem item) throws Exception;
	public boolean exits(VoteItem item)throws Exception ;
	public long countNum(int id) throws Exception ;;
}
