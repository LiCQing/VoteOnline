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
	public final static String SUBJECT_STATUS="vs_status";
	
	public final static String OPTION=" vote_option ";
	public final static String OPTION_ID="vo_id";
	public final static String OPTION_TITLE="vo_option";
	public final static String OPTION_ORDER="vo_order";
	public final static String OPTION_IMAGE="vo_image";
	
	public final static String ITEM="vote_item";
	public final static String ITEM_ID_="vi_id";
	
	public final static String UPDATE_USER_BASE_INFO = "update " + USER + " set " + USER_NICK + " = ?," +USER_SEX +"=?,"+USER_BIRTHDAY+"=? WHERE " + USER_ID + "=?";
	public static final String UPDATE_USER_MORE_INFO = "update " + USER + " set " + USER_HOBBY + " = ?," +USER_CAREER+"=?,"+USER_ADDR+"=? WHERE " + USER_ID + "=?";
	

}
