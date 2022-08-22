<%@page import="service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");

	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String orderState = request.getParameter("orderState");
	
	//
	System.out.println(orderNo);
	System.out.println(orderState);
	
	Orders orders = new Orders();
	OrdersService ordersService = new OrdersService();
	
	orders.setOrderNo(orderNo);
	orders.setOrderState(orderState);
	
	boolean result = ordersService.modifyOrdersState(orders);
	
	
	response.sendRedirect(request.getContextPath() + "/admin/adminOrderList.jsp");
	
%>