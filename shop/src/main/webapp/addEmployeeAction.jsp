<%@page import="vo.Employee"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String employeeId = request.getParameter("employeeId");
String employeePass = request.getParameter("employeePass");
String employeeName = request.getParameter("employeeName");

Employee employee = new Employee();
employee.setEmployeeId(employeeId);
employee.setEmployeePass(employeePass);
employee.setEmployeeName(employeeName);

EmployeeService employeeService = new EmployeeService();
employeeService.addEmployee(employee);

response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>
