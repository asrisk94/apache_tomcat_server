package common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.vo.Member;

/**
 * Servlet Filter implementation class MemberAuthFilter
 */
@WebFilter({ "/member/memberView"})
public class MemberAuthFilter implements Filter {

    /**
     * Default constructor. 
     */
    public MemberAuthFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		HttpServletRequest httpReq = (HttpServletRequest)request;
		HttpSession session = httpReq.getSession();
		HttpServletResponse httpResp = (HttpServletResponse)response;
		
		Member member = (Member)session.getAttribute("memberLoggedIn");
		
		String memberId = httpReq.getParameter("memberId");
		
		if(!(member != null 
				&& memberId != null
				&& member.getMemberId().equals(memberId))) {
			session.setAttribute("msg", "해당 아이디에 접속한 상태로 시도해주세요.");
			httpResp.sendRedirect(httpReq.getContextPath() + "/member/memberView?memberId=" + member.getMemberId());
			return;			
		}
		
		chain.doFilter(request, response);	// 서블렛 작업 전후 순서를 구분해주는 메소드
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
