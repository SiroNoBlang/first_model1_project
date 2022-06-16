package test_board;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// 특정 클래스의 static메서드를 클래스명 없이 접근하기 위한 import문
// static메서드를 지정하기 위한 문법이기 때문에 메서드까지 입력해줘야한다.
import static test_db.JdbcUtil.*;

public class BoardDAO {
	// 전역변수로 사용하여 모든 함수에서 사용할 수 있도록 한다.
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	// 글쓰기 작업을 수행하는 함수 insertBoard()
	public int insertBoard(BoardBean boardBean) {
		int insertCount = 0;
		int num = 1; // 새 글 번호의 초기값
		con = getConnection();
		
		try {
			// 현재 게시물들 중 가장 큰 num값을 조회하여 조회 결과가 없을 경우 num을 1로 설정
			String sql = "SELECT MAX(num) FROM test_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 등록된 값이 하나라도 있을 경우에는 1row만 조회되기 때문에
				num = rs.getInt(1) + 1;
			}
			
			// 글쓰기 작업 수행(글번호는 num 변수값, 작성일은 now() 함수, 조회수는 0으로 출력
			sql = "INSERT INTO test_board VALUES (?,?,?,?,?,now(),0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardBean.getNickname());
			pstmt.setString(3, boardBean.getPass());
			pstmt.setString(4, boardBean.getSubject());
			pstmt.setString(5, boardBean.getContent());
			
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return insertCount;
	}
	
	public ArrayList<BoardBean> selectBoardList(int pageNum, int listLimit){
		ArrayList<BoardBean> boardList = null;
		
		con = getConnection();
		
		// 현재 페이지에서 불러올 목록(레코드)의 첫번째(시작) 행번호 계산
		int startRow = (pageNum - 1) * listLimit;
		
		try {
			String sql = "SELECT * FROM test_board ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			
			rs = pstmt.executeQuery();
			
			boardList = new ArrayList<BoardBean>();
			
			while(rs.next()) {
				BoardBean boardBean = new BoardBean();
				boardBean.setNum(rs.getInt("num"));
				boardBean.setNickname(rs.getString("nickname"));
				boardBean.setPass(rs.getString("pass"));
				boardBean.setSubject(rs.getString("subject"));
				boardBean.setContent(rs.getString("content"));
				boardBean.setCreate_date(rs.getDate("create_date"));
				boardBean.setReadcount(rs.getInt("readcount"));
				
				// boardBean에 저장한 데이터를 ArrayList에 넣어서 배열 정리.
				boardList.add(boardBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return boardList;
	}
	
	//오류 없이 작성은 가능하나 한번 더 문법에 대비해서 기억해두자!
	// 전체 게시물의 수를 알기 위해서 필요한 selectListCount()
	public int selectListCount() {
		int listCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT COUNT(num) FROM test_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 조회된 결과값의 첫번째 값(1번 인덱스)을 listCount 변수에 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return listCount;
	}
	
	// 게시물 상세 내용 조회 selectBoard()메서드 작성
	public BoardBean selectBoard(int num) {
		BoardBean board = null;
		con = getConnection();
		
		try {
			String sql = "SELECT * FROM test_board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				board = new BoardBean();
				board.setNum(rs.getInt("num"));
				board.setNickname(rs.getString("nickname"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setCreate_date(rs.getDate("create_date"));
				board.setReadcount(rs.getInt("readCount"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return board;
	}
	
	// 전달받은 글번호가 있는 게시물 조회수 증가를 위한 updateReadcount()메서드
	public void updateReadcount(int num) {
		con = getConnection();
		
		try {
			String sql = "UPDATE test_board SET readcount=readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		
	}
	
	// 게시물 수정을 위한 updateBoard()메서드 작업
	public int updateBoard(BoardBean boardBean) {
		int updateCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT pass FROM test_board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardBean.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// DB에 있는 패스워드와 전달받은 패스워드가 일치하는지 확인하는 구문
				if(rs.getString("pass").equals(boardBean.getPass())) {
					sql = "UPDATE test_board SET subject=?,content=? WHERE num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, boardBean.getSubject());
					pstmt.setString(2, boardBean.getContent());
					pstmt.setInt(3, boardBean.getNum());
					
					updateCount = pstmt.executeUpdate();
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return updateCount;
	}
	
	// 게시물 삭제에 필요한 deleteBoard()메서드 작업
	public int deleteBoard(int num, String pass) {
		int deleteCount = 0;
		con = getConnection();
		
		try {
			String sql = "SELECT * FROM test_board WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "DELETE FROM test_board WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				deleteCount = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return deleteCount;
	}
	
	// 조회수가 많은 순으로 4개를 조회 후 리턴하는 selectRecentBoardList()메서드 작성
	public ArrayList<BoardBean> selectRecentBoardList(){
		ArrayList<BoardBean> boardList = null;
		con = getConnection();
		
		try {
			// 출력되어서 나오는 갯수를 딱히 변경할 이유가 없어서 따로 변수를 두진 않았음.
			String sql = "SELECT * FROM test_board ORDER BY readcount DESC LIMIT 4";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			boardList = new ArrayList<BoardBean>();
			while(rs.next()) {
				// 조회되서 나올 정보가 글번호, 제목, 작성자, 조회수 출력을 위한 데이터 저장
				BoardBean boardBean = new BoardBean();
				boardBean.setNum(rs.getInt("num"));
				boardBean.setSubject(rs.getString("subject"));
				boardBean.setNickname(rs.getString("nickname"));
				boardBean.setReadcount(rs.getInt("readcount"));
				
				// ArrayList객체에 필요한 boardBean의 정보를 저장
				boardList.add(boardBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return boardList;
	}

	// 검색어에 해당하는 게시물 목록 갯수를 조회하는 selectSearchListCount() 메서드 작성
	public int selectSearchListCount(String search, String searchType) {
		int listCount = 0;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(num) FROM test_board WHERE " + searchType + " LIKE ?";
			pstmt = con.prepareStatement(sql);
			// 검색어 생성을 위해서는 검색 키워드 앞뒤로 "%" 문자열 결합 필요
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			
			// 조회된 결과값의 첫번째 값(1번 인덱스)을 listCount 변수에 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return listCount;
	}
	
	// 검색어에 해당하는 게시물 목록 조회작업을 수행하는 selectSearchBoardList() 메서드 작업
	public ArrayList<BoardBean> selectSearchBoardList(int pageNum, int listLimit, String search, String searchType) {
		ArrayList<BoardBean> boardList = null;
		
		try {
			// 1 & 2단계
			con = getConnection();
			
			// 현재 페이지에서 불러올 목록(레코드)의 첫번째(시작) 행번호 계산
			int startRow = (pageNum - 1) * listLimit;
			
			// 검색어에 해당하는 board 테이블의 모든 레코드 조회(조회수 기준으로 내림차순 정렬)
			String sql = "SELECT * FROM test_board WHERE " + searchType + " LIKE ? ORDER BY num DESC LIMIT ?,?";
			// => 목록갯수는 파라미터로 전달받은 listLimit 값 사용
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList<BoardBean> 객체 생성 (반복문 전에 미리 실행할 것)
			boardList = new ArrayList<BoardBean>();
			
			while(rs.next()) {
				// 1개 레코드를 저장할 BoardBean 객체 생성
				BoardBean board = new BoardBean();
				// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
				board.setNum(rs.getInt("num"));
				board.setNickname(rs.getString("nickname"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setCreate_date(rs.getDate("create_date"));
				board.setReadcount(rs.getInt("readcount"));
				
				// 전체 레코드를 저장하는 ArrayList 객체에 1개 레코드가 저장된 BoardBean 객체 추가
				boardList.add(board);
			}
			
//				System.out.println(boardList);
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectBoardList()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return boardList;
	}
	
}

	

	