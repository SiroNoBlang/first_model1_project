<%@page import="test_board.BoardBean"%>
<%@page import="test_board.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/main.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->
<%-- 		<%@ include file="../inc/top.jsp" %> --%>
		
		<div class="clear"></div>   
		<!-- 본문들어가는 곳 -->
		<!-- 메인 이미지 -->
		<div id="main_img"><img src="../images/main_img.jpg"></div>
		<!-- 본문 내용 -->
		<article id="front">
		  	<div id="solution">
		  		<div id="hosting">
		  			<h3>Web Hosting Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  		<div id="security">
		  		  	<h3>Web Security Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  		<div id="payment">
		  			<h3>Web Payment Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  	</div>
		  	<div class="clear"></div>
			<div id="sec_news">
				<h3><span class="orange">Security</span> News</h3>
				<dl>
					<dt>Vivamus id ligula....</dt>
					<dd>Proin quis ante Proin quis anteProin 
					quis anteProin quis anteProin quis anteProin 
					quis ante......</dd>
				</dl>
				<dl>
					<dt>Vivamus id ligula....</dt>
					<dd>Proin quis ante Proin quis anteProin 
					quis anteProin quis anteProin quis anteProin 
					quis ante......</dd>
				</dl>
			</div>
			
			
			<div id="news_notice">
		  		<h3 class="brown">조회수</h3>
				<table>
					<tr>
						<td width="320">제목</td>
						<td width="80">작성자</td>
						<td width="80">조회수</td>
					</tr>
					<%
					// selectRecentBoardList() 메서드를 호출하여 조회수 많은 순으로 4개 조회
					BoardDAO boardDAO = new BoardDAO();
					ArrayList<BoardBean> boardList = boardDAO.selectRecentBoardList();
					
					for(BoardBean board : boardList) {
					%>
						<!-- 게시물 행 클릭 시 notice_content.jsp 페이지로 이동(해당 게시물 표시) -->
						<tr onclick="location.href='../center/notice_content.jsp?num=<%=board.getNum() %>&page=1'">
							<td width="320" class="contxt"><%=board.getSubject() %></td>
							<td width="80"><%=board.getNickname() %></td>
							<td width="80"><%=board.getReadcount() %></td>
						</tr>
					<%} %>
				</table>
		  	</div>
	  	</article>
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
<%-- 		<%@ include file="../inc/bottom.jsp" %> --%>
	</div>
</body>
</html>


