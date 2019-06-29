package com.jsu.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
public class JdbcUtil {
 
    public static String DRIVERNAME = "com.mysql.jdbc.Driver";
    public static String URL = "jdbc:mysql://localhost:3306/vote";
    public static String USER = "root";
    public static String PASSWORD = "123456";
 
 
    public static Connection getConnection()  {
    	Connection  conn = null;
    	try {
			Class.forName(DRIVERNAME);
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return conn;
    }
    
    public static void closeConn(Connection conn){
    	if(conn != null){
    		try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    }
 
}
