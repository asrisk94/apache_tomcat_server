<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Action Tag & EL</title>
</head>
<body>
	<h1>Action Tag & EL</h1>
	<h2>Action Tag</h2>
	<h3>Standard Action Tag</h3>
	<ul>
		<li><a href="<%= request.getContextPath() %>/standard/person.do?name=세종&gender=남&age=67&married=false">jsp:useBean</a></li>
		<li><a href="<%= request.getContextPath() %>/standard/include.jsp">jsp:include</a></li>
	</ul>
	
	<h3>JSTL - Custom Action Tag</h3>

	<h2>EL</h2>
	<ul>
		<li><a href="${pageContext.request.contextPath}/el/basic.do?productId=p123&amount=33&option=aaaa&option=bbbb">EL Basics</a></li>
		<li><a href="${pageContext.request.contextPath}/el/operator">EL Operator</a></li>
	</ul>
	
	<h2>jstl</h2>
	
	<ul>
		<li><a href="${pageContext.request.contextPath}/jstl/coreBasic.jsp?no1=370&no2=98">core - basic</a></li>
		<li><a href="${pageContext.request.contextPath}/jstl/forEach.do">core - forEach</a></li>
		<li><a href="${pageContext.request.contextPath}/jstl/format.jsp">format</a></li>
		<li><a href="${pageContext.request.contextPath}/jstl/function.jsp">function</a></li>
	</ul>
	
</body>
</html>