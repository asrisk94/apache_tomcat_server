<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.person.model.vo.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String str1 = "안녕";
	String str2 = new String("안녕");
	
	int big = 100;
	int small = 30;
	
	Person hong1 = new Person("홍길동", '남', 33, false);
	Person hong2 = new Person("홍길동", '남', 33, false);

	List<String> list = null;
	list = new ArrayList<>();
	
	// EL에서 사용가능하도록 속성 저장(pageContext, request, session, application)
	pageContext.setAttribute("str1", str1);
	pageContext.setAttribute("str2", str2);
	pageContext.setAttribute("big", big);
	pageContext.setAttribute("small", small);
	pageContext.setAttribute("hong1", hong1);
	pageContext.setAttribute("hong2", hong2);
	pageContext.setAttribute("list", list);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL - Operator</title>
</head>
<body>
	<h1>EL - Operator</h1>
	<h2>숫자 관련</h2>
	
	<ul>
		<li>${big + small}</li>
		<li>${big - small}</li>
		<li>${big * small}</li>
		<li>${big / small} ${big div small}</li>
		<li>${big % small} ${big mod small}</li>
		
		<li>${big > small} ${big gt small}</li>
		<li>${big >= small} ${big ge small}</li>
		<li>${big < small} ${big lt small}</li>
		<li>${big <= small} ${big le small}</li>
		<li>${big == small} ${big eq small}</li>
		<li>${big != small} ${big ne small}</li>
	</ul>
	
	<h2>문자열 관련</h2>
	<ul>
<%-- 		<li>${str1 + str2}</li> => NFE 오류. 무조건 숫자만 연산   --%>
		
		<li><%= str1 == str2 %> <%= str1.equals(str2) %></li>
<!-- 		false true -->
		<li>${str1 == str2} ${str1 eq str2}</li>
<!-- 		true true -->
		<li><%= str1 != str2 %> <%= !str1.equals(str2) %></li>
<!-- 		true false	 -->
		<li>${str1 != str2} ${str1 ne str2}</li>
<!-- 		false false -->
	</ul>
	
	<h2>기타 객체</h2>
	
	<ul>
		<%-- Person타입 equals/hashCode overriding 필요 --%>
		<li><%= hong1 == hong2 %> ${hong1 == hong2} ${hong1 eq hong2}</li>
		<%-- false true true --%>

		<%-- ${empty 객체} : 해당객체가 null이거나, 요소가 하나도 없는 경우에 true 반환. --%>
		<li>${empty list}</li>
		<li>${not empty list}</li>
	</ul>
	
</body>
</html>