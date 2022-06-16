package test_member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import test_db.JdbcUtil;

public class MemberDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	// 회원가입 처리를 위한 insertCount()메서드 생성
	public int insertCount(MemberDTO memberDTO) {
		int insertCount = 0;
		con = JdbcUtil.getConnection();
		try {
			String sql = "INSERT INTO test_member VALUES (?,?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getNickname());
			pstmt.setString(2, memberDTO.getId());
			pstmt.setString(3, memberDTO.getPass());
			pstmt.setString(4, memberDTO.getName());
			pstmt.setString(5, memberDTO.getPhone());
			pstmt.setString(6, memberDTO.getPostcode());
			pstmt.setString(7, memberDTO.getAddress());
			pstmt.setString(8, memberDTO.getGender());
			pstmt.setString(9, memberDTO.getJob());
			pstmt.setString(10, memberDTO.getEmail());
			
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return insertCount;
	}
	
	// 로그인 확인을 위한 checkUser()메서드 작성
	public boolean checkUser(MemberDTO memberDTO) {
		boolean isLoginSuccess = false;
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM test_member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getId());
			pstmt.setString(2, memberDTO.getPass());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				isLoginSuccess = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return isLoginSuccess;
	}
	
	// 닉넴을 가져다 쓰기 위해서 selectNickname() 작성
	public String selectNickname(MemberDTO memberDTO) {
		String selectNickname = "";
		con = JdbcUtil.getConnection();
		try {
			String sql = "SELECT * FROM test_member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getId());
			pstmt.setString(2, memberDTO.getPass());
			
			rs = pstmt.executeQuery();
			
			// 조회된 결과값의 첫번째 값(1번 인덱스)을 selectNickname 변수에 저장
			if(rs.next()) {
				selectNickname = rs.getString(1);
			}
			
			System.out.println(selectNickname);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			JdbcUtil.close(rs);
		}
		
		return selectNickname;
	}
	
	// 아이디 중복 확인 메서드 isDuplicate() 작성
	public boolean isDuplicate(String id) {
		boolean isDuplicate = false;
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM test_member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				isDuplicate = true;
			}
			System.out.println(id);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return isDuplicate;
	}
	
	// 회원 상세 정보 창을 출력하기 위해서 필요한 데이터 저장 후 출력을 위한 selectMemberInfo()메서드 작성
	public MemberDTO selectMemberInfo(String id) {
		MemberDTO memberDTO = null;
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM test_member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberDTO = new MemberDTO();
				memberDTO.setNickname(rs.getString("nickname"));
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setJob(rs.getString("job"));
				memberDTO.setGender(rs.getString("gender"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setPostcode(rs.getString("postcode"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setDate(rs.getDate("join_date"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return memberDTO;
	}
	
	//회원 정보 수정을 위해서 updateMember()메서드 작업
	public int updateMember(MemberDTO memberDTO) {
		int updateCount = 0;
		
		con = JdbcUtil.getConnection();
		
		try {
			// 단, 패스워드값이 입력되어 있을 경우 패스워드도 수정 아닐 경우는 패스워드 제외하고 변경
			if(memberDTO.getPass().equals("")) { // 패스워드 미입력시
				// sql 문법이 헷갈리니 잘 외워두자!!!
				// member테이블의 아이디가 일치하는 레코드 수정
				String sql = "UPDATE member SET phone=?,postcode=?,address=?,gender=?,job=?,email=? WHERE id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, memberDTO.getPhone());
				pstmt.setString(2, memberDTO.getPostcode());
				pstmt.setString(3, memberDTO.getAddress());
				pstmt.setString(4, memberDTO.getGender());
				pstmt.setString(5, memberDTO.getJob());
				pstmt.setString(6, memberDTO.getEmail());
				pstmt.setString(7, memberDTO.getId());
			} else { // 패스워드 입력시
				String sql = "UPDATE member SET pass=?,phone=?,postcode=?,address=?,gender=?,job=?,email=? WHERE id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, memberDTO.getPass());
				pstmt.setString(2, memberDTO.getPhone());
				pstmt.setString(3, memberDTO.getPostcode());
				pstmt.setString(4, memberDTO.getAddress());
				pstmt.setString(5, memberDTO.getGender());
				pstmt.setString(6, memberDTO.getJob());
				pstmt.setString(7, memberDTO.getEmail());
				pstmt.setString(8, memberDTO.getId());
			}
			
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return updateCount;
	}
	
	public MemberDTO selectMemberPass(String nickname) {
		MemberDTO memberDTO = null;
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM test_member WHERE nickname=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nickname);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberDTO = new MemberDTO();
				memberDTO.setNickname(rs.getString("nickname"));
				memberDTO.setPass(rs.getString("pass"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return memberDTO;
	}
	
}
