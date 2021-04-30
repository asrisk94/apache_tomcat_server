<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.List"%>
<%@page import="member.model.vo.Member"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%--
	xml Extensible Markup Language
	사용자 정의 태그 문서 (태그 이름도 그렇고 다 내 마음대로 할 수 있다.)
	- 데이터 처리시에만 잘 파악하고 쓸 것
--%>
<%
	List<Member> list = (List<Member>)request.getAttribute("list");
%>
<members>
<% for(Member m : list) { %>
	<member>
		<name><%= m.getName() %></name>
		<phone><%= m.getPhone() %></phone>
		<profile><%= m.getProfile() %></profile>
<%-- 		<profile><img src='<%= request.getContextPath() %>/images/<%= m.getProfile() %>'></profile> --%>
	</member>
	<% } %>
</members>