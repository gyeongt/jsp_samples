package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CalendarDto;

public class CalendarDao {

	private static CalendarDao dao = null;
	
	private CalendarDao() {
	}
	
	public static CalendarDao getInstance() {
		if(dao == null) {
			dao = new CalendarDao();
		}
		return dao;
	}
	
	public List<CalendarDto> getCalendarList(String id, String yyyyMM){
		String sql = " select seq, id, title, content, rdate, wdate "
				+ " from "
				+ "	(select row_number()over(partition by substr(rdate, 1, 8) order by rdate asc) as rnum,"
				+ "	seq, id, title, content, rdate, wdate "
				+ "	from calendar "
				+ "	where id=? and substr(rdate, 1, 6)=?) a "
				+ " where rnum between 1 and 5 ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs= null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("getCalendarList 1/4 success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyyMM);
			System.out.println("getCalendarList 2/4 success");
			rs = psmt.executeQuery();
			System.out.println("getCalendarList 3/4 success");
			while(rs.next()) {
				CalendarDto dto = new CalendarDto(	rs.getInt(1),
													rs.getString(2),
													rs.getString(3),
													rs.getString(4),
													rs.getString(5),
													rs.getString(6) );
				list.add(dto);
			}
			System.out.println("getCalendarList 4/4 success");
		} catch (SQLException e) {
			System.out.println("getCalendarList fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	public boolean addCalendar(CalendarDto dto) {
			
			String sql = " 	insert into calendar(id, title, content, rdate, wdate) "
					+ "		values(?, ?, ?, ?, now()) ";
			
			Connection conn = null;
			PreparedStatement psmt = null;		
			int count = 0;
					
			try {
				conn = DBConnection.getConnection();
				System.out.println("addCalendar 1/3 success");
				
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getTitle());
				psmt.setString(3, dto.getContent());
				psmt.setString(4, dto.getRdate());
				System.out.println("addCalendar 2/3 success");
				
				count = psmt.executeUpdate();	
				System.out.println("addCalendar 3/3 success");
				
			} catch (SQLException e) {		
				System.out.println("addCalendar fail");
				e.printStackTrace();
			} finally {
				DBClose.close(psmt, conn, null);
			}
			
			return count>0?true:false;
		}
	
	public CalendarDto getDay(int seq) {
		String sql = "select seq, id, title, content, rdate, wdate "
				+ "		from calendar "
				+ "		where seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		CalendarDto dto = null;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("dayget 1/4 success");
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1, seq);
			System.out.println("dayget 2/4 success");
			
			rs = psmt.executeQuery();
			System.out.println("dayget 3/4 success");
			while(rs.next()) {
				dto = new CalendarDto(		
										rs.getInt(1),
										rs.getString(2),
										rs.getString(3),
										rs.getString(4),
										rs.getString(5),
										rs.getString(6));
										
			}
			System.out.println("dayget 4/4 success");
			
		} catch (SQLException e) {
			System.out.println("dayget fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	public List<CalendarDto> getDayList(String id, String yyyymmdd){
		String sql = " select seq, id, title, content, rdate, wdate 	"
				+ "		from calendar "
				+ "		where id=? and substr(rdate, 1, 8)=?"
				+ "		order by rdate asc ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("getDayList 1/4 success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yyyymmdd.trim());
			System.out.println("getDayList 2/4 success");
			rs=psmt.executeQuery();
			System.out.println("getDayList 3/4 success");
			while(rs.next()) {
				int i = 1;
				CalendarDto dto = new CalendarDto(
													rs.getInt(1),
													rs.getString(2),
													rs.getString(3),
													rs.getString(4),
													rs.getString(5),
													rs.getString(6));
				
				list.add(dto);
			}
			System.out.println("getDayList 4/4 success");
		} catch (SQLException e) {
			System.out.println("getDayList fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;
	}
	
	public boolean calUpdate(CalendarDto dto) {
		
		String sql = " update calendar "
				+ "		set title=?, content=?, rdate=?, wdate=sysdate() "
				+ "		  "
				+ "		where seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt= null;
		
		int count = 0;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("calUpdate 1/3 success");
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getRdate());
			psmt.setInt(4, dto.getSeq());
			
			System.out.println("calUpdate 2/3 success");
			
			count = psmt.executeUpdate();
			System.out.println("calUpdate 3/3 success");
			
		} catch (SQLException e) {
			System.out.println("calUpdate fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
		
		
	}
	
	public boolean caldelete(int seq) {
		String sql = " delete  from calendar "
				+ "		where seq=? ";
				
		Connection conn = null;
		PreparedStatement psmt= null;
		
		int count = 0;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("caldelete 1/3 success");
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1, seq);
			System.out.println("caldelete 2/3 success");
			count = psmt.executeUpdate();
			System.out.println("caldelete 3/3 success");
		} catch (SQLException e) {
			System.out.println("caldelete fail");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		return count>0?true:false;
	}
	
}
