<%@page import="util.CalendarUtil"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sseq = request.getParameter("seq");
	int seq = Integer.parseInt(sseq);
	
	CalendarDao dao = CalendarDao.getInstance();
	CalendarDto dto = dao.getDay(seq);
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>일정관리</h2>

<table border="1" align="center" >
<col width="200"><col width="200">
<tr>
	<th>아이디</th>
	<td><%=dto.getId() %></td>
</tr>

<tr>
	<th>제목</th>
	<td><%=dto.getTitle() %></td>
</tr>

<tr>
	<th>일정</th>
	<td><%=CalendarUtil.toDates(dto.getRdate()) %></td>
</tr>

<tr>
	<th>내용</th>
	<td><textarea rows="20" cols="80"  readonly="readonly" ><%=dto.getContent() %></textarea><td>
</tr>
<tr>
	<td colspan="2" align="center">
	<input type="button" value="글수정" onclick="location.href='calupdate.jsp?seq=<%=dto.getSeq()%>'" >
	<input type="button" value="글삭제" onclick="location.href='caldel.jsp?seq=<%=dto.getSeq()%>'" >
	</td>
</tr>
</table>


</body>
</html>