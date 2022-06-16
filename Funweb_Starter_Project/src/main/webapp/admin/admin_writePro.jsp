<%@page import="test_master.Master_news_DAO"%>
<%@page import="test_master.Master_news_DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// post방식으로 넘어오기 때문에 한글 처리 필수!
request.setCharacterEncoding("UTF-8");

Master_news_DTO news_DTO = new Master_news_DTO();
news_DTO.setNickname(request.getParameter("nickname"));
news_DTO.setPass(request.getParameter("pass"));
news_DTO.setSubject(request.getParameter("subject"));
news_DTO.setContent(request.getParameter("content"));

// 추가해서 넣기 위한 insertNews()메서드 작성
Master_news_DAO news_DAO = new Master_news_DAO();
int insertCount = news_DAO.insertNews(news_DTO);

if(insertCount > 0) {
	response.sendRedirect("admin.jsp");
} else {
	%>
	<script type="text/javascript">
		alert("글쓰기 실패!");
		history.back();
	</script>
	<%
}
%>