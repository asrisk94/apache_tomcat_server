<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<%
	List<Member> list =	(List<Member>)request.getAttribute("list");	
%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 관리자용 admin.css link -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<style>
    div#search-container {margin:0 0 10px 0; padding:3px; background-color: rgba(0, 188, 212, 0.3);}
    div#search-memberId {display: inline-block;}
    div#search-memberName{display:none;}
    div#search-gender{display:none;}
</style>

<script>
	$(function() {
		
		// 검색 전 확인 작업
		
		// 폼들에 클래스 부여
		var $forms = $(".search-type > form");
		for(var i=0; i<$forms.length; i++) {
			$forms.eq(i).attr("class", "searchFrm");
		}
		var searchFrms = document.getElementsByClassName("searchFrm");
		
		// 폼마다 서브밋 이벤트핸들러 부여
		for(var i=0; i<searchFrms.length; i++) {
			searchFrms[i].onsubmit = function(e) {
				// 하위 값 찾음
				var $searchKeyword = $(this).find("[name=searchKeyword]");
				var $searchType = $(this).find("[name=searchType]");
								
				// 물어볼 텍스트 작문
				var keyword = null;
				var type = null;
				if($searchType.val() == 'memberId') { 
					type = "아이디";
					keyword = $searchKeyword.val();
				}
				else if($searchType.val() == 'memberName') {
					type = "이름";
					keyword = $searchKeyword.val();
				}
				// 성별은 키워드까지
				else if($searchType.val() == 'gender') {
					type = "성별";
					for(var i=0; i<$searchKeyword.length; i++) {
						
						if($searchKeyword.eq(i).prop("checked")) {
							keyword = $searchKeyword.eq(i).val()=="M" ? "남" : "여";
						}
					}
				}
				
				var bool = confirm("검색타입 : " + type + ", 검색키워드 : " + keyword + ", 진행할까요?");
				
				if(bool) {
					return true;
				}
				return false;
			}
		}
		
		
		
		// 검색타입 변경 이벤트핸들러
		$("#searchType").change(function() {
			var type = $(this).val();	// memberId | memberName | gender
			var $divSearchTypes = $(".search-type");
			$divSearchTypes
				.hide()
				.filter("#search-" + type)
				.css('display', 'inline-block');
		});
		
		
		// 회원 권한 변경 이벤트 핸들러
		$("select.member-role").change(function() {
			var memberRole = $(this).val();
			var memberId = $(this).data("member-id");	// data-member-id 깂 불러오고있음
			// console.log(memberId, memberRole);
			
			var bool = confirm("[" + memberId + "]회원의 권한을 [" 
								+ (memberRole == "<%= MemberService.USER_MEMBER_ROLE %>" ? "일반" : "관리자") 
								+ "](으)로 변경하시겠습니까?");
			
			if(!bool) {
				location.reload();
				return;
			}
			// GET 방식 사용 상황 : 요청 처리이후 DB에 변경 내역이 없는 경우. 	조회|검색
			// POST 방식 사용 상황 : 요청 처리이후 DB 변경내역이 있는 경우. 	추가|수정|삭제
			// 데이터 노출 자체가 문제가 될 수 있는 경우도 POST (로그인 등)
			var $frm = $("#memberRoleUpdateFrm");
			$frm.find("[name=memberId]").val(memberId);
			$frm.find("[name=memberRole]").val(memberRole);
			$frm.submit();
		});
		
	});
</script>

<form action="<%= request.getContextPath() %>/admin/updateMemberRole"
		id="memberRoleUpdateFrm"
		method="POST">
		<input type="hidden" name="memberId" />
		<input type="hidden" name="memberRole" />
</form>
<section id="memberList-container">
	<h2>회원관리</h2>
	
	 <div id="search-container">
        검색타입 : 
        <select id="searchType">
            <option value="memberId">아이디</option>		
            <option value="memberName">회원명</option>
            <option value="gender">성별</option>
        </select>
        <div id="search-memberId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="memberId"/>
                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요."/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        <div id="search-memberName" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="memberName"/>
                <input type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요."/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        <div id="search-gender" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="gender"/>
                <input type="radio" name="searchKeyword" value="M" checked> 남
                <input type="radio" name="searchKeyword" value="F"> 여
                <button type="submit">검색</button>
            </form>
        </div>
    </div>
    
	<table id="tbl-member">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>회원권한</th>
				<th>성별</th>
				<th>생년월일</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>취미</th>
				<th>가입일</th>
			</tr>
		</thead>
		<tbody>
		<% if(list == null || list.isEmpty()) { %>
			<%-- 조회된 결과가 없는 경우 --%>
			<tr>
				<td colspan="10" style="text-align:center;">
				조회된 결과가 없습니다.
				</td>
			</tr>
		<% } else {
			for(Member m : list) { %>
			<%-- 조회된 결과가 있는 경우 --%>
			<tr>
				<td><%= m.getMemberId() %></td>
				<td><%= m.getMemberName() %></td>
				<td>
					<%-- select.member-role>option*2 --%>
					<%-- date속성 : 태그에 data를 직접 저장/불러오기 기능 (data-~~) --%>
					<select class="member-role" data-member-id="<%= m.getMemberId() %>">
						<option value="<%= MemberService.USER_MEMBER_ROLE %>" <%= MemberService.USER_MEMBER_ROLE.equals(m.getMemberRole()) ? "selected" : "" %>>일반</option>
						<option value="<%= MemberService.ADMIN_MEMBER_ROLE %>" <%= MemberService.ADMIN_MEMBER_ROLE.equals(m.getMemberRole()) ? "selected" : "" %>>관리자</option>
					</select>
				</td>
				<td>
					<%= "M".equals(m.getGender()) ? "남" : ("F".equals(m.getGender()) ? "여" : "") %>
				</td>
				<td><%= m.getBirthDay() != null ? m.getBirthDay() : "" %></td>
				<td><%= m.getEmail() != null ? m.getEmail() : "" %></td>
				<td><%= m.getPhone() %></td>
				<td><%= m.getAddress() != null ? m.getAddress() : "" %></td>
				<td><%= m.getHobby() != null ? m.getHobby() : "" %></td>
				<td><%= m.getEnrollDate() %></td>
			</tr>
			<% } 
			} %>
		</tbody>
	</table>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
