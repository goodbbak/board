<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="boardSite.BoardSite" %>
<%@ page import="boardSite.BoardSiteDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content= "text/html; charset=UTF-8">
<!-- 어느 기기에서도 맞춤으로 보이는 반응형 웹에 사용되는 기본 Meta Tag -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>JSP</title>

<!-- 해당 페이지 내 a태그의 색은 검은색, 밑줄을 나오지 않도록 설정 -->
<style type="text/css">
	a, a:hover {
		color : #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
		//가장 기본 페이지 1로 설정
		int pageNumber = 1;
		
		if(request.getParameter("pageNumber") != null){
			//정수형으로 타입 변경해주는 부분
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<%@ include file ="layoutNav.jsp" %>
	
	
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th style="backgroud-color:#eeeeee; text-align: center;"> 번호 </th>
						<th style="backgroud-color:#eeeeee; text-align: center;"> 제목 </th>
						<th style="backgroud-color:#eeeeee; text-align: center;"> 작성자 </th>
						<th style="backgroud-color:#eeeeee; text-align: center;"> 작성일 </th>
					</tr>
				</thead>
				<tbody>
					<%
						BoardSiteDAO boardDAO = new BoardSiteDAO();
						ArrayList<BoardSite> list = boardDAO.getList(pageNumber);
						
						for(int i = 0; i<list.size(); i++){
					%>
						<tr>
						<td><%= list.get(i).getBoardID() %></td>
						<td><a href="view.jsp?boardID=<%=list.get(i).getBoardID()%>"><%=list.get(i).getBoardTitle()%></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBoardDate().substring(0,11) + list.get(i).getBoardDate().substring(11,13) + ":" + list.get(i).getBoardDate().substring(14,16)%></td>
					</tr>
					<%
						}	
					%>					
				</tbody>
			</table>
			
			<%
				//페이지 넘버 보여주는 부분
				if(pageNumber != 1){
			%>
				<a href="boardSite.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%	
				} if (boardDAO.nextPage(pageNumber + 1)) {
			%>
					<a href="boardSite.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-right">다음</a>
			<%
				}
			%>
			<%
				if(userID != null){
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글 작성하기</a>
			<%
			}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>