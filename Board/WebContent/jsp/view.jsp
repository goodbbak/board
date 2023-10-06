<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="boardSite.BoardSite" %>
<%@ page import="boardSite.BoardSiteDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content= "text/html; charset=UTF-8">
<!-- 어느 기기에서도 맞춤으로 보이는 반응형 웹에 사용되는 기본 Meta Tag -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		int boardID=0;
		if(request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		
		if(boardID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'boardSite.jsp'");
			script.println("</script>");	
		}
		
		BoardSiteDAO boardDAO = new BoardSiteDAO();
		BoardSite board = new BoardSite();
		board = boardDAO.getBoard(boardID);
	%>
	<%@ include file ="layoutNav.jsp" %>
	
	<!-- 게시판 글보이는 부분 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr><th colspan="3" style="backgroud-color:#eeeeee; text-align: center;"> 게시판 글 보기 </th></tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 200px">글 제목</td>
						<td colspan="2">
							<%= board.getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= board.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= board.getBoardDate().substring(0,11) + board.getBoardDate().substring(11,13) + ":" + board.getBoardDate().substring(14,16)%></td>
					</tr>
					<tr>
						<td>글 내용</td>
						<!-- 특수문자/공백 등 입력시 처리하는 과정에서 기본 HTML 코드와 구분이 안되기 때문에 정상적으로 보이도록 문자를 대체함 -->
						<td colspan="2" style="min-height: 200px text-align: left">
							<%= board.getBoardContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
						</td>
					</tr>
				</tbody>
			</table>
			<a href="boardSite.jsp" class="btn btn-primary">목록</a>
			
			<%
				//현재 접속한 사람이 글 작성자라면 수정/삭제 가능하도록 수정 버튼 보이기
				if(userID != null && userID.equals(board.getUserID())) { 
			%>
					<a href="modify.jsp?boardID=<%=boardID%>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?boardID=<%=boardID%>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>