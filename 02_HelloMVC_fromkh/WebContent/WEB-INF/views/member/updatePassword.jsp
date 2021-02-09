<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<script>
		window.onload = function() {
			
			// 제이쿼리 아닌 js식 웹표준에 맞는 선택자
			var Arr = document.getElementsByName("updatePwdFrm");
			var updatePwdFrm = Arr[0];
			
			// 서브밋에 유효성 검사 연결
			updatePwdFrm.onsubmit = function(e) {
				var newPassword = document.getElementById("newPassword");
				var passwordCheck = document.getElementById("passwordCheck");
			
				// 일치하지 않으면 서브밋 발동하지 않음.
				if(newPassword.value != passwordCheck.value) {
					alert("새로운 비밀번호가 일치하지 않습니다.");
					return false;
				}
				return true;
			}
			
		}	
	</script>

	<section id=enroll-container>
	<h2>비밀번호 변경</h2>
		<form 
			name="updatePwdFrm" 
			action="<%=request.getContextPath()%>/member/updatePassword" 
			method="post" >
			<table>
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name="password" id="password" required></td>
				</tr>
				<tr>
					<th>변경할 비밀번호</th>
					<td>
						<input type="password" name="newPassword" id="newPassword" required>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>	
						<input type="password" id="passwordCheck" required><br>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="submit"  value="변경" />
					</td>
				</tr>
			</table>
			<input type="hidden" name="memberId"/>
		</form>
	</section>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>