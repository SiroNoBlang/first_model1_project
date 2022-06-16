<%@page import="test_master.Master_news_DAO"%>
<%@page import="test_master.Master_news_DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String pageNum = request.getParameter("page");
int num = Integer.parseInt(request.getParameter("num"));
String nickname = request.getParameter("nickname");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

Master_news_DTO news_DTO = new Master_news_DTO();
news_DTO.setNum(num);
news_DTO.setNickname(nickname);
news_DTO.setPass(pass);
news_DTO.setSubject(subject);
news_DTO.setContent(content);

Master_news_DAO news_DAO = new Master_news_DAO();
int updateCount = news_DAO.updateNews(news_DTO);

if(updateCount > 0) {
	response.sendRedirect("admin_content.jsp?num=" + num + "&page=" + pageNum);
} else {
	%>
	<script>
		alert("글 수정 실패!");
		history.back(); 
	</script>
	<%
}
%>    
