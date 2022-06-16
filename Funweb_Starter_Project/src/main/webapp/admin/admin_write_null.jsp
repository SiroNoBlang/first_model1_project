<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nickname = (String)session.getAttribute("sNickname");

// 이부분이 바로 그 부분 test_master_news내부에서 닉네임을 다 빼와서 여기서 맞는지 확인하고 싶은데 어려우면
// 어쩔 수 없이 하드코딩으로 일단 막아두는 방법으로 할 예정입니다.
if(!nickname.equals("hypers")){
	%>
	<script type="text/javascript">
	alert("관리자가 아니라서 작성할 수 없습니다!!");
	history.back();
	</script>
	<%
}
%>