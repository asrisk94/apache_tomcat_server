<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- prefix에서 c는 core --%>
<%--
	JSTL : JSP Standard Tag Library
	
	Custom Action Tag로 별도의 jar 파일을 프로젝트에 추가한 후 사용할 수 있다.
--%>

<%-- set은 세팅 태그. setAttribute같은 느낌. var는 변수명 --%>
<c:set var="num1">90</c:set>
<c:set var="num2" value="20" scope="page" />
<%-- 
	위에 쓴 식은 아래와 같다.
	<% 
		int num1 = 100; 
		pageContext.setAttribute("num1", num1); 
	%> 
--%>

<c:set var="today" value="<%= new Date() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - core</title>
</head>
<body>

	<h1>JSTL - core</h1>
	
	<%-- out은 출력식 --%>
	<ul>
		<li>num1 : <c:out value="${num1}" /> ${num1}</li>
		<li>num2 : <c:out value="${num2}" /> ${num2}</li>
		<li>${today}</li>
	</ul>	
	
	
	
	<h2>c:if</h2>
	
<%-- 	<c:if test="${num1 > num2}"> --%>
<%-- 		${num1}이 ${num2}보다 큽니다. --%>
<%-- 	</c:if> --%>
<%-- 	<c:if test="${num1 < num2}"> --%>
<%-- 		${num1}이 ${num2}보다 작습니다. --%>
<%-- 	</c:if> --%>
<%-- 		<c:if test="${num1 eq num2}"> --%>
<%-- 		${num1}과 ${num2}은 같습니다. --%>
<%-- 	</c:if> --%>

	<%-- 
		비교연산자 그냥 쓰면, 사전 등재순으로 비교를 해버린다. 
		제대로 비교하고싶다면 형변환 필요.
	--%>
	<c:if test="${Integer.parseInt(num1) > Integer.parseInt(num2)}">
		${num1}이 ${num2}보다 큽니다.
	</c:if>
	<c:if test="${Integer.parseInt(num1) < Integer.parseInt(num2)}">
		${num1}이 ${num2}보다 작습니다.
	</c:if>
		<c:if test="${Integer.parseInt(num1) eq Integer.parseInt(num2)}">
		${num1}과 ${num2}은 같습니다.
	</c:if>
	
	<hr />
	
	<c:if test="${Integer.parseInt(param.no1) < Integer.parseInt(param.no2)}">
		${param.no1}이 ${param.no2}보다 작습니다.
	</c:if>
	<c:if test="${Integer.parseInt(param.no1) > Integer.parseInt(param.no2)}">
		${param.no1}이 ${param.no2}보다 큽니다.
	</c:if>
	<c:if test="${Integer.parseInt(param.no1) eq Integer.parseInt(param.no2)}">
		${param.no1}과 ${param.no2}가 같습니다.
	</c:if>
	
	<h2>c:choose</h2>
	<c:choose>
		<c:when test="${num1 % 3 == 0}">
			${num1}은 3의 배수입니다.
		</c:when>
		<c:when test="${num1 % 3 == 1}">
			${num1}은 3으로 나눈 나머지가 1입니다.
		</c:when>
		<c:otherwise>
			${num1}은 3으로 나눈 나머지가 2입니다.
		</c:otherwise>
		<%-- c:if와 다르게 else기능을 하는 otherwise가 있다. --%>
	</c:choose>	

	<h2>c:forEach</h2>
	<div class="wrapper" style="color: deeppink;">
		<c:forEach var="i" begin="1" end="6" step="1">
			<h${i}>안녕${i}</h${i}>
		</c:forEach>	
		<%-- 비긴을 큰 수로 두고 스텝에 음수를 써서 줄어드는걸 하고 싶을 수 있지만, 그건 안됨. --%>
		<c:forEach var="i" begin="1" end="6">
			<h${7-i}>안녕${7-i}</h${7-i}>
		</c:forEach>
		<%-- 이런식의 꼼수 필요 --%>
	</div>

	<h2>c:url</h2>
	<img src="${pageContext.request.contextPath}/images/칠레택시.jpeg" alt="">
	<img src="<c:url value="/images/칠레택시.jpeg"/>" alt="">
	<%-- c:url은 컨텍스트패쓰가 포함된 형태의 태그. 따라서 루트디렉토리 역할을 한다. --%>
	
	<br /><br />
	
	<%-- 링크 달아서 클릭하면 해당 네임속성명과 속성값 담아 보내서 열 수 있음 --%>
	<c:url var="link" value="coreBasic.jsp">
		<c:param name="query">안녕</c:param>
		<c:param name="type">img</c:param>
		<c:param name="start">20200101</c:param>
		<c:param name="end">20210316</c:param>
		<c:param name="no1">100</c:param>
		<c:param name="no2">30</c:param>
	</c:url>
	<a href="${link}">${link}</a>
	
</body>
</html>