<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Date" import="java.text.SimpleDateFormat" %>
    
<%
	// server단 처리. : java코드로 연산
	int sum = 0;
	for(int i=1; i<11; i++) {
		sum += i;
	}
	
	Date now = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E) HH:mm:ss");
	String date = sdf.format(now);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp test</title>
<script>
	window.onload = function() {
		var sum = 0;
		for(var i=0; i<=10; i++) {
			sum += i;	
		}
		document.querySelector("span#result").innerHTML = sum;
		alert("클라이언트 계산이 끝났습니다.");
		
		
		
		
        function make2digit(n) {
            return n<10 ? "0" + n : n;
        }
		
		var now = new Date();
		var date = now.getFullYear() + "/" + 
					(now.getMonth()+1).toString().padStart(2, "0") + "/" + 
					make2digit(now.getDate()) + " " + 
					make2digit(now.getHours()) + ":" + 
					make2digit(now.getMinutes()) + ":" + 
					now.getSeconds();
		document.querySelector("span#time").innerHTML = date;
	}
</script>
</head>
<body>
	<%-- jsp 주석 : java파일 변환시 생략됨 --%>
	<!-- html주석 : client까지 전달되고, 화면처리에서 생략 -->
	<h1>JSP Test</h1>
	<p>1~10까지 합 구하기</p>
	<ul>
		<li>서버 : <%--<%= sum %> 이거랑 <% out.print(sum); %> 이나 똑같다. --%> <%out.print(sum);%> </li>
		<li>클라이언트 : <span id="result"></span></li>
	</ul>
	<p>시각 표시</p>
	<ul>
		<li>서버 : <%= date%></li>
		<li>클라이언트 : <span id="time"></span></li>
	</ul>
</body>
</html>