<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="boardSite.BoardSite"%>
<%@ page import="boardSite.BoardSiteDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 어느 기기에서도 맞춤으로 보이는 반응형 웹에 사용되는 기본 Meta Tag -->
<meta name="viewport" content="width-device-width" , initial-scale="1">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>JSP</title>

<!-- 해당 페이지 내 a태그의 색은 검은색, 밑줄을 나오지 않도록 설정 -->
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

.pagination-container {
	display: flex;
	justify-content: center;
}
</style>
</head>
<body>
	<%@ include file="layoutNav.jsp"%>
	<%
		//가장 기본 페이지 1로 설정
		BoardSiteDAO boardDAO = new BoardSiteDAO();
		int showPage = 3; // 한 페이징당 보여주고 싶은 페이지 수
		int pageNumber = 1; //현재의 페이지 번호, 페이지 버튼을 누를 때마다 변경 됨
		int pagingNumber = 1; //현재의 페이징 번호 , 현재 페이지 번호를 보고 결정 됨
		int totalPage = boardDAO.getTotalPage(); //전체 페이지 수
		int totalPaging = (int)Math.ceil((double)totalPage/showPage); //전체 페이징 수
		//페이징 누를 때마다 pageNumber값을 파라미터에서 꺼내서 씀
		if(request.getParameter("pageNumber") != null){
			//정수형으로 타입 변경해주는 부분
			pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
			//현재페이징 = 현재페이지/(한 페이징당 보일 페이지 수)를 반올림
			pagingNumber = (int)Math.ceil((double)pageNumber/showPage);
			
		}
	%>

	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="backgroud-color: #eeeeee; text-align: center;">번호
						</th>
						<th style="backgroud-color: #eeeeee; text-align: center;">제목
						</th>
						<th style="backgroud-color: #eeeeee; text-align: center;">
							작성자</th>
						<th style="backgroud-color: #eeeeee; text-align: center;">
							작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						ArrayList<BoardSite> list = boardDAO.getList(pageNumber);
												for(int i = 0; i<list.size(); i++){
					%>
					<tr>
						<td><%=list.get(i).getBoardID()%></td>
						<td><a href="view.jsp?boardID=<%=list.get(i).getBoardID()%>"><%=list.get(i).getBoardTitle()%></a></td>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getBoardDate().substring(0,11) + list.get(i).getBoardDate().substring(11,13) + ":" + list.get(i).getBoardDate().substring(14,16)%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<!-- 페이지네이션  -->
			<div class="pagination-container">
				<nav aria-label="Page navigation example" class="">
					<ul class="pagination">
						<%
							if(pagingNumber != 1){ //첫 페이징이 아닌 경우에만 <<버튼 생성, 이전 버튼 클릭 시 현재 페이지번호를 이전 페이징에서 가장 큰 페이지 번호로 바꿈
						%>
								<li class="page-item"><a class="page-link"
									href="boardSite.jsp?pageNumber=<%=showPage*(pagingNumber-1)%>"
									aria-label="Previous"><span aria-hidden="true">&laquo;</span>
								</a></li>
						<%
							}
						%>
						<%//페이지 버튼 그리는 영역
							if(pagingNumber == totalPaging){//마지막페이징인 경우
								for(int i=showPage*pagingNumber-(showPage-1);i<=totalPage;i++){ //마지막페이징의 첫번째 페이지부터 총 페이지 수까지  반복문
									if(pageNumber == i){ //현재 페이지(pageNumber)에 있는 경우 active클래스 줘서 표시
						%>
										<li class="page-item active"><a class="page-link"
										href="boardSite.jsp?pageNumber=<%=i%>"><%=i%></a></li>
						<%
									}else { // none active
						%>
										<li class="page-item"><a class="page-link"
										href="boardSite.jsp?pageNumber=<%=i%>"><%=i%></a></li>
						<%
									}
						%>
						<%
								}
							} else {//마지막 페이징 외에 페이징들은 현재페이징의 가장 작은 페이지부터 보여줄페이지 수만큼 반복문 돌려서 만듦
							  	for(int i=showPage*pagingNumber-(showPage-1);i<=showPage*pagingNumber;i++){//ex)2페이징에 경우 4~6까지 페이지 버튼을 만듦
						%>
						<%
									if(pageNumber == i){ //현재 페이지(pageNumber)에 있는 경우 active클래스 줘서 표시
						%>
										<li class="page-item active"><a class="page-link"
											href="boardSite.jsp?pageNumber=<%=i%>"><%=i%></a></li>
						<%
									}else {
						%>
										<li class="page-item"><a class="page-link"
											href="boardSite.jsp?pageNumber=<%=i%>"><%=i%></a></li>
						<%
									}
						%>
						<%
								} 
							}
						%>
						<%
							if(pagingNumber < totalPaging){ //현재 페이징이 전체 페이징 수 보다 작은 경우에만 >>버튼 만듦
						%>
						<li class="page-item"><a class="page-link"
							href="boardSite.jsp?pageNumber=<%=showPage*(pagingNumber+1)-(showPage-1)%>"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
						<!-- >>버튼 클릭시 현재 페이지 번호를 다음 페이징 첫 번째 페이지 번호로 바꿈  -->
						<%
							}
						%>
					</ul>
				</nav>
			</div>
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