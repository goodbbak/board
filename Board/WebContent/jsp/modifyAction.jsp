<%@page import="boardSite.BoardSite"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardSite.BoardSiteDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content= "text/html; charset=UTF-8">
<title>수정</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){	
			userID = (String) session.getAttribute("userID");
		}
		
		//로그인 안 한 사용자 체크하는 부분
		if(userID == null){	
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 이후 이용가능한 서비스 입니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");	
		}
		
		int boardID=0;
		if(request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		
		//유효한 글인지 체크하는 부분
		if(boardID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'boardSite.jsp'");
			script.println("</script>");	
		}		
		
		BoardSite board = new BoardSiteDAO().getBoard(boardID);
		
		//작성자와 로그인한 사용자가 같은 사용자인지 확인하는 부분
		if(!userID.equals(board.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정가능한 권한이 없습니다.')");
			script.println("location.href = 'boardSite.jsp'");
			script.println("</script>");	
		}
		else {
			if(request.getParameter("boardTitle") == null || request.getParameter("boardContent") == null 
					|| request.getParameter("boardTitle").equals("") || request.getParameter("boardContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('모든 칸을 입력해주십시오.')");
				script.println("history.back()");
				script.println("</script>");	
			}
			else {
				//실제 Data 수정을 위해 수정 함수를 호출하는 부분
				BoardSiteDAO boardrDao = new BoardSiteDAO();
				int result = boardrDao.modify(boardID, request.getParameter("boardTitle"), request.getParameter("boardContent")); 
				
				if(result >= 0){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'boardSite.jsp'");
					script.println("</script>");	
				} else if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");	
				}
			}
		}

	%>
</body>
</html>