<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 태그립 안달아주면 못 씀 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstl - c:forEach</title>

<style>
	table, th, td {
		border : 1px solid black;
		border-collapse: collapse;
	}

</style>

</head>
<body>
	<h1>c:forEach</h1>
	<h2>String[]</h2>
	<ul>
		<c:forEach items="${names}" var="name">
			<li>${name}</li>
		</c:forEach>
	</ul>
	
	<h2>List&lt;String&gt;</h2>

	<ul>
		<c:forEach items="${list}" var="str">
			<li>${str}</li>
		</c:forEach>
	</ul>

	<h2>List&lt;Person&gt;</h2>
	<table id="tbl-person">
		<thead>
			<tr>
				<th>no</th>
				<th>name</th>
				<th>gender</th>
				<th>age</th>
				<th>married</th>
			</tr>
			<%-- varStatus는 변수 상태를 나타내는데, index 등을 볼 수 있다. --%>
			<%-- 0부터 시작하려면 index, 1부터 시작하려면 count 사용. --%>
			<c:forEach items="${personList}" var="pl" varStatus="vs">
			<tr>
				<td>${vs.count}</td>
				<td>${pl.name}</td>
				<td>
<%-- 					${pl.gender} --%>
<!-- 					(input:r[name=gender]#gender$+label[for=gender$])*2 -->
					<input type="radio" name="gender${vs.count}" id="gender${vs.count}*2-1" ${pl.gender eq '남'.charAt(0) ? 'checked' : ""} />
					<label for="gender${vs.count}*2-1">남</label>
					<input type="radio" name="gender${vs.count}" id="gender${vs.count}*2" ${pl.gender eq '여'.charAt(0) ? 'checked' : ""} />
					<label for="gender${vs.count}*2">여</label>
				</td>
				<td>${pl.age}</td>
				<td>
					<input type="checkbox"
						onclick="return false;" 
						${pl.married ? 'checked' : ""} />
<%-- 					${pl.married} --%>
				</td>
			</tr>
			</c:forEach>
		</thead>
	</table>

	<h2>Set</h2>
	
		<span>
			<%-- 콤마를 찍는 여러 방법 --%>
			<c:forEach items="${set}" var="num" varStatus="vs">
<%-- 				${num}<c:if test="${vs.count != set.size()}">, </c:if> --%>
<%-- 				${num}${vs.count != set.size() ? ', ' : ''} 	 --%>
<%-- 				${num}${not vs.last ? ',' : ''}					 --%>
					${num} ${vs.first} ${vs.last}
					<%-- first와 last는 현재 요소가 첫번째인지, 마지막인지 불린값을 제공 --%>
			</c:forEach>
		</span>
	
	<h2>Map</h2>
	<table id="tbl-map">
		<thead>
			<tr>
				<th>key</th>
				<th>value</th>
			</tr>		
		</thead>
		<tbody>
			<c:forEach items="${map}" var="entry">
			<tr>
				<td>${entry.key}</td>
				<td>${entry.value}</td>
				<%-- 키셋 이런거 안쓰고 겁나 간단하게 쓸 수 있다. --%>
			</tr>
			</c:forEach>
		</tbody>
	</table>

	<h2>c:forTokens</h2>
	<ul>
		<%-- delim은 구분자. delims이기 때문에 구분자 여러개 담아도 된다. --%>
		<c:forTokens items="${s}" delims=",." var="id">
		<li>${id}</li>
		</c:forTokens>
	</ul>


</body>
</html>