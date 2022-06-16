<%@page import="test_board.BoardDAO"%>
<%@page import="test_board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// 폼 파라미터 데이터 가져오기
String pageNum = request.getParameter("page");
int num = Integer.parseInt(request.getParameter("num"));
String nickname = request.getParameter("nickname");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

// BoardBean 객체 생성하여 폼 파라미터 데이터(페이지번호 제외) 저장
BoardBean board = new BoardBean();
board.setNum(num);
board.setNickname(nickname);
board.setPass(pass);
board.setSubject(subject);
board.setContent(content);

// updateBoard() 메서드를 작성하여 게시물 수정 작업
BoardDAO boardDAO = new BoardDAO();
int updateCount = boardDAO.updateBoard(board);

// 수정 작업 결과 판별 및 처리
if(updateCount > 0) {
	response.sendRedirect("notice_content.jsp?num=" + num + "&page=" + pageNum);
} else {
	%>
	<script>
		alert("글 수정 실패!");
		history.back(); 
	</script>
	<%
}
%>    
