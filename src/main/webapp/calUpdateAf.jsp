<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalendarUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	int seq = Integer.parseInt(request.getParameter("seq"));
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String hour = request.getParameter("hour");
	String min = request.getParameter("min");
	
	String rdate = year + CalendarUtil.two(month) + CalendarUtil.two(day) + CalendarUtil.two(hour) + CalendarUtil.two(min);
	
	CalendarDao dao = CalendarDao.getInstance();
	
	boolean isS = dao.calUpdate(new CalendarDto(seq, "", title, content, rdate, ""));
	
	if(isS){
		%>
		<script>
		alert("수정완료")
		location.href = "calendarList.jsp";
		</script>
		
		<%
	}else{
		%>
		<script>
		alert("수정실패")
		location.href = "calendarList.jsp";   
		</script>
		<%
	}

%>