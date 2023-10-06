<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="USER.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="USER" class="USER.User" scope="page"/>
<jsp:setProperty name="USER" property="userID"/>
<jsp:setProperty name="USER" property="userPW"/>
<jsp:setProperty name="USER" property="userName"/>
<jsp:setProperty name="USER" property="userGender"/>
<jsp:setProperty name="USER" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content= "text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		UserDAO userDao = new UserDAO();
		int result = userDao.join(USER.getUserID(), USER.getUserPW(), USER.getUserName(), USER.getUserGender(), USER.getUserEmail()); 
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
				
		} else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 이메일입니다.')");
			script.println("history.back()");
			script.println("</script>");	
		} else if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입 완료!')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");	
		} 
	%>
</body>
</html>