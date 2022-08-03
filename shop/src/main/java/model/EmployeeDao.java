package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import vo.Employee;

public class EmployeeDao {
	public Employee login(Employee employee) throws Exception {
		Employee loginEmployee = null;
		String sql = "SELECT employee_id employeeId, employee_name employeeName FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			rs = stmt.executeQuery();
			if (rs.next()) {
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(rs.getString("employeeId"));
				loginEmployee.setEmployeeName(rs.getString("employeeId"));
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
		return loginEmployee;
	}
}
