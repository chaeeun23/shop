package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OutIdDao {
	// 탈퇴 회원의 아이디를 입력
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int insertOutId(Connection conn, String customerId) throws SQLException {
		// CustomerDao와 동일한 conn을 써야함
		// conn.close() X
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO outid(out_id, out_date) VALUES (?, now())";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			row = stmt.executeUpdate();
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
}
