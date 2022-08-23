<%@page import="service.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="repository.*"%>
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
//
System.out.println(employee.toString());

EmployeeService employeeService = new EmployeeService();
Employee loginEmployee =  employeeService.getEmployeeByIdAndPw(employee);

session.setAttribute("loginEmployee", loginEmployee);

if (session.getAttribute("loginEmployee") == null) { // 로그인실패
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=login Fail");
} else { //로그인성공
	session.setAttribute("user", "employee");
	session.setAttribute("id", loginEmployee.getEmployeeId());
	session.setAttribute("pw", loginEmployee.getEmployeePass());
	session.setAttribute("name", loginEmployee.getEmployeeName());
	session.setAttribute("active", loginEmployee.getActive());
	//
	//
	System.out.println(session.getAttribute("loginEmployee") + " <--loginEmployee");
	System.out.println(employee.getActive() + " <--active1");
	System.out.println(session.getAttribute("active") + " <--active2");
	
	
	response.sendRedirect(request.getContextPath() + "/admin/adminEmployeeIndex.jsp");
}
%>