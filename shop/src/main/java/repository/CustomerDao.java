package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import service.CustomerService;
import vo.Customer;

public class CustomerDao {
	//회원가입
	public boolean insertCustomer(Connection conn, Customer customer) throws SQLException {
		int row = 0;
		//
		System.out.println(customer + " <-- Dao/customer");
		String sql = "INSERT INTO customer(customer_id, customer_pass, customer_name, customer_address, customer_telephone, update_date, create_date) VALUES(?,?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		try {
			stmt =conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			stmt.setString(3, customer.getCustomerName());
			stmt.setString(4, customer.getCustomerAddress());
			stmt.setString(5, customer.getCustomerTelephone());
			row = stmt.executeUpdate();
		}finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return true;
	}
	
	// 탈퇴
	// CustomerService.removeCustomer(Customer customer)가 호출
	public int deleteCustomer(Connection conn, Customer customer) throws SQLException {
		// insertOutId와 동일한 conn을 써야함
		// conn.close() X
		int row = 0;
		//
		System.out.println(customer + " <-- Dao/customer");

		String sql = "DELETE FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			row = stmt.executeUpdate();
			//
			System.out.println(row);
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}

	public Customer selectCustomerByIdAndPw(Connection conn, Customer customer) throws Exception {
		Customer loginCustomer = null;

		String sql = "SELECT customer_id customerId, customer_name customerName FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			rs = stmt.executeQuery();
			if (rs.next()) {
			loginCustomer = new Customer();
			loginCustomer.setCustomerId(rs.getString("customerId"));
			loginCustomer.setCustomerName(rs.getString("customerName"));
			}
		} finally {
			if(rs!=null)   {
				rs.close();
			}
			if(stmt!=null) {
				stmt.close();
			}
		}
		return loginCustomer;
	}
	
	
}
