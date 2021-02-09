package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.util.MvcUtils;
import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdatePasswordServlet
 */
@WebServlet("/member/updatePassword")
public class MemberUpdatePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 로그인 중인 아이디
		HttpSession session = request.getSession();
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		String memberLoggedInId = memberLoggedIn.getMemberId();
		
		// 주소창에 입력한 아이디
		String memberId = request.getParameter("memberId");
		
		// 정보수정 비밀번호
		String password = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");
		
		RequestDispatcher rd = null;
		
		
		
		// 비밀번호는 수정칸에서만 칠 수 있다.
		// 고로 패스워드가 빈 상태로 요청이 왔다면 처음 수정창으로의 접속을 시도하고 있다는 뜻이다.
		
		// 1. 처음 접속이면서   2. 로그인 아이디와 요청 아이디가 다르다면 / 거름
		if( (password == null || "".equals(password))
			&& (memberLoggedInId == null || !memberLoggedInId.equals(memberId))) {
			
			session.setAttribute("msg", "유효하지 않은 접근입니다.");
			response.sendRedirect(request.getContextPath());
		}		
		// 1. 처음 접속이면서   2. 로그인 아이디와 요청 아이디가 같다면 / jsp 연결
		else if((password == null || "".equals(password))
				&& (memberLoggedInId != null && memberLoggedInId.equals(memberId))) {
			
			rd = request.getRequestDispatcher("/WEB-INF/views/member/updatePassword.jsp");
			rd.forward(request, response);
		}
		
		// 1. 첫 접속이 아니라면 수정작업 진행
		else if(!(password == null || "".equals(password))) {
			
			// 입력한 password의 암호화 진행
			String enPassword = MvcUtils.getEncryptedPassword(password);
			
			// 로그인 패스워드와 입력한 패스워드가 다를경우
			if(!memberLoggedIn.getPassword().equals(enPassword)) {
				session.setAttribute("msg", "기존 비밀번호 입력이 틀렸습니다.");
				rd = request.getRequestDispatcher("/WEB-INF/views/member/updatePassword.jsp");
				rd.forward(request, response);
			}
			// 입력한 패스워드와 로그인한 패스워드가 같을 경우
			else if(memberLoggedIn.getPassword().equals(enPassword)) {
				
				// 새 패스워드 암호화 진행 후 JDBC 실행
				String enNewPassword = MvcUtils.getEncryptedPassword(newPassword);
				int result = new MemberService().updatePassword(memberLoggedIn.getMemberId(), enNewPassword);
				
				if(result > 0) {
					// 성공 메시지 저장
					session.setAttribute("msg", "성공적으로 수정되었습니다.");
					// 메시지 출력 후 로그아웃 창으로 이동하기 위헤 로케이션값 저장
					request.setAttribute("loc", request.getContextPath() + "/member/logout");
					// 로케이션 값을 쓰기 위해 포워딩
					rd = request.getRequestDispatcher("/index.jsp");
					rd.forward(request, response);
				}
				else {
					session.setAttribute("msg", "변경에 실패했습니다.");
					response.sendRedirect(request.getContextPath());
				}
				
			}
			else {
				session.setAttribute("msg", "유효하지 않은 입력입니다.");
				rd = request.getRequestDispatcher("/WEB-INF/views/member/updatePassword.jsp");
				rd.forward(request, response);
			}
			
		}
		
		// 그 외에는 유효하지 않음
		else {
			session.setAttribute("msg", "유효하지 않은 접근입니다.");
			response.sendRedirect(request.getContextPath());
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
