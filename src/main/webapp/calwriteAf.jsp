<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// rdate = 202307071144
	// data = 2023-07-05
	// time = 11:44
	
	// split, replace
	String date = request.getParameter("date");
	String time = request.getParameter("time");
	
//    System.out.println(date);
///	System.out.println(time);
	
	date = date.replace("-", "");
	time = time.replace(":", "");
	
//	 System.out.println(date);
//	 System.out.println(time);

	String rdate = date + time;	// 202307141149
	
	CalendarDao dao = CalendarDao.getInstance();
	boolean isS = dao.addCalendar(new CalendarDto(id, title, content, rdate));
	if(isS){
		%>
		<script>
		alert('일정이 추가되었습니다');
		location.href = "calendarList.jsp";
		</script>
		<%
	}else{	
		%>
		<script>
		alert('추가되지 않았습니다');
		location.href = "calendarList.jsp";
		</script>
		<%
	}
    
%>