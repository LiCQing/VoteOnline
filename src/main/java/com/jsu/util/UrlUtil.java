package com.jsu.util;

public class UrlUtil {
	
	public static String getUriOfLast(String url){
		if(url == null){
			return "";
		}
		int i = url.lastIndexOf("/");
		return url.substring(i + 1);
	}
	
	public static String getUriOfMiddle(String url){
		if(url == null){
			return "";
		}
		int next = 0;
		int i=0,j=0;
		while(next != -1){
			j = url.indexOf("/",i+1);
			next = url.indexOf("/", j+1);
			
			if(next != -1){
				i = j;
				j = next;
			}
			
		}
	
		return url.substring(i + 1,j);
	}

}
