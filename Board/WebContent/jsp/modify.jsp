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
	<%@ include file ="layoutNav.jsp" %>
	<%
		//로그인한 사용자들이라면, userID에 값이 담기게될 것!
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");	
		}
		
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
		
		if(!userID.equals(board.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정가능한 권한이 없습니다.')");
			script.println("location.href = 'boardSite.jsp'");
			script.println("</script>");	
		}
	%>
	
	
	<!-- 게시판 글쓰기 양식 부분 -->
	<div class="container">
		<div class="row">
			<form method="post" action="modifyAction.jsp?boardID=<%=board.getBoardID()%>">
				<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
					<thead>
						<tr><th colspan="2" style="backgroud-color:#eeeeee; text-align: center;"> 게시판 글 수정 양식 </th></tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" name="boardTitle" maxlength="50" value="<%=board.getBoardTitle()%>"></input></td>
						</tr>
						<tr>
							<td><textarea class="form-control" name="boardContent" maxlength="3000" style="height: 350px;"><%=board.getBoardContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="수정하기"></input>
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>