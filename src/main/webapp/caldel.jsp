<%@page import="util.CalendarUtil"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dto.CalendarDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    
	int seq = Integer.parseInt(request.getParameter("seq"));
    

	CalendarDao dao = CalendarDao.getInstance();
	CalendarDto dto = dao.getDay(seq);
	
	String year = dto.getRdate().substring(0, 4);
	String month = CalendarUtil.one(dto.getRdate().substring(4, 6));
	String day = CalendarUtil.one(dto.getRdate().substring(6, 8));
    
    boolean isS = dao.caldelete(seq);
    
    if(isS){
    	%>
    	<script>
    	alert("삭제완료");
    	location.href= "calendarList.jsp";
    	</script>
    	<%
    }else{
    	%>
    	<script>
    	alert("삭제실패");
    	location.href= "calendarList.jsp";
    	</script>
    	<%
    }
    
%>