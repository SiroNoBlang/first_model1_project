<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("sId");
String nickname = (String)session.getAttribute("sNickname"); // 이 닉넴임 가져오기가 너무 하고 싶엇다 ㅋㅋㅋㅋ
%>
<header>
	<!-- login join -->
	<div id="login">
		<%if (id == null) { %>
			<a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a>
		<%} else { %>
			<a href="../member/member_info.jsp"><%=nickname%>님</a> | <a href="../member/logout.jsp">logout</a>
			<%if (id.equals("admin")) { // 관리자 계정일 경우 %>
				| <a href="../admin/admin.jsp">관리자페이지</a>
			<%} %>
		<%} %>
		<div class="clear"></div>
	</div>
	<!-- 로고들어가는 곳 -->
	<div id="logo">
		<img src="../images/logo.gif">
	</div>
	<!-- 메뉴들어가는 곳 -->
	<nav id="top_menu">
		<ul>
			<li><a href="../main/main.jsp">HOME</a></li>
			<li><a href="../company/welcome.jsp">COMPANY</a></li>
			<li><a href="../company/welcome.jsp">SOLUTIONS</a></li>
			<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
			<li><a href="../mail/mailForm.jsp">CONTACT US</a></li>
		</ul>
	</nav>
</header>