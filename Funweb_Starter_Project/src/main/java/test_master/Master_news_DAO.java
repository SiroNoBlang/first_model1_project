package test_master;

import static test_db.JdbcUtil.close;
import static test_db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import test_db.JdbcUtil;

public class Master_news_DAO {
	// 전역변수로 사용하여 모든 함수에서 사용할 수 있도록 한다.
		Connection con;
		PreparedStatement pstmt;
		ResultSet rs;
		
		// 글쓰기 작업을 수행하는 함수 insertBoard()
		public int insertNews(Master_news_DTO news_DTO) {
			int insertCount = 0;
			int num = 1; // 새 글 번호의 초기값
			con = getConnection();
			
			try {
				// 현재 게시물들 중 가장 큰 num값을 조회하여 조회 결과가 없을 경우 num을 1로 설정
				String sql = "SELECT MAX(num) FROM test_master_news";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) { // 등록된 값이 하나라도 있을 경우에는 1row만 조회되기 때문에
					num = rs.getInt(1) + 1;
				}
				
				// 글쓰기 작업 수행(글번호는 num 변수값, 작성일은 now() 함수, 조회수는 0으로 출력
				sql = "INSERT INTO test_master_news VALUES (?,?,?,?,?,now(),0)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, news_DTO.getNickname());
				pstmt.setString(3, news_DTO.getPass());
				pstmt.setString(4, news_DTO.getSubject());
				pstmt.setString(5, news_DTO.getContent());
				
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
		
		public ArrayList<Master_news_DTO> selectNewsList(int pageNum, int listLimit){
			ArrayList<Master_news_DTO> newsList = null;
			
			con = getConnection();
			
			// 현재 페이지에서 불러올 목록(레코드)의 첫번째(시작) 행번호 계산
			int startRow = (pageNum - 1) * listLimit;
			
			try {
				String sql = "SELECT * FROM test_master_news ORDER BY num DESC LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, listLimit);
				
				rs = pstmt.executeQuery();
				
				newsList = new ArrayList<Master_news_DTO>();
				
				while(rs.next()) {
					Master_news_DTO news_DTO = new Master_news_DTO();
					news_DTO.setNum(rs.getInt("num"));
					news_DTO.setPass(rs.getString("pass"));
					news_DTO.setSubject(rs.getString("subject"));
					news_DTO.setContent(rs.getString("content"));
					news_DTO.setCreate_date(rs.getDate("create_date"));
					news_DTO.setReadcount(rs.getInt("readcount"));
					
					// boardBean에 저장한 데이터를 ArrayList에 넣어서 배열 정리.
					newsList.add(news_DTO);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
				close(con);
			}
			
			return newsList;
		}
		
		//오류 없이 작성은 가능하나 한번 더 문법에 대비해서 기억해두자!
		// 전체 게시물의 수를 알기 위해서 필요한 selectListCount()
		public int selectNewsListCount() {
			int newsListCount = 0;
			con = getConnection();
			try {
				String sql = "SELECT COUNT(num) FROM test_master_news";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				// 조회된 결과값의 첫번째 값(1번 인덱스)을 listCount 변수에 저장
				if(rs.next()) {
					newsListCount = rs.getInt(1);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
				close(con);
			}
			
			return newsListCount;
		}
		
		// 게시물 상세 내용 조회 selectBoard()메서드 작성
		public Master_news_DTO selectNews(int num) {
			Master_news_DTO news_DTO = null;
			con = getConnection();
			
			try {
				String sql = "SELECT * FROM test_master_news WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					news_DTO = new Master_news_DTO();
					news_DTO.setNum(rs.getInt("num"));
					news_DTO.setNickname(rs.getString("nickname"));
					news_DTO.setPass(rs.getString("pass"));
					news_DTO.setSubject(rs.getString("subject"));
					news_DTO.setContent(rs.getString("content"));
					news_DTO.setCreate_date(rs.getDate("create_date"));
					news_DTO.setReadcount(rs.getInt("readCount"));
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
				close(con);
			}
			
			return news_DTO;
		}
		
		// 전달받은 글번호가 있는 게시물 조회수 증가를 위한 updateReadcount()메서드
		public void updateReadcount(int num) {
			con = getConnection();
			
			try {
				String sql = "UPDATE test_master_news SET readcount=readcount+1 WHERE num=?";
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
		public int updateNews(Master_news_DTO news_DTO) {
			int updateCount = 0;
			con = getConnection();
			try {
				String sql = "SELECT pass FROM test_master_news WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, news_DTO.getNum());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					// DB에 있는 패스워드와 전달받은 패스워드가 일치하는지 확인하는 구문
					if(rs.getString("pass").equals(news_DTO.getPass())) {
						sql = "UPDATE test_master_news SET subject=?,content=? WHERE num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, news_DTO.getSubject());
						pstmt.setString(2, news_DTO.getContent());
						pstmt.setInt(3, news_DTO.getNum());
						
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
		public int deleteNews(int num, String pass) {
			int deleteCount = 0;
			con = getConnection();
			
			try {
				String sql = "SELECT * FROM test_master_news WHERE num=? AND pass=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, pass);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					sql = "DELETE FROM test_master_news WHERE num=?";
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
		public ArrayList<Master_news_DTO> selectRecentNewsList(){
			ArrayList<Master_news_DTO> newsList = null;
			con = getConnection();
			
			try {
				// 출력되어서 나오는 갯수를 딱히 변경할 이유가 없어서 따로 변수를 두진 않았음.
				String sql = "SELECT * FROM test_master_news ORDER BY readcount DESC LIMIT 4";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				newsList = new ArrayList<Master_news_DTO>();
				while(rs.next()) {
					// 조회되서 나올 정보가 글번호, 제목, 작성자, 조회수 출력을 위한 데이터 저장
					Master_news_DTO news_DTO = new Master_news_DTO();
					news_DTO.setNum(rs.getInt("num"));
					news_DTO.setSubject(rs.getString("subject"));
					news_DTO.setNickname(rs.getString("nickname"));
					news_DTO.setReadcount(rs.getInt("readcount"));
					
					// ArrayList객체에 필요한 boardBean의 정보를 저장
					newsList.add(news_DTO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
				close(con);
			}
			
			return newsList;
		}

		// 검색어에 해당하는 게시물 목록 갯수를 조회하는 selectSearchListCount() 메서드 작성
		public int selectSearchListCount(String search, String searchType) {
			int listCount = 0;
			
			try {
				con = getConnection();
				
				String sql = "SELECT COUNT(num) FROM test_master_news WHERE " + searchType + " LIKE ?";
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
		public ArrayList<Master_news_DTO> selectSearchNewsList(int pageNum, int listLimit, String search, String searchType) {
			ArrayList<Master_news_DTO> newsList = null;
			
			try {
				// 1 & 2단계
				con = getConnection();
				
				// 현재 페이지에서 불러올 목록(레코드)의 첫번째(시작) 행번호 계산
				int startRow = (pageNum - 1) * listLimit;
				
				// 검색어에 해당하는 board 테이블의 모든 레코드 조회(조회수 기준으로 내림차순 정렬)
				String sql = "SELECT * FROM test_master_news WHERE " + searchType + " LIKE ? ORDER BY num DESC LIMIT ?,?";
				// => 목록갯수는 파라미터로 전달받은 listLimit 값 사용
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, listLimit);
				
				rs = pstmt.executeQuery();
				
				// 전체 레코드를 저장할 ArrayList<BoardBean> 객체 생성 (반복문 전에 미리 실행할 것)
				newsList = new ArrayList<Master_news_DTO>();
				
				while(rs.next()) {
					// 1개 레코드를 저장할 BoardBean 객체 생성
					Master_news_DTO news_DTO = new Master_news_DTO();
					// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
					news_DTO.setNum(rs.getInt("num"));
					news_DTO.setNickname(rs.getString("nickname"));
					news_DTO.setPass(rs.getString("pass"));
					news_DTO.setSubject(rs.getString("subject"));
					news_DTO.setContent(rs.getString("content"));
					news_DTO.setCreate_date(rs.getDate("create_date"));
					news_DTO.setReadcount(rs.getInt("readcount"));
					
					// 전체 레코드를 저장하는 ArrayList 객체에 1개 레코드가 저장된 BoardBean 객체 추가
					newsList.add(news_DTO);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("SQL 구문 오류 - selectBoardList()");
			} finally {
				close(rs);
				close(pstmt);
				close(con);
			}
			
			return newsList;
		}
		
		// 가능하면 하고 싶은 부분인데 굳이 없어도 되는 부분이긴하다
		// 현재 존재하는 test_master_news 테이블 내의 같은 닉넴이 있는 지 판별하는 것인데 지금 아는 지식으로는
		// 불가능할꺼 같다. - 안될꺼 같으면 삭제하면 됨
		public String selectNickname(Master_news_DTO news_DTO) {
			String selectNickname = "";
			con = JdbcUtil.getConnection();
			try {
				String sql = "SELECT * FROM test_master_news";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, news_DTO.getNickname());
				
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
}
