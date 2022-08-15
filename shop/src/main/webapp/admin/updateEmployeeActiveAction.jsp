<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%
	String employeeId = request.getParameter("employeeId");
	String active = request.getParameter("active");
	
	System.out.println(employeeId);
	System.out.println(active);
	
	Employee employee = new Employee();
	EmployeeService employeeService = new EmployeeService();
	
	employee.setEmployeeId(employeeId);
	employee.setActive(active);
	
	employeeService.modifyEmployeeActive(employee);
	
	
	response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
%>