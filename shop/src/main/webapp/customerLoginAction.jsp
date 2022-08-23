<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="repository.*"%>
<%@page import="vo.*"%>
<%
request.setCharacterEncoding("utf-8");

String customerId = request.getParameter("customerId");
String customerPass = request.getParameter("customerPass");
//디버깅
System.out.println(customerId+" <--customerId");
System.out.println(customerPass+" <--customerPass");

Customer customer = new Customer();
customer.setCustomerId(customerId);
customer.setCustomerPass(customerPass);
//
System.out.println(customer.toString());

CustomerService customerService = new CustomerService();
Customer loginCustomer =  customerService.getCustomerByIdAndPw(customer);

session.setAttribute("loginCustomer", loginCustomer);

if (session.getAttribute("loginCustomer") == null) { // 로그인실패
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=login Fail");
} else { //로그인성공
	//session.setAttribute("loginCustomer", loginCustomer);
	session.setAttribute("user", "customer");
	session.setAttribute("id", loginCustomer.getCustomerId());
	session.setAttribute("name", loginCustomer.getCustomerName());
	
	//
	System.out.println(session.getAttribute("id") + " <--id");
	System.out.println(session.getAttribute("name") + " <--name");
	
	response.sendRedirect(request.getContextPath() + "/index.jsp");
}

%>