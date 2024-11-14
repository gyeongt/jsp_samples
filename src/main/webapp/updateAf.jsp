<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    	request.setCharacterEncoding("utf-8");
		
    	int seq = Integer.parseInt(request.getParameter("seq"));
		
		String title = request.getParameter("title");
 		String content = request.getParameter("content");
 		
 		BbsDao dao = BbsDao.getInstance();
 		
 		boolean isS = dao.bbsUpdat(seq, title, content);
 		
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
 			location.href = "bbsUpdate.jsp?seq=" + <%=seq %>;
 			</script>
 			<%
 		}
    %>