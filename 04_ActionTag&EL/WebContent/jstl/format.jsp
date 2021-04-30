<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>Format</h1>
	
	
	
	<h2>숫자</h2>
	<c:set var="num1">1234567890</c:set>
	<c:set var="num2">123.4567</c:set>
	<ul>
		<li>
			<fmt:formatNumber value="${num1}" pattern="#,###" />
		</li>
		<li>
			<%-- 사실 현지 기준으로 뜨기 때문에 원화는 셋로케일 안써줘도 된다. --%>
			<fmt:setLocale value="ko_kr"/>
			<fmt:formatNumber value="${num1}" type="currency" />
		</li>
		<li>
			<fmt:formatNumber value="${num2}" pattern="#.##" />
		</li>
		<li>
			<%-- 버림처리 --%>
			<fmt:formatNumber value='<%= Math.floor(Double.valueOf((String)pageContext.getAttribute("num2")) * 100) / 100 %>' pattern="#.##"/>
		</li>
		<li>
			<fmt:formatNumber value="0.015235" type="percent" maxFractionDigits="2"/>
			<%-- maxFractionDigits는 소수표시 자릿수 제한 --%>
		</li>
	</ul> 
	
	
	
	<h2>날짜 시각</h2>
	<c:set var="now" value="<%= new Date() %>" />
	<ul>
		<li>
		  	<%-- type both는 날짜와 시간 모두 표시하겠다는 의미 --%>
			<fmt:formatDate value="${now}" type="both"/>
		</li>
		<li>
			<%-- 포맷을 직접 지정하고 싶다면, 심데포에서 썼던 것처럼 다 써주면 된다. --%>
			<fmt:formatDate value="${now}" pattern="yyyy/MM/dd(E) HH:mm:ss"/>
		</li>
	</ul>
	
	
	
	
</body>
</html>