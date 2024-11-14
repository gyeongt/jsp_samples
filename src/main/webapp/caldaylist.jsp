<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalendarUtil"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	
	String yyyymmdd = year + CalendarUtil.two(month + "") + CalendarUtil.two(day + "");
	
	/* MemberDto login = (MemberDto)session.getAttribute("login"); */
	 String id = ((MemberDto)session.getAttribute("login")).getId(); 
	CalendarDao dao = CalendarDao.getInstance();
	List<CalendarDto> list = dao.getDayList(id, yyyymmdd);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일별일정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<h2>일별일정</h2>
<br>
<h3><%=year %>년<%=month %>월 <%=day %>일의 일정</h3>
<br>

<div align="center">

<table border="1">
<col width="100"><col width="450"><col width="300">
<tr>
	<th>번호</th><th>제목</th><th>시간</th>
</tr>
<%
for(int i = 0; i < list.size(); i++){
	CalendarDto dto = list.get(i);
	%>
	<tr>
		<th><%=(i + 1) %></th>
		<td>
			<a href="caldetail.jsp?seq=<%=dto.getSeq() %>">
				<%=dto.getTitle() %>
			</a>
		</td>
		<td><%=CalendarUtil.toDates(dto.getRdate()) %></td>
	</tr>
	<% 
}

%>

</table>
<br>

<a href="calendarList.jsp">일정목록</a>

</div>

</body>
</html>