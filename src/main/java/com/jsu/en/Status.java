package com.jsu.en;

public enum Status {
	NOMOR("正常", 0), DELETE("已删除", -1); 
	
	private  String info;
	private  int status;

	private Status(String info,int statu){
		this.info = info;
		this.status = statu;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
	
	
}
