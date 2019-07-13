package com.jsu.util;

public final class DbTable {
	//对应数据库的表和字段
	public final static String USER = " vote_user ";
	public final static String USER_ID = "vu_user_id";
	public final static String USER_NAME="vu_user_name";
	public final static String USER_PASSWORD ="vu_password";
	public final static String USER_PHONE="vu_phone";
	public final static String USER_STATUS="vu_status";
	public final static String USER_VERSION="vu_version";
	public final static String USER_NICK="vu_user_nick";
	public final static String USER_FREETIMES="vu_free_times";
	public final static String USER_CREATE_TIME="vu_create_time";
	public final static String USER_ACTIVE_TIME="vu_active_time";
	public final static String USER_SEX="vu_sex";
	public final static String USER_BIRTHDAY="vu_birthday";
	public final static String USER_ADDR="vu_addr"; 
	public final static String USER_HOBBY="vu_hobby"; 
	public final static String USER_CAREER="vu_career"; 

	
	public final static String SUBJECT=" vote_subject ";
	public final static String SUBJECT_ID="vs_id";
	public final static String SUBJECT_TITLE="vs_title";
	public final static String SUBJECT_TYPE="vs_type";
	public final static String SUBJECT_END="vs_end";
	public final static String SUBJECT_START="vs_start_time";
	public final static String SUBJECT_CREATE="vs_create_time";
	public final static String SUBJECT_STATUS="vs_status";
	public static final String SUBJECT_OPTION_COUNT = "vs_option_num";
	
	public final static String OPTION=" vote_option ";
	public final static String OPTION_ID="vo_id";
	public final static String OPTION_TITLE="vo_option";
	public final static String OPTION_ORDER="vo_order";
	public final static String OPTION_IMAGE="vo_image";
	
	public final static String ITEM="vote_item";
	public final static String ITEM_ID_="vi_id";
	
	//添加用户基本信息，增加免费次数，3
	public final static String UPDATE_USER_BASE_INFO = "update " + USER + " set " + USER_FREETIMES + " = " +USER_FREETIMES +" + 3," + USER_NICK + " = ?," +USER_SEX +"=?,"
							  +USER_BIRTHDAY+"=? WHERE " + USER_ID + "=?";
	
	//添加用户更多信息，设置版本为高级用户
	public static final String UPDATE_USER_MORE_INFO = "update " + USER + " set " +USER_VERSION + " = 1 ,"+USER_HOBBY + " = ?," +USER_CAREER+"=?,"
								+USER_ADDR+"=? WHERE " + USER_ID + "=?";

	//获取用户免费次数
	public static final String SELECT_FREETIMES ="SELECT " + USER_FREETIMES + " FROM  " +  USER + " WHERE " + USER_ID + " = ?";
	//普通用户发表投票减少次数
	public static final String REDUCE_FREETIMES = "UPDATE " + USER + " SET " + USER_FREETIMES +" = " + USER_FREETIMES + " -1 WHERE " +USER_ID + " = ?";
	
	
	//获取热门投票
	public static final String GET_HOT_SUBJECT = "" +
		" select *,count(vuser) as count from "+
		" ( select DISTINCT vs.*,vi.vu_user_id as vuser " +
			" from vote_subject vs join vote_item vi on vs.vs_id = vi.vs_id) as si " +
		" where vs_end > ? " +
		" GROUP BY vs_id " +
		" order by count desc " +
		 " limit 0,6 ";
	//获取最新发布的投票
	public static final String GET_NEW_SUBJECT = "";
	
	//获取某投票男女分布
	public static final String GET_SEX_FENGBU ="select vo.*,sum(if(sex=0,1,0)) as male,sum(if(sex=1,1,0)) as female "
			+ "from (SELECT vo_id,vu_sex as sex from vote_item vi JOIN vote_user vu on vi.vu_user_id = vu.vu_user_id "
			+ ") as iu right join vote_option as vo on iu.vo_id = vo.vo_id where vs_id = ? GROUP BY vo_id";
	
	//更新用户活跃时间
	public static final String UPDATE_ACTIVE_TIME="update "+ USER + " SET " + USER_ACTIVE_TIME + " = ? WHERE " + USER_ID + " = ?";

}
