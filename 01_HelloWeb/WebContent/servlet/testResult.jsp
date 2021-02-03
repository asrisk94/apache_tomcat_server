<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>
    <%-- jsp 주석 --%>
    <%
    	// java 코드 작성 공간
    	String name = request.getParameter("name");
		String color = request.getParameter("color");
		String animal = request.getParameter("animal");
		String[] foodArr = request.getParameterValues("food");
		
		// servlet 생산 데이터
		Date now = (Date)request.getAttribute("now");
		
		System.out.println("jsp내 자바코드");
		System.out.println("name@jsp = " + name);
		System.out.println("color@jsp = " + color);
		System.out.println("animal@jsp = " + animal);
		System.out.println("food@jsp = " + Arrays.toString(foodArr));
		System.out.println(now);
		// jsp에서는 HttpServletRequest, HttpServletResponse 객체에 
		// 선언없이 request, response명으로 접근할 수 있다.
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트 결과</title>
</head>
<body>
	<h1>테스트결과</h1>
	<p><%= now%></p>
	<%-- jsp표현식 : 출력시 사용. ;(세미콜론 금지)    jsp 자바코드에 =을 더해준게 출력식! --%>
	<p>이름 : <%= name %></p>
	<p>색깔 : <%= color %></p>
	<p>동물 : <%= animal %></p>
	<p>음식 : <%= Arrays.toString(foodArr) %></p>
</body>
</html>