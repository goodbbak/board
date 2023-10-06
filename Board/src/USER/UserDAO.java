package USER;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstat;
	private ResultSet rs;

	// 생성자는 인스턴스를 생성할 때 자동으로 실행되는 부분
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/board";
			String dbID = "root";
			String dbPW = "password";

			Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL에 접속할 수 있도록 하는
														// 매개체(라이브러리)
			conn = DriverManager.getConnection(dbURL, dbID, dbPW); // 매개변수를 통해 DB에 접속할 수 있도록 함.접속이 완료되면 conn객체에 접속정보가 담기게 됨.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String userID, String userPW) {
		String SQL = "SELECT userPW FROM USER WHERE userID = ?";

		try {
			pstat = conn.prepareStatement(SQL);
			pstat.setString(1, userID); // 1번째 물음표에 userID를 대입
			rs = pstat.executeQuery(); // 쿼리 실행 결과를 담는 변수

			if (rs.next()) { // 쿼리 실행 결과 데이터가 존재하면 해당 영역이 실행
				if (rs.getString(1).equals(userPW)) { // 쿼리실행 결과의 1번째 값이 userPW와 같다면
					return 1; // 로그인 성공
				} else
					return 0; // 로그인 실패(비밀번호 불일치)
			}

			return -1; // ID가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}

		return -2; // -2는 데이터베이스 오류를 의미함.
	}

	public int join(String userID, String userPW, String userName,
			String userGender, String userEmail) {

		String SQL = "SELECT userID FROM user WHERE userID = ?";

		try {
			pstat = conn.prepareStatement(SQL);
			pstat.setString(1, userID);
			rs = pstat.executeQuery(); // 쿼리 실행 결과는 담는 변수
			if (rs.next()) { // 쿼리 실행 결과 데이터가 존재하면(중복된아이디라면)해당 영역이 실행
				return -1; // 아이디 중복
			} else {
				SQL = "SELECT userID FROM user WHERE userEmail = ?";
				pstat = conn.prepareStatement(SQL);
				pstat.setString(1, userEmail);
				rs = pstat.executeQuery(); // 쿼리 실행 결과는 담는 변수
				if (rs.next()) { // 회원가입시 등록한 이메일이 조회 된다면
					return 0; // 이메일 중복
				} else { // 아이디, 이메일 모두 중복 아닌경우
					SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?)";
					pstat = conn.prepareStatement(SQL);
					pstat.setString(1, userID);
					pstat.setString(2, userPW);
					pstat.setString(3, userName);
					pstat.setString(4, userGender);
					pstat.setString(5, userEmail);
					int rs = pstat.executeUpdate(); // insert update delete는 executeQuery 아닌 Update사용
													
					if (rs > 0) {
						return 1; // 회원가입 완료
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // -2는 데이터베이스 오류를 의미함.
	}
}