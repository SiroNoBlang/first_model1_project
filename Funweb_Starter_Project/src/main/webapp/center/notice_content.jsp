<%@page import="test_board.BoardBean"%>
<%@page import="test_board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// URL 파라미터로 전달받은 글번호(num)와 페이지번호(page => pageNum) 를 가져와서 저장
int num = Integer.parseInt(request.getParameter("num")); // 정수형으로 변환 필수

// 페이지번호의 경우 URL 파라미터 전달용이므로 굳이 정수형으로 변환 불필요
String pageNum = request.getParameter("page");

// 로그인을 하면 session에 저장해둔 닉네임을 가져와서 작성자에 자동으로 입력되도록 하기 위한 변수
String nickname = (String)session.getAttribute("sNickname");

BoardDAO boardDAO = new BoardDAO();

// updateReadcount() 메서드를 호출하여 게시물 조회수 증가
boardDAO.updateReadcount(num);

// selectBoard() 메서드를 호출하여 게시물 상세 내용 조회
BoardBean board = boardDAO.selectBoard(num);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!-- 로그인을 하지 않아 닉네임 값이 null이면 정보를 볼 수 없게 하고 싶은데 왜 안될까요? -->
<%if(nickname == null){ %>
<script type="text/javascript">
	alert("로그인 하셔야지 정보를 볼 수 있습니다!");
	history.back();
</script>
<%} %>
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
				<li><a href="#">Notice</a></li>
				<li><a href="#">Public News</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->

		<article>
			<h1>Notice Content</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
					<td><%=board.getNum() %></td>
					<td>글쓴이</td>
					<td><%=board.getNickname() %></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=board.getCreate_date() %></td>
					<td>조회수</td>
					<td><%=board.getReadcount() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=board.getSubject() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><%=board.getContent() %></td>
				</tr>
			</table>

			<div id="table_search">
				<!-- 닉네임이 일치 해야지만 수정과 삭제를 할 수 있도록 작업해봤다. -->
				<%if(nickname.equals(board.getNickname())) {%>
				<!-- 글 수정 클릭 시 notice_update.jsp 페이지로 이동(글번호, 페이지번호 전달) -->
				<input type="button" value="글수정" class="btn" 
						onclick="location.href='notice_update.jsp?num=<%=board.getNum() %>&page=<%=pageNum %>'">
				<!-- 글 수정 클릭 시 notice_delete.jsp 페이지로 이동(글번호, 페이지번호 전달) -->
				<input type="button" value="글삭제" class="btn" 
						onclick="location.href='notice_delete.jsp?num=<%=board.getNum() %>&page=<%=pageNum %>'">
				<%} %>
				<!-- 글목록 버튼 클릭 시 notice.jsp 페이지로 이동(페이지번호 전달) --> 
				<input type="button" value="글목록" class="btn" 
						onclick="location.href='notice.jsp?page=<%=pageNum%>'">
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
