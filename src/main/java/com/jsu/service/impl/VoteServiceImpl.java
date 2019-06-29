package com.jsu.service.impl;

import java.sql.Connection;

import com.jsu.dao.OptionDao;
import com.jsu.dao.SubjectDao;
import com.jsu.dao.impl.OptionDaoImpl;
import com.jsu.dao.impl.SubjectDaoImpl;
import com.jsu.pojo.VoteSubject;
import com.jsu.service.VoteService;
import com.jsu.util.JdbcUtil;

public class VoteServiceImpl implements VoteService {
	OptionDao optionDao = new OptionDaoImpl();
	SubjectDao subjectDao = new SubjectDaoImpl();

	public boolean addSubject(VoteSubject vs) throws Exception {
		Connection conn= null;
		boolean result = false;
		// 获取连接，设置不自动提交事务
		try {
			conn = JdbcUtil.getConnection();
			conn.setAutoCommit(false);

			// 先插入投票
			result = subjectDao.insertSubject(vs, conn);
			// 获取投票id
			int vsId = subjectDao.getSubjectNewId(conn);
			// 插入选项
			result = result & optionDao.insertOption(vs.getOptionList(), vsId, conn);
			// 判断是否需要回滚
			if (!result) {
				conn.rollback();
				System.out.println("插入回滚");
			} else {
				conn.commit();
			}
		} finally {
			JdbcUtil.closeConn(conn);
		}

		return result;
	}

}
