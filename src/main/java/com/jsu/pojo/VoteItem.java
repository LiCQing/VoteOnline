package com.jsu.pojo;

public class VoteItem {
	private String subjecId;
	private String userId;
	private String[] optionId;

	public String getSubjecId() {
		return subjecId;
	}
	public void setSubjecId(String subjecId) {
		this.subjecId = subjecId;
	}
	
	public void setSubjecId(int subjecId) {
		this.subjecId = subjecId + "";
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public void setUserId(int userId) {
		this.userId =userId+"";
	}
	public String[] getOptionId() {
		return optionId;
	}
	public void setOptionId(String[] optionId) {
		this.optionId = optionId;
	}
	public boolean check() {
		if(subjecId == null || userId==null || optionId==null){
			return false;
		}
		if(subjecId.equals("") || userId.equals("") || optionId.equals("")){
			return false;
		}
		return true;
	}
	
	
}
