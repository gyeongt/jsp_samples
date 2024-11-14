<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@page import="util.CalendarUtil"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dto.CalendarDto"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	MemberDto login = (MemberDto)session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style type="text/css">
body{
	margin-bottom: 20px;
	margin-top: 20px;
}
</style>
</head>
<body>


<%
	Calendar cal = Calendar.getInstance();
	cal.set(Calendar.DATE, 1); // 현재 월의 1일로 맞춰준다.
	
	String syear = request.getParameter("year");
	String smonth = request.getParameter("month");
	
	// 현재 연도를 구한다. -> 처음 이 페이지가 실행시에 적용
	int year = cal.get(Calendar.YEAR);
	if(CalendarUtil.nvl(syear) == false){	// 넘어온 파라미터(syear) 값이 있다
		year = Integer.parseInt(syear);
	}
	
	int month = cal.get(Calendar.MONTH)+1; // 0 ~ 11 까지 이므로 +1
	if(CalendarUtil.nvl(smonth) == false){
		month = Integer.parseInt(smonth);
	}
	
	if(month < 1){
		month = 12;
		year--;
	}
	if(month> 12){
		month = 1;
		year++;
	}
	
	cal.set(year, month-1, 1);
	
	//요일
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	
	//<<	year --
	String pp = String.format("<a href= 'calendarList.jsp?year=%d&month=%d' style='text-decoration:none'>"
							+	"<img src='./images/left.png' width='20px' height= '20px' >"
							+	"</a>",
									year-1, month);
	// < 	month --
	String p = String.format("<a href= 'calendarList.jsp?year=%d&month=%d' style='text-decoration:none'>"
							+	"<img src='./images/prev.png' width='20px' height= '20px' >"
							+	"</a>",
									year, month-1);
	// >	month ++
	String n = String.format("<a href= 'calendarList.jsp?year=%d&month=%d' style='text-decoration:none'>"
							+	"<img src='./images/next.png' width='20px' height= '20px' >"
							+	"</a>",
									year, month+1);
	// >> 	year ++
	String nn = String.format("<a href= 'calendarList.jsp?year=%d&month=%d' style='text-decoration:none'>"
			+	"<img src='./images/last.png' width='20px' height= '20px' >"
			+	"</a>",
					year+1, month);
	
	CalendarDao dao = CalendarDao.getInstance();
	List<CalendarDto> list = dao.getCalendarList(login.getId(), year + CalendarUtil.two(month + ""));
	
%>

<div align="center">
<table border="1">
<col width="120"><col width="120"><col width="120"><col width="120">
<col width="120"><col width="120"><col width="120">

<tr height="80" style="background-color: #546E7A">
	<td colspan="7" align="center">
		<%=pp %>&nbsp;<%=p %>&nbsp;&nbsp;&nbsp;&nbsp;
		
		<font style="color:#ffffff; font-size: 40px; font-family: fantasy">
			<%=String.format("%d년&nbsp;%2d월", year, month) %>
		</font>
		
		&nbsp;&nbsp;&nbsp;&nbsp;<%=n %>&nbsp;<%=nn %>
	</td>
</tr>
<tr height="30" style="background-color:#ffffff; color:#546E7A;text-align: center;">
	<th>sun</th>
	<th>mon</th>
	<th>tus</th>
	<th>wed</th>
	<th>thu</th>
	<th>fri</th>
	<th>sat</th>
</tr>

<tr height="100" align="left" valign="top">
<%
// 윗쪽빈칸
for(int i = 1; i < dayOfWeek; i++){
	%>
	<td style="background-color: #eeeeee">&nbsp;</td>
	<% 
}
// 날짜
int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH); 
for(int i = 1;i <= lastday; i++){
	%>
	<td style="color: #3c3c3c;padding-top: 5px">
		<%=CalendarUtil.daylist(year, month, i) %>&nbsp;&nbsp;<%=CalendarUtil.calwrite(year, month, i) %>
		<%=CalendarUtil.makeTable(year, month, i, list) %>
	</td>	
	<%
	if((i + dayOfWeek - 1) % 7 == 0 && i != lastday){
		%>
		</tr><tr height="120" align="left" valign="top">	
		<%
	}	
}

// 아래쪽 빈칸
cal.set(Calendar.DATE, lastday);
int weekday = cal.get(Calendar.DAY_OF_WEEK);
for(int i = 0; i < 7 - weekday; i++){
	%>
	<td style="background-color: #eeeeee">&nbsp;</td>
	<% 
}
%>
</tr>
</table>

</div>
</body>
</html>