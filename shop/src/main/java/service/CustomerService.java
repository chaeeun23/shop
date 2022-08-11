package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.CustomerDao;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {
	private CustomerDao customerDao;
	
	//회원가입(insert)
	public boolean addCustomer(Customer paramCustomer) {
		boolean result = true;
		//
		System.out.println(paramCustomer + " <-- CustomerService/paramCustomer");

		Connection conn=null;
		try {
			conn=new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			CustomerDao customerDao = new CustomerDao();
			if(customerDao.insertCustomer(conn, paramCustomer) != 1) {
				result = false;
				throw new Exception();	
			}
			conn.commit();
		}catch (Exception e) {
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
		return result;
	}
	// 탈퇴(delete)
	public void removeCustomer(Customer paramCustomer) {
		//
		System.out.println(paramCustomer + " <-- customerService/paramCustomer");

		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋 안되게 잠금

			CustomerDao customerDao = new CustomerDao();
			if (customerDao.deleteCustomer(conn, paramCustomer) == 1) {
				OutIdDao outIdDao = new OutIdDao();
				if (outIdDao.insertOutId(conn, paramCustomer.getCustomerId()) != 1) {
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
	public Customer getCustomerByIdAndPw(Customer paraCustomer ) {
		Connection conn = null;
		Customer customer  = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeQuery()실행시 자동 커밋 안되게 잠금

			CustomerDao customerDao = new CustomerDao();
			customer  = customerDao.selectCustomerByIdAndPw(conn, paraCustomer);
			if (customer  == null) {
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
		return customer ;
	}
	
	
}
