package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.Employee;

public class EmployeeDao {
	// active 변경
	public int updateEmployeeActive(Connection conn, Employee employee) throws SQLException {
		int row = 0;
		String sql = "UPDATE employee SET active=? WHERE employee_id=?";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getActive());
			stmt.setString(2, employee.getEmployeeId());

			row = stmt.executeUpdate();
		} finally {
			// 디버깅
			System.out.println("row : " + row);

			if (stmt != null) {
				stmt.close();
			}
		}
		return row;

	}

	// 페이징,상품리스트 마지막 페이지
	public int selectEmployeeLastPage(Connection conn, int rowPerPage) throws SQLException {
		String sql = "SELECT COUNT(*) FROM employee";
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

	// 사원리스트
	public ArrayList<Employee> selectEmployeeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		ArrayList<Employee> list = new ArrayList<Employee>();

		String sql = "SELECT employee_id, employee_pass, employee_name, update_date, create_date, active FROM employee LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);

			rs = stmt.executeQuery();

			while (rs.next()) {
				Employee employee = new Employee();
				employee.setEmployeeId(rs.getString("employee_id"));
				employee.setEmployeeName(rs.getString("employee_name"));
				employee.setEmployeePass(rs.getString("employee_pass"));
				employee.setUpdateDate(rs.getString("update_date"));
				employee.setCreateDate(rs.getString("create_date"));
				employee.setActive(rs.getString("active"));
				list.add(employee);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;

	}

	// 회원가입
	public int  insertEmployee(Connection conn, Employee paraEmployee) throws SQLException {
		int row = 0;
		//
		System.out.println(paraEmployee + " <-- Dao/paraEmployee");
		String sql = "INSERT INTO employee(employee_id, employee_pass, employee_name, update_date, create_date) VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paraEmployee.getEmployeeId());
			stmt.setString(2, paraEmployee.getEmployeePass());
			stmt.setString(3, paraEmployee.getEmployeeName());
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 탈퇴
	// EmployeeService.removeEmployee가 호출
	public int deleteEmployee(Connection conn, Employee paramEmployee) throws SQLException {
		// insertOutId와 동일한 conn을 써야함
		// conn.close() X

		int row = 0;
		System.out.println(paramEmployee + " <-- Dao/paramEmployee");

		String sql = "DELETE FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			row = stmt.executeUpdate();
			//
			System.out.println(row+" <-- Dao/row" );
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 로그인
	public Employee selectEmployeeByIdAndPw(Connection conn, Employee login) throws Exception {
		Employee employee = null;

		String sql = "SELECT employee_id employeeId, employee_name employeeName FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, login.getEmployeeId());
			stmt.setString(2, login.getEmployeePass());
			rs = stmt.executeQuery();
			if (rs.next()) {
				employee = new Employee();
				employee.setEmployeeId(rs.getString("employeeId"));
				employee.setEmployeeName(rs.getString("employeeName"));
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return employee;
	}
}
