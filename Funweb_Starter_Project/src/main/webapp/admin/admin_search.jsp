<%@page import="test_master.Master_news_DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="test_master.Master_news_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String nickname = (String)session.getAttribute("sNickname");

//검색타입과 검색어 가져와서 변수에 저장
String search = request.getParameter("search");
String searchType = request.getParameter("searchType");

// ------------------------------------ 페이징 처리 --------------------------------------
int pageNum = 1; // 현재 페이지 번호를 저장할 변수 선언. 기본값 1 설정

// 현재 페이지 번호가 저장된 page 파라미터에서 값을 가져와서 pageNum 변수에 저장
// => 단, page 파라미터가 존재할 경우에만 가져오기
if(request.getParameter("page") != null) {
	pageNum = Integer.parseInt(request.getParameter("page")); // String -> int 형변환 필요
}

int listLimit = 10; // 한 페이지 당 표시할 목록(게시물) 갯수
int pageLimit = 5; // 한 페이지 당 표시할 페이지 갯수


// ----------------------------------------------------------------------------------------
// BoardDAO 객체의 selectSearchListCount() 메서드를 호출하여 
// 검색어에 해당하는 게시물 전체 목록 갯수 조회 작업 요청
// => 파라미터 : 검색어(search), 리턴타입 : int(listCount)
Master_news_DAO news_DAO = new Master_news_DAO();
int newsListCount = news_DAO.selectSearchListCount(search, searchType);

// 페이징 처리를 위한 계산 작업
int maxPage = (int)Math.ceil((double)newsListCount / listLimit);
int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;
int endPage = startPage + pageLimit - 1;
if(endPage > maxPage) {
	endPage = maxPage;
}

// BoardDAO 객체의 selectSearchBoardList() 메서드를 호출하여 
// 검색어에 해당하는 게시물 목록 조회 작업 요청
// => 파라미터 : 현재 페이지 번호(pageNum), 표시할 목록 갯수(listLimit), 검색어(search)
// 리턴타입 : java.util.ArrayList<BoardBean>(boardList)
ArrayList<Master_news_DTO> newsList = news_DAO.selectSearchNewsList(pageNum, listLimit, search, searchType);

%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin/admin_search.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="admin.jsp">Public News List</a></li>
				<li><a href="admin_client.jsp">Client</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Public News Content</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<%
				for(Master_news_DTO news_DTO : newsList) {
				%>
					<tr onclick="location.href='admin_content.jsp?num=<%=news_DTO.getNum() %>&page=<%=pageNum %>'">
						<td><%=news_DTO.getNum() %></td>
						<td class="left"><%=news_DTO.getSubject() %></td>
						<td><%=news_DTO.getNickname() %></td>
						<td><%=news_DTO.getCreate_date() %></td>
						<td><%=news_DTO.getReadcount() %></td>
					</tr>
				<%	
				}
				%>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='admin_write.jsp'">
			</div>
			<div id="table_search">
				<form action="admin_search.jsp" method="get">
					<select name="searchType">
						<option value="subject">제목</option>
						<option value="nickname" <%if(searchType.equals("nickname")) { %>selected="selected" <%} %>>작성자</option>
					</select>
					<input type="text" name="search" class="input_box" value="<%=search%>">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>
			<!-- 페이징 처리 -->
			<div class="clear"></div>
			<div id="page_control">
				<%if(pageNum > 1) { // 이전페이지가 존재할 경우 %>
					<a href="admin_search.jsp?page=<%=pageNum - 1%>&search=<%=search%>&searchType=<%=searchType%>">Prev</a>
				<%} else { // 이전페이지가 존재하지 않을 경우 %>
					Prev&nbsp;
				<%} %>
				<%for(int i = startPage; i <= endPage; i++) { %>
					<%if(pageNum == i) { %>
						&nbsp;&nbsp;<%=i %>&nbsp;&nbsp;
					<%} else { %>
						<a href="admin_search.jsp?page=<%=i%>&search=<%=search%>&searchType=<%=searchType%>"><%=i %></a>
					<%} %>
				<%} %>
				<%if(pageNum < maxPage) { // 다음페이지가 존재할 경우 %>
					<a href="admin_search.jsp?page=<%=pageNum + 1%>&search=<%=search%>&searchType=<%=searchType%>">Next</a>
				<%} else { // 이전페이지가 존재하지 않을 경우 %>
					&nbsp;Next
				<%} %>
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>