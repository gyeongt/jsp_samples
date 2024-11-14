package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {

	private static MemberDao dao = null;
	
	public MemberDao() {	//생성자
		DBConnection.initConnection();
	}
	
	public static MemberDao getInstance() {
		if(dao == null) {
			dao = new MemberDao();	// 1번만 실행
		}
		return dao;
	}
	
	public boolean getId(String id) {	//id 중복확인
		String sql = "select count(*)"
				+ "	  from member "
				+ "   where id=?  ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("getId 1/4 success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			
			System.out.println("getId 2/4 success");
			
			rs = psmt.executeQuery();
			System.out.println("getId 3/4 success");
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			System.out.println("getId 4/4 success");
			
		} catch (SQLException e) {
			System.out.println("getId fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return count>0?true:false;
		
		
	}
	
	public boolean addMember(MemberDto dto) {	// 회원가입 db에 회원정보 추가
		String sql = " insert into member(id, pwd, name, email, auth) "
					+" values(?, ?, ?, ? , 3) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
		conn = DBConnection.getConnection();
		System.out.println("addMember 1/3 success");
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, dto.getId());
		psmt.setString(2, dto.getPwd());
		psmt.setString(3, dto.getName());
		psmt.setString(4, dto.getEmail());
		System.out.println("addMember 2/3 success");
		
		count = psmt.executeUpdate();
		System.out.println("addMember 3/3 success");
		
		} catch (SQLException e) {
			System.out.println("addMember fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0;
		
	}
	
	
	  public MemberDto login(String id, String pwd) {	//db데이터와 로그인데이터 비교
		  String sql = "select id, name, email, auth "
		  		+ "		from member "
		  		+ "		where id=? and pwd=? ";
		  
		  Connection conn = null;
		  PreparedStatement psmt= null;
		  ResultSet rs = null;
		  
		  MemberDto dto = null;
		  
		  
		  
		  try {
			conn = DBConnection.getConnection();
			System.out.println("login 1/4 success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("login 2/4 success");
			
			rs = psmt.executeQuery();
			System.out.println("login 3/4 success");
			
			if(rs.next()) {
				String userid = rs.getString("id");
				String name = rs.getString("name");
				String email = rs.getString("email");
				int auth = rs.getInt("auth");
				
				dto = new MemberDto(userid, null, name, email, auth);
			}
			System.out.println("login 4/4 success");
			
		} catch (SQLException e) {
			System.out.println("login fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		  
		  return dto;
		  
		  
	  }
	  
	 
	
	
}
