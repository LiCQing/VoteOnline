package com.jsu.test;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jsu.pojo.VoteOption;
import com.jsu.pojo.VoteSubject;
import com.jsu.service.VoteService;
import com.jsu.service.impl.VoteServiceImpl;

public class SubjectThread extends Thread {
	VoteService service = new VoteServiceImpl();
	public String name;
	
	public SubjectThread(String name) {
		this.name = name;
	}
    public void run(){
    	VoteSubject vs = new VoteSubject("投票项目"+name,1,new Date().getTime());
    	List<VoteOption> list = new ArrayList<>();
    	for(int i = 0 ; i< 2 ;  i++){
    		VoteOption vo = new VoteOption();
    		vo.setTitle("投票项目是"+name+"选项是"+ i);
    		list.add(vo);
    		
    	}
    	vs.setOptionList(list);
    	
    	//System.out.println(vs);
    	try {
			service.addSubject(vs);
			System.out.println(name + " 插入完成");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    }
    
}

