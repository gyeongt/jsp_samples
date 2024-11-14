<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String id = request.getParameter("id");
	
	MemberDao dao = MemberDao.getInstance();
	
	boolean b = dao.getId(id);
	
	if(b == true){	// id가 있음
		out.println("NO");
	}else{	// id가 없음 (사용가능)
		out.println("YES");
	}
	
	



%>