package ajax.json.gson;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.google.gson.Gson;

import member.manager.MemberManager;
import member.model.vo.Member;

/**
 * Servlet implementation class JsonInsertMemberServlet
 */
@WebServlet("/gson/insertMember")
public class GsonInsertMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			// 1. 사용자 입력값 처리
			// 기본
//			String name = request.getParameter("name");
//			String phone = request.getParameter("phone");
//			String profile = request.getParameter("profile");
//			Member member = new Member(name, phone, profile);
			
			// json 형태로 받아온 경우 (member=json문자열)
			String jsonStr = request.getParameter("member");
			System.out.println("jsonStr = " + jsonStr);
			
			// json문자열 -> java 객체
			Gson gson = new Gson();
			// 뒷 매개변수 기준에 해당하는 필드값이 있다면 거기에 맞춰서 json을 풀어줌
			Member member = gson.fromJson(jsonStr, Member.class);
			System.out.println("member = " + member);
			
			// 2. 업무 로직 : manager 객체의 list에 추가
			List<Member> list = MemberManager.getInstance().getList();
			list.add(member);
			System.out.println("list = " + list);
			
			// 3. 결과 처리 : 성공 1, 실패 0 출력
			response.getWriter().print(1);
		} catch(Exception e) {
			e.printStackTrace();
			response.getWriter().print(0);
		}
		
		
	}

}
