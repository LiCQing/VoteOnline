package com.jsu.pojo;

public class User {
	private Integer id;
	private String name;
	private String password;
	private String phone;
	private Integer status;
	private Integer vervion;
	
	public User(){
		
	}
	
	
	
	public User(String name, String password, String phone) {
		super();
		this.name = name;
		this.password = password;
		this.phone = phone;
	}



	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getVervion() {
		return vervion;
	}
	public void setVervion(int vervion) {
		this.vervion = vervion;
	}



	public String check() {
		if(name == null || password == "" || phone == null){
			return "未提交相关参数";
		}
		if(name.equals("") || name.equals("")||phone.equals("")){
			return "提交了空值";
		}
	
		return null;
	}
	
	
}
