package admin.model.service;

import java.sql.Connection;
import java.util.List;

import admin.model.dao.AdminDao;
import member.model.vo.Member;
import static common.JDBCTemplate.*;

public class AdminService {

	private AdminDao adminDao = new AdminDao();
	
	public List<Member> selectList() {
		
		Connection conn = getConnection();
		
		List<Member> list = adminDao.selectList(conn);
		
		close(conn);
		
		return list;
	}

	public int updateMemberRole(String memberId, String memberRole) {
		
		Connection conn = getConnection();
		
		int result = adminDao.updateMemberRole(conn, memberId, memberRole);
		
		close(conn);
		
		return result;
	}

	public List<Member> selectMembersBy(String searchType, String searchKeyword) {

		Connection conn = getConnection();
		
		List<Member> list = adminDao.selectMembersBy(conn, searchType, searchKeyword);
		
		close(conn);
		
		return list;
	}
	
	

}
