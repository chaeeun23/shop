<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.*"%>
<%
request.setCharacterEncoding("utf-8");

Customer customer = new Customer();

String customerId = request.getParameter("customerId");
String customerPass = request.getParameter("customerPass");
//
System.out.println(customerId + " <-- Action/customerId");
System.out.println(customerPass + " <-- Action/customerPass");

customer.setCustomerId(customerId);
customer.setCustomerPass(customerPass);

CustomerService customerService = new CustomerService();
customerService.removeCustomer(customer);



response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
%>