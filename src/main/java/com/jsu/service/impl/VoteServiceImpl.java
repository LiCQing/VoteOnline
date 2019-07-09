package com.jsu.service.impl;

import java.sql.Connection;
import java.util.List;

import com.jsu.dao.ItemDao;
import com.jsu.dao.OptionDao;
import com.jsu.dao.SOIDao;
import com.jsu.dao.SubjectDao;
import com.jsu.dao.impl.ItemDaoImpl;
import com.jsu.dao.impl.OptionDaoImpl;
import com.jsu.dao.impl.SOIDaoImpl;
import com.jsu.dao.impl.SubjectDaoImpl;
import com.jsu.en.Status;
import com.jsu.pojo.VoteItem;
import com.jsu.pojo.VoteOption;
import com.jsu.pojo.VoteSubject;
import com.jsu.service.VoteService;
import com.jsu.to.PageResult;
import com.jsu.util.DbTable;
import com.jsu.util.FtpUtil;
import com.jsu.util.JdbcUtil;

public class VoteServiceImpl implements VoteService {
	OptionDao optionDao = new OptionDaoImpl();
	SubjectDao subjectDao = new SubjectDaoImpl();
	ItemDao itemDao = new ItemDaoImpl();
	SOIDao SiDao = new SOIDaoImpl();

	public boolean addSubject(VoteSubject vs) throws Exception {
		Connection conn = null;
		boolean result = false;
		boolean def = false;
		// 获取连接，设置不自动提交事务
		try {
			conn = JdbcUtil.getConnection();
			def = conn.getAutoCommit();
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
			conn.setAutoCommit(def);
			JdbcUtil.closeConn(conn);
		}

		return result;
	}

	/**
	 * 为查找语句最后添加分页和查询
	 * 
	 * @param sql
	 * @param page
	 * @param row
	 * @param key
	 * @param type
	 *            1 所有 2 我的 3 查找
	 * @return
	 * @throws Exception
	 */
	private PageResult voteList(String sql, int userId, String page, String row, String key, int type)
			throws Exception {

		int start = (Integer.parseInt(page) - 1) * Integer.parseInt(row);
		int end =Integer.parseInt(row);

		sql += " LIMIT ?,?";

		List<VoteSubject> list;
		int total =0;
		
		if (type == 1) {
			list = subjectDao.selectPageSubject(sql, start, end);
			total = subjectDao.getTotalPage("SELECT COUNT(*) as num FROM " + DbTable.SUBJECT +" WHERE " + DbTable.SUBJECT_START + " < " +System.currentTimeMillis() ,null,row);
		} else if (type == 2) {
			list = subjectDao.selectPageSubject(sql, userId, start, end);
			total = subjectDao.getTotalPage("SELECT COUNT(*) as num FROM " + DbTable.SUBJECT +" WHERE " + DbTable.SUBJECT_START + " < " +System.currentTimeMillis()+" and "+ DbTable.USER_ID + " =?" ,userId+"",row);
		} else {
			list = subjectDao.selectPageSubject(sql, key, start, end);
			total = subjectDao.getTotalPage("SELECT COUNT(*) as num FROM " + DbTable.SUBJECT +" WHERE " + DbTable.SUBJECT_START + " < " +System.currentTimeMillis()+" and "+ DbTable.SUBJECT_TITLE + " like ?" ,key,row);
		}

		// 对获取的list 重新赋值 , 查看当前用户是否已经投票

		for (VoteSubject voteSubject : list) {
			VoteItem item = new VoteItem();
			item.setSubjecId(voteSubject.getId());
			item.setUserId(userId);
			if (itemDao.exits(item))
				voteSubject.setVoted(true);
			else {
				voteSubject.setVoted(false);
			}

			// 添加图片
			voteSubject.setUrl(FtpUtil.IMAGE_URL + optionDao.getSomeImg(voteSubject.getId()));
			//添加参与人数
			voteSubject.setCount(itemDao.countSomeSubject(voteSubject.getId()));
		}
		
		PageResult result = new PageResult();
		result.setCurrentPage(Integer.parseInt(page));
	
		result.setHasPre(!(1 == Integer.parseInt(page)));
		result.setHasNext(!(total == Integer.parseInt(page)));
		result.setList(list);
		result.setTotlePage(total);

		return result;
	}

	/**
	 * 所有列表
	 */
	public PageResult allVoteList(int userId, String page, String row) throws Exception {
		return voteList("SELECT * FROM " + DbTable.SUBJECT + "WHERE " + DbTable.SUBJECT_STATUS + " = "
				+ Status.NOMOR.getStatus() + " and " + DbTable.SUBJECT_START + " < " +System.currentTimeMillis() , userId, page, row, null, 1);
	}

	/**
	 * 模糊查找
	 */
	@Override
	public PageResult lookUpVoteList(int userId, String key, String page, String row) throws Exception {
		return voteList(
				"SELECT * FROM " + DbTable.SUBJECT + " WHERE " + DbTable.SUBJECT_STATUS + " = "
						+ Status.NOMOR.getStatus() + " and " + DbTable.SUBJECT_START + " < " +System.currentTimeMillis() + " and " + DbTable.SUBJECT_TITLE + " like ?",
				userId, page, row, "%" + key + "%", 3);
	}

	/**
	 * 用户发起的投票
	 */
	@Override
	public PageResult myVoteList(String userId, String page, String row) throws Exception {

		return voteList(
				"SELECT * FROM " + DbTable.SUBJECT + " WHERE " + DbTable.SUBJECT_STATUS + " = "
						+ Status.NOMOR.getStatus()+ " and " + DbTable.SUBJECT_START + " < " +System.currentTimeMillis()  + " and " + DbTable.USER_ID + " = ?",
				Integer.parseInt(userId), page, row, null, 2);
	}

	/**
	 * 置投票为删除状态
	 */
	@Override
	public boolean deleteVoteSbjec(int SubjectId) throws Exception {
		return subjectDao.delVoteSubject(SubjectId);
	}

	/**
	 * 通过id获取投票
	 * 
	 * @throws Exception
	 */
	@Override
	public VoteSubject getSubjetByid(int id) throws Exception {
		VoteSubject subject = subjectDao.getSubjectById(id);
		List<VoteOption> list = optionDao.getOptionListByVSid(subject.getId());
		
		subject.setOptionList(list);

		return subject;
	}

	@Override
	public boolean updateSubject(VoteSubject vs) throws Exception {
		Connection conn = null;
		boolean result = false;
		boolean def = false;
		// 获取连接，设置不自动提交事务
		try {
			conn = JdbcUtil.getConnection();
			def = conn.getAutoCommit();
			conn.setAutoCommit(false);

			// 先修改投票
			result = subjectDao.updateSubject(vs, conn);
			// 删除原选项
			result = result & optionDao.deleteOption(vs.getId(), conn);
			// 插入新选项
			System.out.println(vs.getId());
			result = result & optionDao.insertOption(vs.getOptionList(), vs.getId(), conn);
			// 判断是否需要回滚
			if (!result) {
				conn.rollback();
				System.out.println("插入回滚");
			} else {
				conn.commit();
			}
		} finally {
			conn.setAutoCommit(def);
			JdbcUtil.closeConn(conn);
		}
		return result;
	}
	/**
	 * 获取参与过的投票
	 */
	@Override
	public PageResult getListUserVoted(int userId, int page, int row) throws Exception {

		List<VoteSubject> list = subjectDao.getListUserVoted(userId, (page - 1) * row, (page - 1) * row + row);
		for (VoteSubject voteSubject : list) {
			VoteItem item = new VoteItem();
			item.setSubjecId(voteSubject.getId());
			item.setUserId(userId);
			voteSubject.setVoted(true);
			voteSubject.setUrl(FtpUtil.IMAGE_URL+optionDao.getSomeImg(voteSubject.getId()));
			voteSubject.setCount(itemDao.countSomeSubject(voteSubject.getId()));
			
		}
		
		PageResult result = new PageResult();
		
		result.setCurrentPage(page);
		int total = subjectDao.getTotalPage("SELECT count(*) as num FROM " +DbTable.SUBJECT +" where " + DbTable.USER_ID + " =?", userId+"", row+"");
		result.setTotlePage(total);
		result.setHasNext(total!=page);
		result.setHasPre(page!=1);
		result.setList(list);
		
		return result;
	}
	
	/**
	 * 判断是否有人投票
	 */
	@Override
	public boolean hasPeopleVoted(int subjecid) throws Exception {
		return itemDao.countSomeSubject(subjecid)==0?false:true;
	}
	/**
	 * 统计某投票有多少人参与
	 */
	@Override
	public int countSubjectVoted(int subjecid) throws Exception {
		return itemDao.countSomeSubject(subjecid);
	}
	/**
	 * 获取热门投票
	 * @throws Exception 
	 */
	@Override
	public List<VoteSubject> getHotVoteList(int userId) throws Exception {
		List<VoteSubject> list = SiDao.getHotList();
		for (VoteSubject voteSubject : list) {
			VoteItem item = new VoteItem();
			item.setSubjecId(voteSubject.getId());
			item.setUserId(userId);
			if (userId>0 && itemDao.exits(item))
				voteSubject.setVoted(true);
			else {
				voteSubject.setVoted(false);
			}
			voteSubject.setUrl(FtpUtil.IMAGE_URL+optionDao.getSomeImg(voteSubject.getId()));
		}
		return list;
	}
	
	

}
