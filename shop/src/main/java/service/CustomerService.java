package service;

import java.sql.*;

import repository.CustomerDao;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {
	// 탈퇴
	public void removeCustomer(Customer customer) {
		//
		System.out.println(customer + " <-- service/customer");

		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋 안되게 잠금

			CustomerDao customerDao = new CustomerDao();
			if (customerDao.deleteCustomer(conn, customer) == 1) {
				OutIdDao outIdDao = new OutIdDao();
				if (outIdDao.insertOutId(conn, customer.getCustomerId()) != 1) {
					throw new Exception();
				}
			}

			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // 예외메세지를 콘솔에 띄움
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// 로그인
	public Customer getCustomerByIdAndPw(Customer customer) {
		Connection conn = null;
		Customer loginCustomer = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeQuery()실행시 자동 커밋 안되게 잠금

			CustomerDao customerDao = new CustomerDao();
			loginCustomer = customerDao.selectCustomerByIdAndPw(conn, customer);
			if (loginCustomer == null) {
				throw new Exception();
			}

			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // 예외메세지를 콘솔에 띄움
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return loginCustomer;
	}
}
