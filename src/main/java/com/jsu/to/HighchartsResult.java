package com.jsu.to;

import java.util.ArrayList;
import java.util.List;

public class HighchartsResult {
	/**{
            chart: {
                type: 'column'                 //指定图表的类型，默认是折线图（line）
            },
            title: {
                text: '性别分布'                 // 标题
            },
            xAxis: {
                categories: ['吴亦凡', '蔡徐坤', '鹿晗']   // x 轴分类
            },
            yAxis: {
                title: {
                    text: '性别'                // y 轴标题
                }
            },
            series: [{                              // 数据列
                name: '男',                        // 数据列名
                data: [1, 1, 4]                     ,// 数据
				color: '#00FF00'
            }, {
                name: '女',
                data: [5, 7, 3],
				color: 'red'
            }]
        };*/
	private Chart chart ;
	private Title title ;
	
	private XAxis xAxis ;
	private YAxis yAxis ;
	private List<Data> series;
	
	/**
	 * 获取基础柱状图
	 * @param xt X轴标题
	 * @param yt Y轴标题
	 * @return
	 */
	public static HighchartsResult column(String xt,String yt){
		HighchartsResult res = new HighchartsResult();
		res.init();
		res.setTitle(res.new Title(xt));
		res.setyAxis(yt);
		
		return res;
	}
	
	/**
	 * 设置 x 轴分类
	 * @param x x轴分布的数据数组
	 */
	public void setxAxis(String[] x) {
		this.xAxis = new XAxis(x);
	}
	
	
	public void setxAxis(Object...x) {
		int len = x.length;
		String[] xa = new String[len];
		for(int i = 0 ; i< len ; i++){
			xa[i] = (String) x[i];
		}
		setxAxis(xa);
	}
	
	/**
	 * 设置Y轴标题
	 * @param yTitle
	 */
	public void setyAxis(String yTitle){
		this.yAxis = new YAxis(yTitle);
	}
	
	/**
	 * 添加Y轴数据
	 * @param name 数据名
	 * @param data 数据个数数组
	 */
	public void addData(String name,int[] data){
		Data d1 =  new Data();
		d1.setName(name);
		d1.setData(data);
		series.add(d1);
	}
	
	public void addData(String name,String color,int[] data){
		Data d1 =  new Data();
		d1.setName(name);
		d1.setData(data);
		d1.setColor(color);
		series.add(d1);
	}
	
	/**
	 * 添加Y轴可变数据
	 * @param name 数据名
	 * @param data 可变数据个数
	 */
	public void addData(String name,String color,Integer...data){
		int len = data.length;
		int[] d= new int[len];
		for(int i = 0; i <len ; i++){
			d[i] = data[i];
		}
		addData(name,color,d);
	}
	
	
	public List<Data> getSeries() {
		return series;
	}


	public void addData(String name,Integer...data){
		int len = data.length;
		int[] d= new int[len];
		for(int i = 0; i <len ; i++){
			d[i] = data[i];
		}
		addData(name,d);
	}

	
	//初始化
	private void init(){
		chart=new Chart("column");
		title = new Title("标题");
		
		String[] x = {"数据1","数据2"};
		xAxis= new XAxis(x);
		
		yAxis = new YAxis("Y轴名");
		
		this.series= new ArrayList<>();
	}
	
	
	
	
	public Chart getChart() {
		return chart;
	}


	public Title getTitle() {
		return title;
	}

	private void setTitle(Title title) {
		this.title = title;
	}

	public XAxis getxAxis() {
		return xAxis;
	}

	
	public YAxis getyAxis() {
		return yAxis;
	}

	private void setyAxis(YAxis yAxis) {
		this.yAxis = yAxis;
	}



	private class Chart{
		private String type;
		public Chart(String type) {
			this.setType(type);
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
	}
	
	private class Title{
		public Title(String str) {
			setText(str);
		}
		public String getText() {
			return text;
		}
		public void setText(String text) {
			this.text = text;
		}
		private String text;
	}
	private class XAxis{
		private String[] categories;
		private XAxis(String[] cate){
			this.categories =cate;
		}
		public String[] getCategories() {
			return categories;
		}

		public void setCategories(String[] categories) {
			this.categories = categories;
		}
	}
	private class YAxis{
		private Title title;
		
		public YAxis(String t){
			title = new Title(t);
		}

		public Title getTitle() {
			return title;
		}

		public void setTitle(Title title) {
			this.title = title;
		}
	}
	
	 class Data{
		private String name;
		private int[] data;
		private String color;
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int[] getData() {
			return data;
		}
		public void setData(int[] data) {
			this.data = data;
		}
		public String getColor() {
			return color;
		}
		public void setColor(String color) {
			this.color = color;
		}
	}

	public static HighchartsResult getDefault() {
		HighchartsResult res = new HighchartsResult();
		res.init();
		return res;
	}



	
}
