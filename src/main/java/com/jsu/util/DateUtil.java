package com.jsu.util;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	/**
	 * 2000-10-1 转 时间戳
	 * @param strDate
	 * @return
	 */
	public static long StringToMilliseconds(String strDate) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		ParsePosition pos = new ParsePosition(0);
		Date strtodate = formatter.parse(strDate, pos);
		return strtodate.getTime()/1000;
	}
	/**
	 * 时间戳转 2000-10-1
	 * @param seconds
	 * @return
	 */
	public static String MilinsecondsToStringDate(long seconds) {
		String res;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date(seconds);
		res = simpleDateFormat.format(date);
		return res;
	}
	
	public static Long getTimestamp(){
		return System.currentTimeMillis()/1000;
	}
}
