<%@page import="test_master.Master_news_DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="test_master.Master_news_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String nickname = (String)session.getAttribute("sNickname");
// 페이징 처리
int pageNum = 1; // 현재 페이지 번호를 저장할 변수 선언. 기본값 1 설정

// 현재 페이지 번호가 저장된 page 파라미터에서 값을 가져와서 pageNum 변수에 저장하되, page 파라미터가 존재할 경우에만 가져오기
if(request.getParameter("page") != null) {
	pageNum = Integer.parseInt(request.getParameter("page")); // String -> int 형변환 필요
}

int listLimit = 10; // 한 페이지 당 표시할 목록(게시물) 갯수
int pageLimit = 10; // 한 페이지 당 표시할 페이지 갯수

// selectListCount() 메서드를 호출하여 게시물 전체 목록 갯수 조회 작업
Master_news_DAO news_DAO = new Master_news_DAO();
int newsListCount = news_DAO.selectNewsListCount();

// ceil() 메서드를 사용하여 반올림 가능
int maxPage = (int)Math.ceil((double)newsListCount / listLimit);

// 현재 페이지에서 보여줄 시작 페이지 번호 계산식
int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;

// 현재 페이지에서 보여줄 끝 페이지 번호 계산식
int endPage = startPage + pageLimit - 1;

// 끝 페이지(endPage)가 현재 페이지에서 표시할 총 페이지 수(maxPage)보다 클 경우 -> 끝 페이지 번호를 총 페이지 수로 대체
if(endPage > maxPage) {
	endPage = maxPage;
}

// ----------------------------------------------------------------------------------------
// selectBoardList() 메서드를 호출하여 게시물 목록 조회 작업
ArrayList<Master_news_DTO> newsList = news_DAO.selectNewsList(pageNum, listLimit);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin/admin.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="notice.jsp">Notice</a></li>
				<li><a href="notice_news.jsp">Public News</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Public News List</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				<%for(Master_news_DTO news : newsList) { %>
					<tr onclick="location.href='public_news_content.jsp?num=<%=news.getNum() %>&page=<%=pageNum %>'">
						<td><%=news.getNum() %></td>
						<td class="left"><%=news.getSubject() %></td>
						<td><%=news.getNickname() %></td>
						<td><%=news.getCreate_date() %></td>
						<td><%=news.getReadcount() %></td>
					</tr>
				<%} %>
			</table>
			<%if(nickname.equals("hypers") ) {%>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='../admin/admin_write.jsp'">
			</div>
			<%} else { %>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='../admin/admin_write_null.jsp'">
			</div>
			<%} %>
			<div id="table_search">
				<form action="notice_search_news.jsp" method="get">
					<select name="searchType">
						<option value="subject">제목</option>
						<option value="nickname">작성자</option>
					</select>
					<input type="text" name="search" class="input_box">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>
			<!-- 페이징 처리 -->
			<div class="clear"></div>
			<div id="page_control">
				<%if(pageNum > 1) { // 이전페이지가 존재할 경우 %>
					<a href="../admin/admin.jsp?page=<%=pageNum - 1%>">Prev</a>
				<%} else { // 이전페이지가 존재하지 않을 경우 %>
					Prev&nbsp;
				<%} %>
				<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
				<%for(int i = startPage; i <= endPage; i++) { %>
					<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
					<%if(pageNum == i) { %>
						&nbsp;&nbsp;<%=i %>&nbsp;&nbsp;
					<%} else { %>
						<a href="../admin/admin.jsp?page=<%=i%>"><%=i %></a>
					<%} %>
				<%} %>
				<%if(pageNum < maxPage) { // 다음페이지가 존재할 경우 %>
					<a href="../admin/admin.jsp?page=<%=pageNum + 1%>">Next</a>
				<%} else { // 이전페이지가 존재하지 않을 경우 %>
					&nbsp;Next
				<%} %>
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
	</div>
</body>
</html>