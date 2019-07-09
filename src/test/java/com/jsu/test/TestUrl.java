package com.jsu.test;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.jsu.dao.SOIDao;
import com.jsu.dao.impl.SOIDaoImpl;
import com.jsu.pojo.VoteSubject;
import com.jsu.service.AnalyzeService;
import com.jsu.service.UserService;
import com.jsu.service.VoteService;
import com.jsu.service.impl.AnalyzeServiceImpl;
import com.jsu.service.impl.UserServiceImpl;
import com.jsu.service.impl.VoteServiceImpl;
import com.jsu.to.HighchartsResult;
import com.jsu.to.OptionAnalyze;
import com.jsu.util.JsonUtils;
import com.jsu.util.SqlExcute;

public class TestUrl {

	public static void main(String[] args) throws Exception {
		
		
		/*UserService userService = new UserServiceImpl();
		//userService.
		VoteService voteService= new VoteServiceImpl();
		voteService.myVoteList("6", "1", "6");
		
		SqlExcute.lookResource();*/
		/*String []hobby ={"1","3"};
		System.out.println(StringUtils.join(hobby, ","));*/
		
		/*SubjectAndItemDao dao = new SubjectAndItemDaoImpl();
		List<VoteSubject> list = dao.getHotList();
		for (VoteSubject voteSubject : list) {
			System.out.println(voteSubject);
		}*/
		
		/*HighchartsResult res = HighchartsResult.column("性别分布","性别");
		res.setxAxis("中国","美国");
		res.addData("中国人","red", 1,2);
		res.addData("外国人","bulue" ,6,2);
		
		//res.init();,
		System.out.println(JsonUtils.objectToJson(res));*/
		
		/*SOIDao dao = new SOIDaoImpl();
		List<OptionAnalyze> list = dao.getSubjectSex(659);
		for (OptionAnalyze optionAnalyze : list) {
			System.out.println(optionAnalyze.getOptionName()+ " " + optionAnalyze.getMale() );
		}*/
		
		/*AnalyzeService as = new AnalyzeServiceImpl();
		HighchartsResult rs = as.getOptionSex(659);
		System.out.println(JsonUtils.objectToJson(rs));*/
		
	}
	
	

}
