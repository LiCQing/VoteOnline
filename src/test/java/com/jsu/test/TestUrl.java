package com.jsu.test;

import org.apache.commons.lang3.StringUtils;

import com.jsu.service.UserService;
import com.jsu.service.VoteService;
import com.jsu.service.impl.UserServiceImpl;
import com.jsu.service.impl.VoteServiceImpl;
import com.jsu.util.SqlExcute;

public class TestUrl {

	public static void main(String[] args) throws Exception {
		
		
		/*UserService userService = new UserServiceImpl();
		//userService.
		VoteService voteService= new VoteServiceImpl();
		voteService.myVoteList("6", "1", "6");
		
		SqlExcute.lookResource();*/
		String []hobby ={"1","3"};
		System.out.println(StringUtils.join(hobby, ","));
		
	}
	
	

}
