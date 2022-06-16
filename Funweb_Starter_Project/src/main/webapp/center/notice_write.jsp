<%@page import="test_member.MemberDTO"%>
<%@page import="test_member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String nickname = (String)session.getAttribute("sNickname");
MemberDAO memberDAO = new MemberDAO();
MemberDTO dto = memberDAO.selectMemberPass(nickname);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_write.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	// 로그인하지 않으면 닉네임 값이 session에 저장되어 있지 않아 글을 작성할 수 없게 만듬
	function checkNickname() {
		var pass = document.fr.pass.value;
		
		if(<%=nickname %> == null) {
			alert("로그인하지 않아 글을 작성할 수 없습니다!!");
			history.back();
			return false;
		}
		
		// member 테이블에 저장된 nickname과 일치하는 패스워드를 가져와서 지금 현재 입력한
		// pass와 가져온 패스워드가 일치하면 넘기고 아니면 다시 입력하라고 할 생각인데 잘 안된다.
		// 이 부분은 뭐가 문제인지 강사님한테 물어볼 부분이다.
		if(!<%=dto.getPass() %>.equals(pass)) {
			alert("비밀번호가 일치 하지 않습니다. 다시 입력해주세요!!");
			document.fr.pass.focus();
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
				<li><a href="notice.jsp">Notice</a></li>
				<li><a href="notice_news.jsp">Public News</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Notice Write</h1>
			<form action="notice_writePro.jsp" id="fr" method="post" onsubmit="return checkNickname()">
				<table id="notice">

					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="nickname" <%if(nickname == null) {%>value=""<%} else { %>value="<%=nickname %>"<%} %> readonly="readonly" required="required"></td>
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
					<input type="submit" value="글쓰기" class="btn">
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
