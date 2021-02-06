package member.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MeberEnrollServlet
 */
@WebServlet("/member/memberEnroll")
public class MeberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 *	회원가입 폼을 제공
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request
			.getRequestDispatcher("/WEB-INF/views/member/memberEnroll.jsp")
			.forward(request, response);
	}

	/**
	 *	폼제출 : 회원가입 처리
	 *
	 *	1. 회원가입 성공/실패여부를 사용자에게 경고창으로 알림할 것.
	 *	2. 끝나고 인덱스페이지로 이동할 것.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 인코딩 처리
		request.setCharacterEncoding("utf-8");

		
		
		// 사용자 입력값 처리
		String memberId = request.getParameter("memberId");
		String password = request.getParameter("password");
		String memberName = request.getParameter("memberName");
		
		Date birthDay = null;
		String bdStr = request.getParameter("birthDay");
		if(!bdStr.equals("")) {
			birthDay = Date.valueOf(bdStr);			
		}
		
		String email  = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String gender = request.getParameter("gender");
		
		String[] hobbyArr = request.getParameterValues("hobby");
		String hobby = Arrays.toString(hobbyArr);
		
		// sql 데이트 현재시간 객체 만들기.
		Date enrollDate = new java.sql.Date(new java.util.Date().getTime());

		
		
		// DB 등록
		Member member = new Member(memberId, password, memberName, "U", gender, birthDay,
				email, phone, address, hobby, enrollDate);
		
		int result = new MemberService().updateOne(member);
		
		
		
		// 처리
		RequestDispatcher rd = null;
		if(result > 0) {
			request.setAttribute("msg", "회원가입에 성공했습니다.");
			request.setAttribute("loc", request.getContextPath());
			System.out.println(request.getContextPath());
			rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
		else {
			request.setAttribute("msg", "회원가입에 실패했습니다.");
//			request.setAttribute("loc", (request.getContextPath()+"/member/memberEnroll.jsp"));
//			System.out.println(request.getContextPath());
			rd = request.getRequestDispatcher("/WEB-INF/views/member/memberEnroll.jsp");
			rd.forward(request, response);
//			response.sendRedirect(request.getContextPath());
		}
		
	}	// doPost 메소드
	

}
