<%@page import="test_master.Master_news_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String pageNum = request.getParameter("page");
int num = Integer.parseInt(request.getParameter("num"));
String pass = request.getParameter("pass");

Master_news_DAO news_DAO = new Master_news_DAO();
int deleteCount = news_DAO.deleteNews(num, pass);

if(deleteCount > 0) {
	response.sendRedirect("admin.jsp?page=" + pageNum);
} else {
	%>
	<script>
		alert("글 삭제 실패!");	
		history.back();
	</script>
	<%
}
%>