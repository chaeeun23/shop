package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Customer;

public class CustomerDao {
	// 회원가입
	public int insertCustomer(Connection conn, Customer paraCustomer) throws SQLException {
		int row = 0;
		//
		System.out.println(paraCustomer + " <-- Dao/customer");
		String sql = "INSERT INTO customer(customer_id, customer_pass, customer_name, customer_address, customer_detail_address, customer_telephone, update_date, create_date) VALUES(?,PASSWORD(?),?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paraCustomer.getCustomerId());
			stmt.setString(2, paraCustomer.getCustomerPass());
			stmt.setString(3, paraCustomer.getCustomerName());
			stmt.setString(4, paraCustomer.getCustomerAddress());
			stmt.setString(5, paraCustomer.getCustomerDetailAddress());
			stmt.setString(6, paraCustomer.getCustomerTelephone());
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 탈퇴
	// CustomerService.removeCustomer가 호출
	public int deleteCustomer(Connection conn, Customer paraCustomer) throws SQLException {
		// insertOutId와 동일한 conn을 써야함
		// conn.close() X
		int row = 0;
		//
		System.out.println(paraCustomer + " <-- Dao/customer");

		String sql = "DELETE FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paraCustomer.getCustomerId());
			stmt.setString(2, paraCustomer.getCustomerPass());
			row = stmt.executeUpdate();
			//
			System.out.println(row);
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

//////////////////////////////////////////////////////////////////////////////
	public Customer selectCustomerByIdAndPw(Connection conn, Customer login) throws Exception {
		Customer customer = null;

		String sql = "SELECT customer_id customerId, customer_name customerName FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, login.getCustomerId());
			stmt.setString(2, login.getCustomerPass());
			rs = stmt.executeQuery();
			if (rs.next()) {
				customer = new Customer();
				customer.setCustomerId(rs.getString("customerId"));
				customer.setCustomerName(rs.getString("customerName"));
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return customer;
	}

	// 마지막 페이지
	public int selectCustomerLastPage(Connection conn, int rowPerPage) throws SQLException {
		String sql = "SELECT COUNT(*) FROM customer";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				totalCount = rs.getInt("COUNT(*)");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return totalCount;
	}

	// 고객 리스트
	public List<Customer> selectCustomerList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		List<Customer> list = new ArrayList<Customer>();
		
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_detail_address customerDetailAddress, customer_telephone customerTelephone, create_date createDate FROM customer ORDER BY create_date LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Customer customer = new Customer();
				customer.setCustomerId(rs.getString("customerId"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setCustomerAddress(rs.getString("customerAddress"));
				customer.setCustomerDetailAddress(rs.getString("customerDetailAddress"));
				customer.setCustomerTelephone(rs.getString("customerTelephone"));
				customer.setCreateDate(rs.getString("createDAte"));
				list.add(customer);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				rs.close();
			}
		}
		return list;
	}

}
