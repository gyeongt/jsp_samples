<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
   	 request.setCharacterEncoding("utf-8");
    
    int seq = Integer.parseInt(request.getParameter("seq"));
    
    BbsDao dao = BbsDao.getInstance();
    
    
    boolean isS = dao.bbsdelete(seq);
    if(isS){
    	%>
    	<script>
    	location.href = "bbslist.jsp";
    	</script>
    	<% 
    }
    else{
    	%>
    	<script>
    	location.href = "bbslist.jsp";
    	</script>
    	<%
    }
%>
    
    