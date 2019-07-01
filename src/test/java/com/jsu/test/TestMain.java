package com.jsu.test;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jsu.dao.impl.SubjectDaoImpl;
import com.jsu.pojo.VoteOption;
import com.jsu.pojo.VoteSubject;
import com.jsu.service.impl.VoteServiceImpl;
import com.jsu.util.DateUtil;

public class TestMain {

	public static void main(String[] args) {
		//testInsert();
		//TestQuery(22);
		//testThreadInsert();
		long s = DateUtil.StringToMilliseconds("2019-07-29");
		System.out.println(s);
		String time= DateUtil.MilinsecondsToStringDate(s);
		System.out.println(time);
		
	
		
	}
	
	private static void testDate(String strDate) {
		 SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		 ParsePosition pos = new ParsePosition(0);
		 Date strtodate = formatter.parse(strDate, pos);
		System.out.println(strtodate.getTime());
	}

	public static void testThreadInsert(){
		for(int i = 0 ; i < 10 ; i ++){
			 new SubjectThread(i+"").start();;
			
		}
	}
	
	public static void TestQuery(int id){
		try {
			VoteSubject subject = new SubjectDaoImpl().getSubjectById(id);
			System.out.println(subject);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public static void testInsert(){
		VoteSubject subject = new VoteSubject("choose your hobby",0,new Date().getTime());
		List<VoteOption> list = new ArrayList();
		
		for(int i = 0 ; i < 5 ; i++){
			VoteOption vo = new VoteOption();
			vo.setTitle("选项" + i);
			list.add(vo);
		}
		
		subject.setOptionList(list);
		boolean b =false;
		try {
			b = new VoteServiceImpl().addSubject(subject);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(b);
	}
}
