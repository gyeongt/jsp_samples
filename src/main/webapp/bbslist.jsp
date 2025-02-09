<%@page import="util.BbsUtil"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <%
  	// 검색
  	String choice = request.getParameter("choice");
  	String search = request.getParameter("search");
  	
  	if(choice == null){
  		choice = "";
  	}
  	if(search == null){
  		search = "";
  	}
  	
  	//(현재)페이지 넘버
  	String sPageNumber = request.getParameter("pageNumber");
  	int pageNumber = 0;
  	if(sPageNumber != null && !sPageNumber.equals("")){
  		pageNumber = Integer.parseInt(sPageNumber);
  	}
  	
  	BbsDao dao = BbsDao.getInstance();
  
  	//List<BbsDto> list = dao.getBbsSearchList(choice, search);
  	List<BbsDto> list = dao.getBbsPageList(choice, search, pageNumber);
  	
  	//글의 총수
  	int count = dao.getAllBbs(choice, search);
  	// 페이지를 계산
  	int pageBbs = count / 10;	// 10개씩 1페이지 26-> 3페이지
  	
  	if((count % 10) > 0){
  		pageBbs = pageBbs + 1;	// -> 3페이지
  	}
  	
  
  
  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<style type="text/css">

h1{
	margin: auto;
	text-align: center;
	margin-top: 30px;
	width: 600px;
}


.tab{
	
}

.menu{

	background-color: #f1dcff;
	text-decoration: none;
	font-size: 18px;
	
}
.edi{
	background-color: #f0f8ff;
	text-decoration: none;
}
a:hover{
	text-decoration: none;
}

a:link{
	color: black;
}

a:visited{
	color: #fffff;
}

.rdglas{
	size: 20px;
}


</style>
</head>
<body>



<!--      번호		제복		조회수		작성자 -->
<h1 id="mainTitle">게시판</h1>
<br>
<a href="calendarList.jsp">일정관리</a>

<div class="m-5">
<div class="m-5">
<div class="m-5">
<div class="m-5">
<div class="ml-5, mr-5"  align="right">

<select id="choice" style="height: 35px;">
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="writer">작성자</option>
</select>
<input type="text" value="<%=search %>"  id="search" style="height: 35px;" >
<button type="button"  onclick="searchBtn()" style="width:45px; height:45px;border: none;background-color: #ffffff;">
	<svg xmlns="http://www.w3.org/2000/svg" height="31px" viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352a144 144 0 1 0 0-288 144 144 0 1 0 0 288z"/></svg>
</button>
&nbsp;
<a href="bbswrite.jsp" class="btn btn-success" style="height: 38px;margin-bottom: 4px;" >글쓰기</a>
</div>

<div align = "center"  class="ml-5, mr-5, m-3" >

<table class="table table-hover" >
<col width="70"><col width="600"><col width="100"><col width="150">
<thead>
<tr	class="menu" >
	<th>번호</th><th>제목</th><th>조회수</th><th>작성자</th>
</tr>

</thead>

<tbody class="edi">
<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="4">작성된 글이 없습니다</td>
	</tr>
	<% 
}else{
	
	for(int i = 0; i < list.size(); i++){
		BbsDto bbs = list.get(i);
		%>
		<tr>
			<td><%=i + 1 %></td>
			
			<%
				if(bbs.getDel() == 0){
					%>
			<td>
				<a href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>">
					<%=BbsUtil.arrow(bbs.getDepth()) %>
					<%=BbsUtil.titleDot(bbs.getTitle()) %>
				</a>
			</td>
			<% 
			}else{
				
			
			%>
				<td>
					<%=BbsUtil.arrow(bbs.getDepth()) %>
					<font color="#ff0000">*** 이 글은 작성자에 의해서 삭제되었습니다 ***</font>
				</td>
			
			<% 
			}
			%>
			<td><%=bbs.getReadcount() %></td>
			<td><%=bbs.getId() %></td>
		</tr>
		<%
	}
}
%>

</tbody>

</table>
<br>
<!-- 페이지 구현 -->
<%
	for(int i = 0; i < pageBbs; i++){
		if(pageNumber == i){	// 현재 페이지
			%>
			<span style="font-size: 15pt; color:blue;font-weight: bold;">
				<%=i + 1 %>
			</span>
			<% 
		}else{	//그밖에 페이지
			%>
			<a href="#none" title="<%=i+i %>페이지" onclick="goPage(<%=i %>)"
				style="font-size: 15pt; color:black; font-weight: bold;">
				[<%=i + 1 %>]	
			</a>
			<%                                  
		}
	}

%>

</div>
</div>
</div>
</div>
</div>

<script type="text/javascript">
// JavaScript <- Java
let search = "<%=search %>";	//문자일 경우

if(search != ""){
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAtrribute("selected", "selected");
}




// 검색기능 구현
function searchBtn() {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	/*
	if(choice.trim() == ""){
		alert("카테고리를 선택해 주십시오");
		return;
	}
	if(search.trim() == ""){
		alert("검색어를 입력해 주십시오");
		return;
	}
	*/
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search;
	
	
	
}

function goPage(pageNum){
	let choice = $("#choice").val();
	let search = $("#search").val();
	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}

// 로고 누르면 리스트로 보내기
$("#mainTitle").click(function(){
	location.href = "bbslist.jsp";
});

</script>

</body>
</html>