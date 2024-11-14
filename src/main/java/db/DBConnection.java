package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	public static void initConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	//class driver 주소
			System.out.println("Driver Loading Success");
		} catch (ClassNotFoundException e) {
			System.out.println("jdbc.Driver 가 없습니다.");
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() {
			
		Connection conn = null;
			
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "1234");
			System.out.println("MySQL connection Success");
				
		} catch (SQLException e) {
			System.out.println("Database와 연결이 되지 않았습니다.");
			e.printStackTrace();
		}
		return conn;
	}
}
