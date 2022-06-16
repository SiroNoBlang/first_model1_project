<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String nickname = (String)session.getAttribute("sNickname");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin/admin_write.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	// 로그인하지 않으면 닉네임 값이 session에 저장되어 있지 않아 글을 작성할 수 없게 만듬
	function checkNickname() {
		if(<%=nickname %> == null) {
			alert("로그인하지 않아 글을 작성할 수 없습니다!!");
			history.back();
			return false;
		}
	}
</script>
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
				<li><a href="admin.jsp">Public News List</a></li>
				<li><a href="admin_client.jsp">Client</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Public News Write</h1>
			<form action="admin_writePro.jsp" method="post" onsubmit="return checkNickname()">
				<table id="notice">

					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="nickname" value="<%=nickname %>" readonly="readonly" required="required"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pass" required="required"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" required="required"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="20" name="content" required="required"></textarea></td>
					</tr>

				</table>

				<div id="table_search">
					<input type="submit" value="저장" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>
