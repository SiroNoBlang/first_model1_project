<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 세션 초기화 (invalidate()메서드 사용)
session.invalidate();
response.sendRedirect("../main/main.jsp");
%>