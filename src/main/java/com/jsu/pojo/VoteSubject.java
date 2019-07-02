package com.jsu.pojo;

import java.util.List;

import com.jsu.util.DateUtil;

public class VoteSubject {
	private int id;
	private int userId;
	private String titile;
	private int type;
	private Long end; // 时间戳
	private int status;

	private List<VoteOption> optionList;
	
	//附加状态，登陆用户是否已投票
	private boolean voted;

	public VoteSubject() {

	}

	public VoteSubject(String titile, int type, Long end) {
		super();
		this.titile = titile;
		this.type = type;
		this.end = end;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitile() {
		return titile;
	}

	public void setTitile(String titile) {
		this.titile = titile;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Long getEnd() {
		return end;
	}

	public void setEnd(Long end) {
		this.end = end;
	}

	public int getStatus() {
		return status;
	}
	
	public String getendDay(){
		return DateUtil.MilinsecondsToStringDate(end);
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public List<VoteOption> getOptionList() {
		return optionList;
	}

	public void setOptionList(List<VoteOption> optionList) {
		this.optionList = optionList;
	}

	@Override
	public String toString() {
		return "VoteSubject [id=" + id + ", titile=" + titile + ", type=" + type + ", end=" + end + ", status=" + status
				+ ", optionList=" + printList() + "]";
	}

	private String printList() {
		if(optionList == null){
			System.out.print("null");
			return "";
		}
		for (VoteOption voteOption : optionList) {
			System.out.println(voteOption);
		}
		return "";
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setType(String type) {
		this.type = Integer.parseInt(type);
	}

	public boolean isVoted() {
		return voted;
	}

	public void setVoted(boolean voted) {
		this.voted = voted;
	}

}
