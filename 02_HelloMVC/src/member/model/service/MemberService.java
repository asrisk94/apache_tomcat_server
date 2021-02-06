package member.model.service;

import member.model.dao.MemberDAO;
import member.model.vo.Member;
import static common.JDBCTemplate.*;

import java.sql.Connection;

/**
 * 
 * 	Connection 객체 생성
 * 	Dao에 업무로직 하달
 *	트랜잭션 처리
 *	자원반납
 */
public class MemberService {
	
	private MemberDAO memberDAO = new MemberDAO();

	// 로그인용 1명 조회
	public Member selectOne(String memberId) {
		
		// 1. Connection 객체 생성
		Connection conn = getConnection();
		// 2. DAO 요청
		Member member = memberDAO.selectOne(conn, memberId);
		// 3. 트랜잭션 관리 (DML만)
		
		// 4. 자원반납
		close(conn);
		
		return member;
	}

	public int updateOne(Member member) {
		
		Connection conn = getConnection();
		
		int result = memberDAO.updateOne(conn, member);
		
		commit(conn);
		
		close(conn);
		
		return result;
	}
}
