package com.jsu.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SqlExcute {
	private Connection conn;
	private PreparedStatement statement;
	private ResultSet set;
	
	private static int countConn=0;
	private static int countPre=0;
	private static int countRs=0;
	
	
	public SqlExcute(){
		conn=JdbcUtil.getConnection();
		countConn++;
	}
	
	public SqlExcute(Connection conn){
		this.conn = conn;
		countConn++;
	}
	
	
	public void setConn(Connection conn) {
		this.conn = conn;
	}
	
	public static void lookResource(){
		System.out.println("连接数："+ countConn+ " 预处理数："+countPre + "结果集数：" + countRs);
	}

	
    private Object Execute(int type, String sql, Object... param)
			throws Exception {
    	
    	System.out.println(sql);
    	
		int result = 0;

		if (conn != null) {
			try {
				statement = conn.prepareStatement(sql);
				countPre++;
				for (int i = 1; i <= param.length; i++) {
					statement.setObject(i, param[i - 1]);
				}
				if (type == 0) {
					result = statement.executeUpdate();
				} else {
					set = statement.executeQuery();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}else{
			throw new  RuntimeException();
		}
		
		System.out.println("连接数："+ countConn+ " 预处理数："+countPre + "结果集数：" + countRs);
		
		if (type == 0) {
			//System.out.println(result);
			return result == 0 ? false : true;
		} else {
			return set;
		}
	}

	public  ResultSet ExecuteQuery(String sql, Object... param) {
			try {
				set = (ResultSet) Execute(1, sql, param);
				countRs++;
			} catch (Exception e) {
				e.printStackTrace();
			}
		return set;
	}

	public  boolean ExecuteUpdate(String sql, Object... param) {
		boolean r = false;
	
		try {
			r = (Boolean) Execute(0, sql, param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return r;
	}
	
	public void closePreparedStatement(){
		if(statement == null)
			return;
		 try {
	  			statement.close();
	  			countPre--;
	  		} catch (SQLException e) {
	  			e.printStackTrace();
	  			throw new RuntimeException();
	  		}
		 
	}
	
	public void closeResultSet(){
		if(set == null)
			return;
		 try {
	  			set.close();
	  			countRs--;
	  		} catch (SQLException e) {
	  			e.printStackTrace();
	  			throw new RuntimeException();
	  		}
	}
    
	public void closeRSandStatment(){
		 closeResultSet();
         closePreparedStatement();
	}
	
    public void closeResource(){
    	 System.out.println("关闭资源");
    	 
         closeResultSet();
         closePreparedStatement();
         
          try {
  			conn.close();
  			countConn--;
  		} catch (SQLException e) {
  			e.printStackTrace();
  			throw new RuntimeException();
  		}
    }
    
    
	
}
