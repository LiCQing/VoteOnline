package com.jsu.to;

public class CheckResult {
	private boolean result;
	private String data;
	
	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}



	public static CheckResult T(String data){
		CheckResult re = new CheckResult();
		re.setResult(true);
		re.setData(data);
		return re;
	}
	
	public static CheckResult F(String data){
		CheckResult re = new CheckResult();
		re.setResult(false);
		re.setData(data);
		return re;
	}

}
