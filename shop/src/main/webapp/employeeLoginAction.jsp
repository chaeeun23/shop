<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="vo.*"%>
<%
request.setCharacterEncoding("utf-8");

String employeeId = request.getParameter("employeeId");
String employeePass = request.getParameter("employeePass");

//디버깅
System.out.println(employeeId+" <--employeeId");
System.out.println(employeePass+" <--employeePass");

Employee employee = new Employee();
employee.setEmployeeId(employeeId);
employee.setEmployeePass(employeePass);

EmployeeDao employeeDao = new EmployeeDao();
Employee loginEmployee = employeeDao.login(employee);

if (loginEmployee == null) { // 로그인실패
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=login Fail");
} else { //로그인성공
	//
	System.out.println(employee.getEmployeeName()+"<--employee.getCustomerName()");
	session.setAttribute("loginEmployee", loginEmployee);
	session.setAttribute("user", "employee");
	session.setAttribute("id", loginEmployee.getEmployeeId());
	session.setAttribute("name", loginEmployee.getEmployeeName());
	response.sendRedirect(request.getContextPath() + "/index.jsp");
}
%>