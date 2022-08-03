package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Customer;

public class CustomerDao {
	public Customer login(Customer customer) throws Exception {
		Customer loginCustomer = null;
		String sql = "SELECT customer_id customerId, customer_name customerName FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			rs = stmt.executeQuery();
			loginCustomer = new Customer();
			if (rs.next()) {
				loginCustomer.setCustomerId(rs.getString("customerId"));
				loginCustomer.setCustomerName(rs.getString("customerName"));
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		//
		System.out.println(rs.getString("customerId")+"<--");
		System.out.println(rs.getString("customerName")+"<--");
		return loginCustomer;
	}
}
