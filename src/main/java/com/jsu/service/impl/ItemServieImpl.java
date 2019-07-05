package com.jsu.service.impl;


import com.jsu.dao.ItemDao;
import com.jsu.dao.impl.ItemDaoImpl;
import com.jsu.pojo.VoteItem;
import com.jsu.service.ItemService;

public class ItemServieImpl implements ItemService {
	private ItemDao itemdao = new ItemDaoImpl(); 
	
	/**
	 * 插入数据
	 */
	@Override
	public boolean votiong(VoteItem item) throws Exception {
		
		return itemdao.insertItem(item);
	}
	/**
	 * 判断是否存在
	 * @param item
	 * @return
	 * @throws Exception
	 */
	public boolean exits(VoteItem item)throws Exception {
		return itemdao.exits(item);
	}
	@Override
	public long countNum(int id) throws Exception {
		return itemdao.countSomeOption(id);
	}
	@Override
	public boolean exitsOption(int userid, int optionid) throws Exception {
		return itemdao.exitsUserAndOption(userid,optionid);
	}

}
