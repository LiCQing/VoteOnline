package com.jsu.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SqlExcute {
	private Connection conn;
	private PreparedStatement statement;
	private ResultSet set;
	
	public SqlExcute(){
		
	}
	
	public SqlExcute(Connection conn){
		this.conn = conn;
	}
	
	
	public void setConn(Connection conn) {
		this.conn = conn;
	}


	
    private Object Execute(int type, String sql, Object... param)
			throws Exception {
    	
    //	System.out.println(sql);
    	
		int result = 0;

		if (conn != null) {
			try {
				statement = conn.prepareStatement(sql);
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
		
		if (type == 0) {
			//System.out.println(result);
			return result == 0 ? false : true;
		} else {
			return set;
		}

	}

	public  ResultSet ExecuteQuery(String sql, Object... param) {
		ResultSet set = null;
			try {
				set = (ResultSet) Execute(1, sql, param);
			} catch (Exception e) {
				// TODO Auto-generated catch block
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
    	
         closeResultSet();
         closePreparedStatement();
         
          try {
  			conn.close();
  		} catch (SQLException e) {
  			e.printStackTrace();
  			throw new RuntimeException();
  		}
    }
	
}
