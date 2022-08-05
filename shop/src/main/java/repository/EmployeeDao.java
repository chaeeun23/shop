package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import service.DBUtil;
import vo.Customer;
import vo.Employee;

public class EmployeeDao {
	//회원가입
		public boolean insertEmployee(Connection conn, Employee employee) throws SQLException {
			int row = 0;
			//
			System.out.println(employee + " <-- Dao/employee");
			String sql = "INSERT INTO employee(employee_id, employee_pass, employee_name, update_date, create_date) VALUES(?,?,?,NOW(),NOW())";
			PreparedStatement stmt = null;
			try {
				stmt =conn.prepareStatement(sql);
				stmt.setString(1, employee.getEmployeeId());
				stmt.setString(2, employee.getEmployeePass());
				stmt.setString(3, employee.getEmployeeName());
				row = stmt.executeUpdate();
			}finally {
				if(stmt!=null) {
					stmt.close();
				}
			}
			return true;
		}
	// 탈퇴
	// EmployeeService.removeEmployee(Employee employee)가 호출
	public int deleteEmployee(Connection conn, Employee employee) throws SQLException {
		// insertOutId와 동일한 conn을 써야함
		// conn.close() X

		int row = 0;
		System.out.println(employee + " <-- Dao/employee");

		String sql = "DELETE FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
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

	// 로그인
	public Employee selectEmployeeByIdAndPw(Connection conn, Employee employee) throws Exception {
		Employee loginEmployee = null;

		String sql = "SELECT employee_id employeeId, employee_name employeeName FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			rs = stmt.executeQuery();
			if (rs.next()) {
			loginEmployee = new Employee();
			loginEmployee.setEmployeeId(rs.getString("employeeId"));
			loginEmployee.setEmployeeName(rs.getString("employeeName"));
			}
		} finally {
			if(rs!=null)   {
				rs.close();
			}
			if(stmt!=null) {
				stmt.close();
			}
		}
		return loginEmployee;
	}
}
