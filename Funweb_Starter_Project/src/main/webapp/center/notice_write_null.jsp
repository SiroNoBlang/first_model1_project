<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nickname = (String)session.getAttribute("sNickname");

if(nickname == null){
	%>
	<script type="text/javascript">
	alert("로그인하지 않아 글을 작성할 수 없습니다!!");
	history.back();
	</script>
	<%
}
%>