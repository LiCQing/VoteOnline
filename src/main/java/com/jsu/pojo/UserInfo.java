package com.jsu.pojo;

public class UserInfo extends User{
	private int sex;
	private long birthDay;
	private int addr;
	private String hobby;
	private int career;
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public long getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(long birthDay) {
		this.birthDay = birthDay;
	}
	public int getAddr() {
		return addr;
	}
	public void setAddr(int addr) {
		this.addr = addr;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public int getCareer() {
		return career;
	}
	public void setCareer(int career) {
		this.career = career;
	}
	
	public void setInfo(User user){
		this.setId(user.getId());
		this.setName(user.getName());
		this.setNick(user.getNick());
		this.setPhone(user.getPhone());
		this.setStatus(user.getStatus());
		this.setVervion(user.getVervion());
		this.setCreateTime(user.getCreateTime());
		this.setActiveTime(user.getActiveTime());
		this.setFreeTimes(user.getFreeTimes());
	}
	@Override
	public String toString() {
		return super.toString() + "UserInfo [sex=" + sex + ", birthDay=" + birthDay + ", addr=" + addr + ", hobby=" + hobby + ", career="
				+ career + "]";
	}
	
	
	
}
