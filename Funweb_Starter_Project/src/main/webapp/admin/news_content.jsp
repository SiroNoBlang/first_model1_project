<%@page import="test_master.Master_news_DAO"%>
<%@page import="test_master.Master_news_DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 앞에서 같이 넘겨준 번호는 String타입으로 넘어오기 때문에 int형으로 형변환이 필요하다.
int num = Integer.parseInt(request.getParameter("num"));

String pageNum = request.getParameter("page");
// session에 저장해둔 닉넴을 가져와서 확인 작업으로 쓰기 위해서 변수 nickname에 저장
String nickname = (String)session.getAttribute("sNickname");

Master_news_DAO news_DAO = new Master_news_DAO();
// updateReadCount()메서드를 작성하여 게시물 조회수 증가 작업
news_DAO.updateReadcount(num);
// selectNews()메서드를 작성하여 게시물 상세 내용을 조회할 수 있도록 작업
Master_news_DTO news_DTO = news_DAO.selectNews(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
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
				<li><a href="admin.jsp">News List</a></li>
				<li><a href="admin_client.jsp">Client</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->

		<article>
			<h1>News List</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
					<td><%=news_DTO.getNum() %></td>
					<td>글쓴이</td>
					<td><%=news_DTO.getNickname() %></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=news_DTO.getCreate_date() %></td>
					<td>조회수</td>
					<td><%=news_DTO.getReadcount() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=news_DTO.getSubject() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><%=news_DTO.getContent() %></td>
				</tr>
			</table>

			<div id="table_search">
				<!-- 닉네임이 일치 해야지만 수정과 삭제를 할 수 있도록 작업해봤다. -->
				<%if(nickname.equals(news_DTO.getNickname())) {%>
				<!-- 글 수정 클릭 시 notice_update.jsp 페이지로 이동(글번호, 페이지번호 전달) -->
				<input type="button" value="글수정" class="btn" 
						onclick="location.href='admin_update.jsp?num=<%=news_DTO.getNum() %>&page=<%=pageNum %>'">
				<!-- 글 수정 클릭 시 notice_delete.jsp 페이지로 이동(글번호, 페이지번호 전달) -->
				<input type="button" value="글삭제" class="btn" 
						onclick="location.href='admin_delete.jsp?num=<%=news_DTO.getNum() %>&page=<%=pageNum %>'">
				<%} %>
				<!-- 글목록 버튼 클릭 시 notice.jsp 페이지로 이동(페이지번호 전달) --> 
				<input type="button" value="글목록" class="btn" 
						onclick="location.href='admin.jsp?page=<%=pageNum%>'">
			</div>

			<div class="clear"></div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>