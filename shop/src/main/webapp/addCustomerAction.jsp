<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String customerId = request.getParameter("customerId");
String customerPass = request.getParameter("customerPass");
String customerName = request.getParameter("customerName");
String customerAddress = request.getParameter("customerAddress");
String customerTelephone = request.getParameter("customerTelephone");

Customer customer = new Customer();
customer.setCustomerId(customerId);
customer.setCustomerPass(customerPass);
customer.setCustomerName(customerName);
customer.setCustomerAddress(customerAddress);
customer.setCustomerTelephone(customerTelephone);

CustomerService customerService = new CustomerService();
customerService.addCustomer(customer);

response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>
