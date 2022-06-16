<%@page import="test_board.BoardDAO"%>
<%@page import="test_board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// notice_write.jsp 페이지로부터 전달받은 파라미터를 BoardBean 객체에 저장
BoardBean board = new BoardBean();
board.setNickname(request.getParameter("nickname"));
board.setPass(request.getParameter("pass"));
board.setSubject(request.getParameter("subject"));
board.setContent(request.getParameter("content"));

// insertBoard() 메서드를 호출하여 게시물 등록 작업 요청
BoardDAO boardDAO = new BoardDAO();
int insertCount = boardDAO.insertBoard(board);

// 게시물 등록 작업 요청 결과 처리
if(insertCount > 0) {
	response.sendRedirect("notice.jsp");
} else {
	%>
	<script>
		alert("글쓰기 실패!");
		history.back();
	</script>
	<%
}

%>