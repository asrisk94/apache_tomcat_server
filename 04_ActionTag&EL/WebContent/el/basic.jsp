<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
	EL : Expression Language
	jsp 2.0부터 사용된 스펙으로, jsp에서  간결한 출력식을 지원한다.
	
	${value}
	
	EL 내장객체
	속성에 저장된 객체를 EL이 별도의 맵으로 작성해둔것. 생략가능.
	생략시 page - request - session - application 순으로 속성을 조회.
	
	 - pageScope
	 - requestScope
	 - sessionScope
	 - applicationScope
	 
	 사용자 입력값 query string
	 - param
	 - paramValues
	 
	 요청 header 정보
	 - header
	 - headerValues
	 
	 쿠키
	 - cookie
	 
	 초기화 파라미터 : application에서 지정한 값들
	 - initParam
	 
	 포인터객체
	 - pageContext : 내장객체중 유일하게 Map이 아닌 포인터 객체
 	 	getErrorDate() 		: ErrorData
 	 	getPage() 			: pageContext
 	 	getRequest() 		: HttpServletRequest
 	 	getResponse() 		: HttpServletResponse
 	 	getSession() 		: HttpSession
 	 	getServletConfig() 	: ServletConfig
 	 	getServletContext() : ServletContext
 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL - basic</title>
</head>
<body>
	<h1>EL - basic</h1>
	
	<ul>
		<li>${coffee}</li>	<%-- requestScope가 sessionScope보다 우선이라 예거체프 나옴. --%>
		<li>${sessionScope.coffee}</li>	<%-- sessionScope를 써줘야 하와이 코나 나옴. --%>
		<%-- scope별 name충돌이 있다면, 내장객체명 생략하지 말것. --%>
		<li>${year}</li>
		<li>${today}</li>
		<li>${person}
			<ul>
				<li>${person.name}</li>			
				<li>${person.age}</li>			
				<li>${person.gender}</li>			
				<li>${person.married}</li>			
			</ul>
		</li>
		<li>${list}
			<ul>
				<li>${list[0]}</li>
				<li>${list[1]}</li>
				<li>${list[2]}</li>
			</ul>
		</li>
		<li>${map}
			<ul>
				<li>${map.num}</li>	<%-- dot notation --%>
				<li>${map['jang']}  <%-- bracket notation --%>
					<ul>
						<li>${map['jang']['name']}</li>					
						<li>${map['jang']['gender']}</li>					
						<li>${map['jang']['age']}</li>					
						<li>${map['jang']['married']}</li>					
					</ul>
				</li>
			</ul>
		</li>
		<li>존재하지 않는 값 : ${hello}</li>
		<%-- 
			hello를 지정한 적이 없음에도 null은 뜨지 않는다. (빈 값) 
			EL은 null을 출력하지 않는다. 비운다.
		--%>
		<li>존재하지 않는 값의 속성을 참조 : ${hello.world}</li>
		<%-- EL은 결코 NullPointerException을 유발하지 않는다. --%>
	</ul>
	
	<h2>param</h2>
	<ul>
		<li>${param.productId}</li>
		<li>${param.amount}</li>
		<%-- param.option을 찍으면 첫번째 값인 aaaa만 나온다. 복수형인 paramValues사용 --%>
		<li>${paramValues}
			<ul>
				<li>${paramValues.opiont[0]}</li>
				<li>${paramValues.opiont[1]}</li>
			</ul>
		</li>
	</ul>
	
	<h2>header</h2>
	<%-- request.getHeader("User-Agent") --%>
	<ul>
		<li>${header["User-Agent"]}</li>
		<li>${header['Referer']}</li>
	</ul>
	
	<h2>cookie</h2>
	<ul>
		<li>${cookie.JSESSIONID}</li>
		<li>${cookie.JSESSIONID.value}</li>
	</ul>
	
	<h2>pageContext</h2>
	<ul>
		<%-- get인지 post인지 접근한 메소드 출력 --%>
		<li><%= request.getMethod() %></li>
		<li>${pageContext.request.method}</li>
		<li><%= request.getContextPath() %></li>
		<li>${pageContext.request.contextPath}</li>
	</ul>
	<ul>
		<li>${pageContext.errorData}</li>
		<li>${pageContext.request}</li>
		<li>${pageContext.response}</li>
		<li>${pageContext.page}</li>
		<li>${pageContext.session}</li>
		<li>${pageContext.servletConfig}</li>
		<li>${pageContext.servletContext}</li>
	</ul>
	
</body>
</html>