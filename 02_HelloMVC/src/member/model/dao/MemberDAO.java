package member.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import member.model.vo.Member;
import static common.JDBCTemplate.close;

/**
 * 	DAO Data Access Object
 * 	
 * 	PreparedStatement 객체 생성 (쿼리필요)
 *	쿼리 실행 및 결과 Service단으로 리턴
 *
 *	 - DML : int 리턴
 *	 - DQL : ResultSet 리턴 -> 자바객체로 데이터 이전
 *
 *	자원 반납
 */

public class MemberDAO {
	private Properties prop = new Properties();
	
	
	public MemberDAO() {
		String fileName = "/sql/member/member-query.properties";
		String path = MemberDAO.class.getResource(fileName).getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("path@MemberDAO = " + path);
		System.out.println("prop@MemberDAO = " + prop);
	}
	
	public Member selectOne(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectOne");
		Member member = null;
		
		// 1. PreparedStatement 객체생성 (미완성쿼리 대입)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			
			// 2. Statement 실행 및 결과처리 : ResultSet -> Member
			rset = pstmt.executeQuery();
			while(rset.next()) {
				member = new Member();
				member.setMemberId(rset.getString("member_id"));
				member.setPassword(rset.getString("password"));
				member.setMemberName(rset.getString("member_name"));
				member.setMemberRole(rset.getString("member_role"));
				member.setGender(rset.getString("gender"));
				member.setBirthDay(rset.getDate("birthday"));
				member.setEmail(rset.getString("email"));
				member.setPhone(rset.getString("phone"));
				member.setAddress(rset.getString("address"));
				member.setHobby(rset.getString("hobby"));
				member.setEnrollDate(rset.getDate("enroll_date"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 3. 자원반납(ResultSet, PreparedStatement)
			close(rset);
			close(pstmt);
		}
		
		return member;
	}

	public int updateOne(Connection conn, Member member) {
		
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateOne");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getMemberName());
			pstmt.setString(4, "U");
			pstmt.setString(5, member.getGender());
			pstmt.setDate(6, member.getBirthDay());
			pstmt.setString(7, member.getEmail());
			pstmt.setString(8, member.getPhone());
			pstmt.setString(9, member.getAddress());
			pstmt.setString(10, member.getHobby());
			pstmt.setDate(11, member.getEnrollDate());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	
	
}
