package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CustomerDao;
import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Customer;
import vo.Employee;

public class EmployeeService {
	//회원가입
		public boolean addEmployee(Employee employee) {
			//
			System.out.println(employee + " <-- service/employee");
			Connection conn=null;
			try {
				conn=new DBUtil().getConnection();
				conn.setAutoCommit(false);
				
				EmployeeDao employeeDao = new EmployeeDao();
				if(employeeDao.insertEmployee(conn, employee)) {
					conn.commit();
				};
				
		
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
			return true;
		}
		
		//탈퇴
	public void removeEmployee(Employee employee) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋 안되게 잠금

			EmployeeDao employeeDao = new EmployeeDao();
			if (employeeDao.deleteEmployee(conn, employee) == 1) {
				OutIdDao outIdDao = new OutIdDao();
				if (outIdDao.insertOutId(conn, employee.getEmployeeId()) != 1) {
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
		public Employee getEmployeeByIdAndPw(Employee employee) {
			Connection conn = null;
			Employee loginEmployee = null;
			try {
				conn = new DBUtil().getConnection();
				conn.setAutoCommit(false); // executeQuery()실행시 자동 커밋 안되게 잠금

				EmployeeDao employeeDao = new EmployeeDao();
				loginEmployee = employeeDao.selectEmployeeByIdAndPw(conn, employee);
				if (loginEmployee == null) {
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
			return loginEmployee;
		}
}
