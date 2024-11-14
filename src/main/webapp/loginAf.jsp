<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

MemberDao dao = MemberDao.getInstance();

MemberDto dto = dao.login(id, pwd);

if(dto != null){	// login 성공
	
	// login 회원정보 저장
	
	session.setAttribute("login", dto);
	// session.setMaxInactiveInterval(60 * 60 * 2); 세션만료시간 설정하기 
	
	%>
	<script>
	alert("환영합니다<%=dto.getName()%>님");
	location.href = "bbslist.jsp";
	</script>
	<%
}else{
	%>
	<script>
	alert("아이디나 패스워드를 확인하십시오");
	location.href = "login.jsp";
	</script>
	
	<%
}

%>