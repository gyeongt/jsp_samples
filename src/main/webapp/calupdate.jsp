<%@page import="java.util.Calendar"%>
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
	
	Calendar cal = Calendar.getInstance();
	int tyear = cal.get(Calendar.YEAR);
	
	String year = dto.getRdate().substring(0, 4);
	String month = CalendarUtil.one(dto.getRdate().substring(4, 6));
	String day = CalendarUtil.one(dto.getRdate().substring(6, 8));
	String hour = CalendarUtil.one(dto.getRdate().substring(8, 10));
	String min = CalendarUtil.one(dto.getRdate().substring(10, 12));
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
<form action="calUpdateAf.jsp">
<table border="1" align="center" >
<col width="200"><col width="200">
<tr>
	<th>아이디</th>
	<td><input type="hidden" name="seq" value="<%=dto.getSeq() %>" ></td>
	<td><input type="text" name="id" value="<%=dto.getId() %>" readonly="readonly"></td>
</tr>

<tr>
	<th>제목</th>
	<select name="year">
	<td>
		<input type="text" name="title" value="<%=dto.getTitle() %>" >	
	</td>
</tr>

<tr>
	<th>일정</th>
	<td>
		<select name="year">
			<%
			for(int i = tyear - 5; i < tyear + 6; i++){
				%>
				<option <%=year.equals(i + "")?"selected='selected'":"" %>
						value="<%=i %>"><%=i %></option>
				<% 
			}		
			%>
		</select>년
		
		<select name="month">
			<%
			for(int i = 1; i <= 12; i++){
				%>
				<option <%=month.equals(i + "")?"selected='selected'":"" %>
						value="<%=i %>"><%=i %></option>
				<% 
			}		
			%>
		</select>월
		
		<select name="day">
			<%
			for(int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
				%>
				<option <%=day.equals(i + "")?"selected='selected'":"" %>
						value="<%=i %>"><%=i %></option>
				<% 
			}		
			%>
		</select>일
		
		<select name="hour">
			<%
			for(int i = 1; i <= 24; i++){
				%>
				<option <%=hour.equals(i + "")?"selected='selected'":"" %>
						value="<%=i %>"><%=i %></option>
				<% 
			}		
			%>
		</select>시
		
		<select name="min">
			<%
			for(int i = 1; i <= 60; i++){
				%>
				<option <%=min.equals(i + "")?"selected='selected'":"" %>
						value="<%=i %>"><%=i %></option>
				<% 
			}		
			%>
		</select>분

	</td>
</tr>

<tr>
	<th>내용</th>
	<td><textarea rows="20" cols="80"  name="content"><%=dto.getContent() %></textarea><td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="수정" >
		<input type="button" value="취소" onclick="cancel()">
	</td>
</tr>
</table>
</form>
</div>
<script type="text/javascript">
function cancel(){
	location.href = "calendarList.jsp";
}
</script>

</body>
</html>