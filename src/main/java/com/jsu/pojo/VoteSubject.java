package com.jsu.pojo;

import java.util.List;

public class VoteSubject {
	private int id;
	private String titile;
	private int type;
	private Long end;  //时间戳
	private int status;
	
	private List<VoteOption> optionList;
	
	public VoteSubject(){
		
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
		for (VoteOption voteOption : optionList) {
			System.out.println(voteOption);
		}
		return "";
	}
	
	
	
}
