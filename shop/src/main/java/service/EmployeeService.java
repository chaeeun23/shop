package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	// active 변경(update)
	public void modifyEmployeeActive(Employee employee) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao(); 
			if(employeeDao.updateEmployeeActive(conn, employee) != 1) { 
				throw new Exception();
			}
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace();
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

	// 페이징 select
	public ArrayList<Employee> getEmployeeList(int rowPerPage, int currentPage) {

		ArrayList<Employee> list = new ArrayList<Employee>();

		Connection conn = null;
		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // 자동 커밋 막아줌

			EmployeeDao employeeDao = new EmployeeDao();
			list = employeeDao.selectEmployeeList(conn, rowPerPage, beginRow);

			// 디버깅
			System.out.println("list : " + list);

			if (list == null) {
				throw new Exception();
			}

			conn.commit();

		} catch (Exception e) {
			e.printStackTrace();
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
		return list;
	}
	
	// 사원 마지막 페이지
		public int getEmployeeLastPage(int rowPerPage) {
			int lastPage = 0;
			int totalCount = 0;
			Connection conn = null;
			EmployeeDao employeeDao = null;
			
			try {
				conn = new DBUtil().getConnection();
				conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
				
				employeeDao = new EmployeeDao();		 			
				totalCount = employeeDao.selectEmployeeLastPage(conn, rowPerPage);
				
				if(totalCount == 0) { 
					throw new Exception();
				}
				
				lastPage = totalCount / rowPerPage;
				if (totalCount % rowPerPage != 0) {
					lastPage += 1;
				}
				conn.commit();		
			} catch (Exception e) {
				e.printStackTrace(); // console에 예외메세지 출력
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
			return lastPage;
		}

	// 회원가입(insert)
	public boolean addEmployee(Employee paramEmployee) {
		boolean result = true;
		//
		System.out.println(paramEmployee + " <-- EmployeeService/paramEmployee");
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);

			EmployeeDao employeeDao = new EmployeeDao();
			if (employeeDao.insertEmployee(conn, paramEmployee)!=1) {
				result = false;
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
		return result;
	}

	// 탈퇴(delete)
	public void removeEmployee(Employee paramEmployee) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋 안되게 잠금

			EmployeeDao employeeDao = new EmployeeDao();
			if (employeeDao.deleteEmployee(conn, paramEmployee) == 1) {
				OutIdDao outIdDao = new OutIdDao();
				if (outIdDao.insertOutId(conn, paramEmployee.getEmployeeId()) != 1) {
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
	public Employee getEmployeeByIdAndPw(Employee paramEmployee) {
		Connection conn = null;
		Employee employee  = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeQuery()실행시 자동 커밋 안되게 잠금

			EmployeeDao employeeDao = new EmployeeDao();
			employee  = employeeDao.selectEmployeeByIdAndPw(conn, paramEmployee);
			if (employee  == null) {
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
		return employee ;
	}
}
