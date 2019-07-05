package com.jsu.pojo;

public class VoteOption {
	private int id;
	private String title;
	private int subjectId;
	private int order;
	private String image;
	
	//用户是否选择该选项
	private boolean voted;
	
	//选择统计
	private long Count;
	
	public VoteOption(){
		
	}
	
	public VoteOption(String title, int subjectId) {
		super();
		this.title = title;
		this.subjectId = subjectId;
	}



	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(int subjectId) {
		this.subjectId = subjectId;
	}
	public int getOrder() {
		return order;
	}
	public void setOrder(int order) {
		this.order = order;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}

	public long getCount() {
		return Count;
	}

	public void setCount(long count) {
		Count = count;
	}

	@Override
	public String toString() {
		return "VoteOption [id=" + id + ", title=" + title + ", subjectId=" + subjectId + ", order=" + order
				+ ", image=" + image + ", Count=" + Count + "]";
	}

	public boolean isVoted() {
		return voted;
	}

	public void setVoted(boolean voted) {
		this.voted = voted;
	}
	
	
}
