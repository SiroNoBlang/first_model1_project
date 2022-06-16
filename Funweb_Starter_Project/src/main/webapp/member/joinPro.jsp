<%@page import="test_member.MemberDTO"%>
<%@page import="test_member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8"); // 한글처리
// 전달받은 파라미터 저장
String nickname = request.getParameter("nickname");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
String postcode = request.getParameter("postcode");
String address = request.getParameter("address") + " "+ request.getParameter("extraAddress") + " " +request.getParameter("detailAddress");
String gender = request.getParameter("gender");
String job = request.getParameter("job");
String email = request.getParameter("email1") + "@" + request.getParameter("email2");
%>
<%
// 회원 가입에 필요한 데이터를 MemberDTO에 저장하기 위한 작업
MemberDTO memberDTO = new MemberDTO();
memberDTO.setNickname(nickname);
memberDTO.setId(id);
memberDTO.setPass(pass);
memberDTO.setName(name);
memberDTO.setPhone(phone);
memberDTO.setJob(job);
memberDTO.setGender(gender);
memberDTO.setEmail(email);
memberDTO.setPostcode(postcode);
memberDTO.setAddress(address);

// MemberDAO를 생성하여 insertCount()를 호출하여 회원가입 처리
MemberDAO memberDAO = new MemberDAO();
int insertCount = memberDAO.insertCount(memberDTO);

if(insertCount > 0) {
// 	System.out.print(postcode); // 안되길래 확인용으로 찍어둔 것
	response.sendRedirect("../main/main.jsp"); // 완료하면 메인페이지로 이동
} else {
	%>
	<script type="text/javascript">
		alert("회원 가입 실패!");
		history.back();
	</script>
	<%
}
%>