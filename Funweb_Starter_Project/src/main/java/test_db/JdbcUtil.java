package test_db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JdbcUtil {
	// DB에 연결하는 작업의 반복이 많아서 메서드 형식으로 사용하여 꺼내서 쓰도록 생성
	public static Connection getConnection() {
		// 연결할 드라이브, url, user, pass를 멤버변수에 저장하여 바로 쓸 수 있도록 해둔다.
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/test_exam";
		String user = "root";
		String password = "1234";
		
		// connection값을 멤버변수로 null값을 초기화
		Connection con = null;
		
		// 필요 구문 작성시 오류가 발생하는데 이 부분은 오류가 혹시나 날 수도 있기 때문에 try-catch구문 사용
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
		// 사용한 connection을 다시 반환해야하는 작업이 반복되기 때문에 ststic으로 작성한다.
		public static void close(Connection con) {
			// con의 값이 null이라면 반환할 자원이 없기때문에 null이 아닐때만 자원을 반환하는 작업을 한다.
			if(con != null) {
				// 사용할 자원반환이 오류가 걸릴 수도 있기 때문에 try/catch로 수정
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		// PreparedStatement자원을 반환하여야하는데 그때에 connection자원을 반환할때와 변수명을 달리하지 않고 오버로딩으로 작성
		public static void close(PreparedStatement pstmt) {
			// pstmt의 값이 null값이 아닐때만 자원을 반환할 수 있도록 하기 위한 작업
			if(pstmt != null) {
				// 마찬가지로 예외의 상황 발생시 동작이 멈출 수 있기 때문에 사전에 방지하고자 try/catch 활용
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		// 클래스에서 받아와 출력에 사용되는 필수 작업인 Resultset의 자원을 반환할 메서드
		public static void close(ResultSet rs) {
			if(rs != null) {
				// 자원 반환 메서드인 close()가 예기치 못한 오류를 만나 적용되지 않을 수도 있기 때문에 오류발생
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
	}
}
