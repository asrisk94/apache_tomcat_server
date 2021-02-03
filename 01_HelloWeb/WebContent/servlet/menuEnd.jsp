<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String main = request.getParameter("main_menu");
	String side = request.getParameter("side_menu");
	String drink = request.getParameter("drink_menu");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>menuEnd</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/menuEnd.css" />
<%@ include file="/js.jsp" %>
<!-- css파일은 css폴더에 분리해서 링크 / js파일은 자바코드 참조 문제로 다른 jsp파일로 잘라서 인클루드처리  -->

</head>
<body>
	<h2>감사합니다.</h2>
	<h3><span id="main"><%= main %></span>,<span id="side"><%= side %></span>,<span id="drink"><%= drink %></span>을/를 주문하셨습니다.</h3>
	<h3>총 결제금액은<span id="price"></span>입니다.</h3>
	
	

</body>
</html>