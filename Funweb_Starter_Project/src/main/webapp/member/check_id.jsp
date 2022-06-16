<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 만에 하나 아이디를 한글로 작성시 오류 방지를 위해서 한글 처리
request.setCharacterEncoding("UTF-8");
// 여기서 입력한 파라미터를 앞으로 전달해주기 위해서 변수에 저장하여 사용
String id = request.getParameter("id");
String isDuplicate = request.getParameter("duplicate");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function useId(id) {
		// 자식창에서 부모창을 제어하려면 window.opener. 형태로 제어
		window.opener.document.fr.id.value = id;
		// 부모창의 전역변수 checkIdResult의 값을 true로 변경
		window.opener.checkIdResult = true;
		// 창닫기
		window.close();
	}
</script>
</head>
<body>
	<h1>중복체크</h1>
	<form action="check_id_pro.jsp">
		<input type="text" name="id" <%if (id != null) {%> value="<%=id%>" <%}%> required="required">
		<input type="submit" value="중복확인">
	</form>
	<div id="checkIdResult">
		<!-- 중복체크 확인 결과 위치-->
		<%if (isDuplicate != null && isDuplicate.equals("true")) { %>
		<br>이미 사용중인 아이디입니다.
		<%} else if (isDuplicate != null && isDuplicate.equals("false")) { %>
		<br>사용가능한 아이디입니다. <input type="button" value="아이디 사용"
			onclick="useId('<%=id%>')">
		<%} %>
	</div>
</body>
</html>