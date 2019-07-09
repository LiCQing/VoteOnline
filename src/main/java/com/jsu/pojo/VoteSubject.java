package com.jsu.pojo;

import java.util.Date;
import java.util.List;

import com.jsu.util.DateUtil;

public class VoteSubject {
	private int id;
	private int userId;
	private String titile;
	private int type;
	private Long end; // 时间戳
	private Long start;
	private Long create;
	
	private int status;

	private List<VoteOption> optionList;
	
	//附加状态，登陆用户是否已投票
	private boolean voted;
	//附加状态 , 获取一个选项图片
	private String url;
	//附加投票人数
	private int count;
	//附加
	private int optionNum;
	
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
		return "VoteSubject [id=" + id + ", userId=" + userId + ", titile=" + titile + ", type=" + type + ", end=" + end
				+ ", start=" + start + ", create=" + create + ", status=" + status + ", optionList=" + printList() 
				+ ", voted=" + voted + ", url=" + url + ", count=" + count + "]";
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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Long getStart() {
		return start;
	}

	public void setStart(Long start) {
		this.start = start;
	}

	public Long getCreate() {
		return create;
	}

	public void setCreate(Long create) {
		this.create = create;
	}
	
	public String getStartDay(){
		return DateUtil.MilinsecondsToStringDate(start);
	}
	
	public boolean isStartStatus(){
		Long now = new Date().getTime();
		if(now > start){
			return true;
		}else{
			return false;
		}
	}

	public int getOptionNum() {
		return optionNum;
	}

	public void setOptionNum(int optionNum) {
		this.optionNum = optionNum;
	}

}
