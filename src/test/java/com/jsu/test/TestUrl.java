package com.jsu.test;

import java.util.List;

import com.jsu.dao.impl.ItemDaoImpl;
import com.jsu.pojo.VoteItem;
import com.jsu.pojo.VoteSubject;
import com.jsu.service.VoteService;
import com.jsu.service.impl.VoteServiceImpl;
import com.jsu.util.UrlUtil;

public class TestUrl {

	public static void main(String[] args) throws Exception {
		
		/*VoteService service = new VoteServiceImpl();
		List<VoteSubject> list=null;
		//List<VoteSubject> list = service.allVoteList(1, 10);
		//list = service.lookUpVoteList("调查", 1, 10);
		//list=service.myVoteList("1", 1, 10);
		for (VoteSubject voteSubject : list) {
			System.out.println(voteSubject);
		}*/
		
		VoteItem item = new VoteItem();
		item.setSubjecId("656");
		item.setUserId("1");
		
		//System.out.println(UrlUtil.getUriOfMiddle("check/username/1354"));
		boolean exits = new ItemDaoImpl().exits(item );
		System.out.println(exits);
	}
	
	

}
