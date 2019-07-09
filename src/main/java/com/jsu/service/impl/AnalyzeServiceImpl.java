package com.jsu.service.impl;

import java.util.List;

import com.jsu.dao.SOIDao;
import com.jsu.dao.impl.SOIDaoImpl;
import com.jsu.service.AnalyzeService;
import com.jsu.to.HighchartsResult;
import com.jsu.to.OptionAnalyze;

public class AnalyzeServiceImpl implements AnalyzeService {
	SOIDao soiDao = new SOIDaoImpl();
	@Override
	public HighchartsResult getOptionSex(int subjectId) throws Exception {
		List<OptionAnalyze> list = soiDao.getSubjectSex(subjectId);
		HighchartsResult chart = HighchartsResult.column("性别分布", "性别");
		int len = list.size();
		String[] x = new String[len];
		int[] male = new int[len];
		int[] female = new int[len];
		
		for (int i = 0; i <len ; i++) {
			//chart.setxAxis(oa.getOptionName());
			OptionAnalyze oa = list.get(i);
			x[i]=oa.getOptionName();
			male[i]=oa.getMale();
			female[i] =oa.getFemale();
		}
		
		chart.setxAxis(x);
		chart.addData("男", female);
		chart.addData("女", "#EC6AA1", male);
		
		return chart;
	}

}
