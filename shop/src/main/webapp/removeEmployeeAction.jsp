<%@page import="vo.Employee"%>
<%@page import="service.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

Employee employee = new Employee();

String employeeId = request.getParameter("employeeId");
String employeePass = request.getParameter("employeePass");
//
System.out.println(employeeId + " <-- Action/employeeId");
System.out.println(employeePass + " <-- Action/employeePass");

employee.setEmployeeId(employeeId);
employee.setEmployeePass(employeePass);

EmployeeService employeeService = new EmployeeService();
employeeService.removeEmployee(employee);



response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
%>