package admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.service.AdminService;

/**
 * Servlet implementation class AdminUpdateMemberRoleServlet
 */
@WebServlet("/admin/updateMemberRole")
public class AdminUpdateMemberRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 사용자 입력값  memberId | memberRole
		String memberId = request.getParameter("memberId");
		String memberRole = request.getParameter("memberRole");
		
		// 2. 업무로직 : service단의 updateMemberRole(memberId, memberRole)
		int result = new AdminService().updateMemberRole(memberId, memberRole);
		
		// 3. view 처리 : sendRedirect("/mvc/admin/memberList");
		// 정상적으로 변경되었습니다. | 실패했습니다.
		HttpSession session = request.getSession();
		if(result > 0) {
			session.setAttribute("msg", "정상적으로 변경되었습니다.");
		}
		else {			
			session.setAttribute("msg", "실패했습니다.");
		}
		response.sendRedirect(request.getContextPath() + "/admin/memberList");
		
	}

}
