<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="USER.UserDAO" %>
<%@ page import="USER.User" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- <jsp:useBean id="USER" class="USER.User" scope="page"/> --%> <!--밑에서 직접 객체 만들어도 됨 33행-->
<%-- <jsp:setProperty name="USER" property="userID"/> --%> 
<!-- 위에서 User객체를 담은 USER의 property="userID"라는 변수에 login.jsp에서 form으로 보낸 name="userID" 값을 자동으로 담음 34행처럼 직접 받아도 됨 -->
<%-- <jsp:setProperty name="USER" property="userPW"/> --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content= "text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		//로그인이 되어있으면, 로그인 창에 접근을 못하게 하기 위해 세션 확인을 해주는 부분
		String userID = null;
		if(session.getAttribute("userID") != null){	//로그인 혹은 회원가입을 통해 이미 세션이 있는 상태라면,
			userID = (String) session.getAttribute("userID"); // userID 세팅
		}
		
		if(userID != null){	//userID가 null이 아니라는 것은 이미 로그인 한 것!
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어있는 사용자 입니다.' + userID + ')'");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");	
		}
		
		User USER = new User();
		USER.setUserID(request.getParameter("userID")); /*form에서 보낸 값 request.getParameter로 받음  */
		USER.setUserPW(request.getParameter("userPW"));
		
		UserDAO userDao = new UserDAO();
		int result = userDao.login(USER.getUserID(), USER.getUserPW()); 
		
		if(result == 1){
			session.setAttribute("userID", USER.getUserID());	//USER의 ID를 세션값으로 설정해준다.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");	
		} else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");	
		} else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
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