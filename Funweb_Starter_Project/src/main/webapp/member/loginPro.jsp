<%@page import="test_member.MemberDAO"%>
<%@page import="test_member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDTO memberDTO = new MemberDTO();
memberDTO.setId(id);
memberDTO.setPass(pass);

MemberDAO memberDAO = new MemberDAO();
boolean isLoginSuccess = memberDAO.checkUser(memberDTO);
// 닉넴이 가져와서 출력하기 위해서 굳이 만듬
String selectNickname = memberDAO.selectNickname(memberDTO);

if(isLoginSuccess){
	session.setAttribute("sId", id);
	// 세션에 저장하고 써야 다른 페이지를 가도 띄울 수 있기 때문에
	session.setAttribute("sNickname", selectNickname);
	response.sendRedirect("../main/main.jsp");
} else {
	%>
	<script type="text/javascript">
		alert("아이디 또는 패스워드 틀림!");
		history.back();
	</script>
	<%
}
%>