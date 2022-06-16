<%@page import="test_member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");

MemberDAO memberDAO = new MemberDAO();
boolean isDuplicate = memberDAO.isDuplicate(id);

response.sendRedirect("check_id.jsp?duplicate=" + isDuplicate + "&id=" + id);
%>