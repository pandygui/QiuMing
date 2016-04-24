package org.gdpurjyfs.qiuming.util;

import java.sql.DriverManager;
import java.sql.SQLException;  
import java.sql.Connection;  

public final class JDBCTools {

	private static String driveClassName = "com.mysql.jdbc.Driver";  
    private static String url = "jdbc:mysql://localhost:3306/test";   
      
    private static String user = "root";  
    private static String password = "root";  
      
    public static Connection getConnect(){  
        Connection conn = null;  
          
        //load driver  
        try {  
            Class.forName(driveClassName);  
        } catch (ClassNotFoundException  e) {  
            System.out.println("load driver failed!");  
            e.printStackTrace();  
        }  
          
        //connect db  
        try {  
            conn = DriverManager.getConnection(url, user, password);  
        } catch (SQLException e) {  
            System.out.println("connect failed!");  
            e.printStackTrace();  
        }         
          
        return conn;  
    }  
}
