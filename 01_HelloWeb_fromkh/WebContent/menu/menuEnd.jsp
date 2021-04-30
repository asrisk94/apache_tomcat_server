<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String main_menu = request.getParameter("main_menu");
	String side_menu = request.getParameter("side_menu");
	String drink_menu = request.getParameter("drink_menu");
	int price = (int)request.getAttribute("price");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 결과 페이지</title>
<style>
span#main_menu {color:navy; font-size:2em;}
span#side_menu {color:indigo; font-size:1.5em;}
span#drink_menu {color:yellowgreen;}
span#price {color:maroon; font-size:2.5em;}
</style>
</head>
<body>
	<h2>감사합니다.</h2>
		<span id="main_menu"><%=main_menu %></span>,
		<span id="side_menu"><%=side_menu %></span>,
		<span id="drink_menu"><%=drink_menu %></span>을/를 주문하셨습니다. <br />
		총 결제금액은 <span id="price"><%=price %>원</span> 입니다.
</body>
</html>