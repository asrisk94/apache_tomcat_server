package member.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberLoginServlet
 * 
 * @WebServlet : web.xml에 servlet, servlet-mapping 태그 등록을 대신해주는 annotation
 */
@WebServlet(urlPatterns={"/member/login"})	// @WebServlet("/member/login") 생략하고 이렇게 가능
public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		
		
		// 2. 사용자 입력값 처리
		String memberId = request.getParameter("memberId");
		String password = request.getParameter("password");
		String saveId = request.getParameter("saveId");
		
//		System.out.println("memberId@servlet = " + memberId);
//		System.out.println("password@servlet = " + password);
		System.out.println("saveId@servlet = " + saveId);	// 체크시 on, 아니면 null 반환
		
		
		
		// 3. 업무로직 : 사용장입력 아이디/비번이 DB에 저장된 그것과 일치 여부 판단
		// 아이디로 member객체를 조회
		// 		비밀번호가 일치하는 경우
		// 		비밀번호가 일치하지 않는 경우
		// member 객체가 존재하지 않는 경우 : 아이디 오류
		Member member = new MemberService().selectOne(memberId);
		
//		System.out.println("member@servlet = " + member);
		
		
		
		// 로그인 성공
		if(member != null && password.equals(member.getPassword())) {
//			request.setAttribute("msg", "로그인 성공");		
			
			// jsp에서 로그인한 사용자 정보를 출력하기 위해 member객체를 request에 저장
//			request.setAttribute("memberLoggedIn", member);
			
			// 로그인 유지되도록 request아니라 session 객체에 로그인한 사용자정보 기록
			// create 여부 (기본값은 true) : session객체 존재하면 해당객체 리턴, 아니면 생성 후 리턴
			HttpSession session = request.getSession(true);
			session.setAttribute("memberLoggedIn", member);
			
			// 세션관련 메소드
//			System.out.println(session.getId());							// JSSESSIONID
//			System.out.println(new Date(session.getCreationTime()));		// 만들어진 시간
//			System.out.println(new Date(session.getLastAccessedTime()));	// 마지막 요청시간
			
			// web.xml에 쓴 타임아웃보다 우선순위. 
			session.setMaxInactiveInterval(30);	// 초단위 세션만료
			
			
			
			// saveId 쿠키설정
			Cookie c = new Cookie("saveId", memberId);
			
			// 쿠키 전송 디렉토리 설정.
			// (client -> server)요청이 /mvc 포함이면 쿠키 보냄. (/mvc   /mvc/member   /mvc/member/login 다포함)
			c.setPath(request.getContextPath());
						
			// saveId 체크한 경우
			if(saveId != null) {
				
				// 유효기간 설정(초단위)
				c.setMaxAge(7 * 24 * 60 * 60);	// client(브라우저)에서 쿠키를 보관할 시간
			}
			// saveId 체크 안한 경우 : 브라우저 쿠키 삭제
			else {
				c.setMaxAge(0);	// 0초. 즉시삭제됨.
			}
			System.out.println("생성한 쿠키 : " + c);
			response.addCookie(c);	// 쿠키를 담아 브라우저로 돌려보냄 (삭제되었든 아니든)
			
			// 4. redirection 처리 : 요청 url을 변경
			// 주어진 주소 (location)로 클라이언트에게 다시 요청하라는 응답
			response.sendRedirect(request.getContextPath());
			// 로그인 url이 남아있기 때문에 새로고침할 때마다 계속 로그인 요청이 들어감.
			// 이를 방지하기 위해 리디렉트로 기본 url로 수정해줌.
			// DML을 쓸 때에도 마찬가지. 계속 신호 넣으면 계속 추가될 수도 있기 때문.
			
		}	// 로그인성공 if문
		
		// 로그인 실패시
		else {
			request.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			request.setAttribute("loc", request.getContextPath());
			// 4. view단 처리 (jsp)
			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
		
	}

}
