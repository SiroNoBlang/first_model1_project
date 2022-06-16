<%@page import="test_member.MemberDTO"%>
<%@page import="test_member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String pass = request.getParameter("pass");
String name = request.getParameter("name");
String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
String postcode = request.getParameter("postcode");
String address = request.getParameter("address") + " "+ request.getParameter("extraAddress") + " " +request.getParameter("detailAddress");
String gender = request.getParameter("gender");
String job = request.getParameter("job");
String email = request.getParameter("email1") + "@" + request.getParameter("email2");

MemberDTO memberDTO = new MemberDTO();
memberDTO.setId(request.getParameter("id"));
memberDTO.setPass(pass);
memberDTO.setPhone(phone);
memberDTO.setPostcode(postcode);
memberDTO.setAddress(address);
memberDTO.setGender(gender);
memberDTO.setJob(job);
memberDTO.setEmail(email);

MemberDAO memberDAO = new MemberDAO();
int updateCount = memberDAO.updateMember(memberDTO);

if(updateCount > 0){
	%>
	<script type="text/javascript">
		alert("수정 완료!");
		location.href="member_info.jsp";
	</script>
	<%
// 	response.sendRedirect("member_info.jsp");
} else {
	%>
	<script type="text/javascript">
		alert("정보 수정 실패!");
		history.back();
	</script>
	<%
}
%>